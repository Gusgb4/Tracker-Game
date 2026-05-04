const fetch = require('node-fetch');
const jogadorRepository = require('../repositories/jogadorRepository');
const partidaRepository = require('../repositories/partidaRepository');

const BASE_URL = 'https://api.henrikdev.xyz/valorant';
const API_KEY = process.env.HENRIK_API_KEY;
const headers = { 'Authorization': API_KEY };

async function getPlayerData(region, name, tag, forceUpdate = false) {

  let jogador = await jogadorRepository.findByRiotId(name, tag);
  const precisaAtualizar = !jogador || forceUpdate || dadosExpirados(jogador.atualizado_em);

  if (!precisaAtualizar) {
    const partidas = await partidaRepository.findByJogadorId(jogador.id);
    const ultimas5 = partidas.slice(0, 5);
    return {
      fonte: 'banco',
      jogador,
      partidas: ultimas5,
      stats: calcularEstatisticas(partidas)
    };
  }

  const [accountRes, mmrRes, matchesRes, allMatchesRes] = await Promise.all([
    fetch(`${BASE_URL}/v1/account/${name}/${tag}`, { headers }),
    fetch(`${BASE_URL}/v2/mmr/${region}/${name}/${tag}`, { headers }),
    fetch(`${BASE_URL}/v3/matches/${region}/${name}/${tag}?size=5&mode=competitive`, { headers }),
    fetch(`${BASE_URL}/v3/matches/${region}/${name}/${tag}?size=50&mode=competitive`, { headers })
  ]);

  if (accountRes.status === 404) {
    const err = new Error('Jogador não encontrado');
    err.status = 404;
    throw err;
  }

  if (!accountRes.ok || !mmrRes.ok || !matchesRes.ok) {
    const err = new Error('Erro ao consultar a API do Valorant');
    err.status = 502;
    throw err;
  }

  const account = await accountRes.json();
  const mmr = await mmrRes.json();
  const matches = await matchesRes.json();
  const allMatches = allMatchesRes.ok ? await allMatchesRes.json() : { data: [] };
  const puuid = account.data.puuid;

  if (!jogador) {
    const id = await jogadorRepository.create(name, tag, puuid);
    jogador = { id, riot_name: name, riot_tag: tag, puuid };
  } else {
    await jogadorRepository.update(jogador.id, mmr.data?.current_data?.currenttierpatched);
  }

  if (allMatches.data && allMatches.data.length > 0) {
    for (const match of allMatches.data) {
      const jogadorDaPartida = match.players?.all_players?.find(p => p.puuid === puuid);
      await partidaRepository.upsert({
        jogador_id: jogador.id,
        match_id: match.metadata.matchid,
        mapa: match.metadata.map,
        modo: match.metadata.mode,
        agente: jogadorDaPartida?.character || null,
        kills: jogadorDaPartida?.stats?.kills || 0,
        deaths: jogadorDaPartida?.stats?.deaths || 0,
        assists: jogadorDaPartida?.stats?.assists || 0,
        kdr: jogadorDaPartida?.stats?.deaths > 0
          ? (jogadorDaPartida.stats.kills / jogadorDaPartida.stats.deaths).toFixed(2)
          : jogadorDaPartida?.stats?.kills || 0,
        resultado: match.teams?.red?.has_won === true ? 'Vitória' : 'Derrota',
        data_partida: new Date(match.metadata.game_start * 1000)
      });
    }
  }

  const todasPartidas = await partidaRepository.findByJogadorId(jogador.id);
  const ultimas5 = todasPartidas.slice(0, 5);

  return {
    fonte: 'api',
    account: account.data,
    mmr: mmr.data,
    partidas: ultimas5,
    stats: calcularEstatisticas(todasPartidas)
  };
}

function dadosExpirados(atualizado_em) {
  if (!atualizado_em) return true;
  const diff = Date.now() - new Date(atualizado_em).getTime();
  return diff > 30 * 60 * 1000;
}

function calcularEstatisticas(partidas) {
  if (!partidas || partidas.length === 0) return null;

  const total = partidas.length;
  const vitorias = partidas.filter(p => p.resultado === 'Vitória').length;
  const kills = partidas.reduce((acc, p) => acc + (p.kills || 0), 0);
  const deaths = partidas.reduce((acc, p) => acc + (p.deaths || 0), 0);
  const assists = partidas.reduce((acc, p) => acc + (p.assists || 0), 0);

  return {
    total_partidas: total,
    vitorias,
    derrotas: total - vitorias,
    winrate: ((vitorias / total) * 100).toFixed(1) + '%',
    kdr_geral: deaths > 0 ? (kills / deaths).toFixed(2) : kills,
    kills_totais: kills,
    deaths_totais: deaths,
    assists_totais: assists
  };
}

module.exports = { getPlayerData };