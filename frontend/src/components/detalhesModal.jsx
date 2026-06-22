function DetalhesModal({ partida, detalhes, loading, onClose }) {
  if (!partida) return null

  const dados = detalhes?.detalhes
  const players = dados?.players || []

  const redPlayers = players.filter((player) => player.team === "Red")
  const bluePlayers = players.filter((player) => player.team === "Blue")

  const redTeam = dados?.teams?.red
  const blueTeam = dados?.teams?.blue

  const roundsPlayed = dados?.metadata?.rounds_played || partida.rounds_played || 1

  return (
    <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/80 px-4 backdrop-blur-sm">
      <div className="relative max-h-[90vh] w-full max-w-5xl overflow-y-auto rounded-2xl border border-gray-800 bg-gray-950 shadow-2xl shadow-black/60">
        
        <div className="sticky top-0 z-20 border-b border-gray-800 bg-gray-950/95 px-6 py-5 backdrop-blur">
          <div className="flex items-start justify-between gap-4">
            <div>
              <div className="mb-2 flex flex-wrap items-center gap-2">
                <span className="rounded-full border border-gray-800 bg-black/40 px-3 py-1 text-xs text-gray-400">
                  {partida.modo || "Competitive"}
                </span>

                <span
                  className={`rounded-full border px-3 py-1 text-xs font-bold ${
                    partida.resultado === "Vitória"
                      ? "border-green-500/30 bg-green-500/10 text-green-300"
                      : partida.resultado === "Empate"
                        ? "border-yellow-500/30 bg-yellow-500/10 text-yellow-300"
                        : "border-red-500/30 bg-red-500/10 text-red-300"
                  }`}
                >
                  {partida.resultado}
                </span>
              </div>

              <h2 className="text-2xl font-black text-white">
                {partida.mapa || "Mapa desconhecido"}
              </h2>

              <p className="mt-1 text-sm text-gray-400">
                Jogando de{" "}
                <span className="font-semibold text-gray-300">
                  {partida.agente || "Agente"}
                </span>
              </p>
            </div>

            <button
              onClick={onClose}
              className="rounded-xl border border-gray-700 bg-gray-900 px-3 py-2 text-sm font-bold text-gray-300 transition-colors hover:bg-gray-800 hover:text-white"
            >
              ✕
            </button>
          </div>
        </div>

        {loading ? (
          <div className="flex min-h-80 items-center justify-center">
            <p className="text-gray-400">Carregando detalhes da partida...</p>
          </div>
        ) : !dados ? (
          <div className="flex min-h-80 items-center justify-center px-6 text-center">
            <div>
              <p className="font-semibold text-gray-300">
                Detalhes da partida não encontrados.
              </p>
              <p className="mt-1 text-sm text-gray-500">
                Atualize o jogador para salvar os detalhes dessa partida.
              </p>
            </div>
          </div>
        ) : (
          <div className="space-y-6 p-6">
            
            <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
              <ScoreCard
                title="Time Red"
                rounds={redTeam?.rounds_won ?? "—"}
                won={redTeam?.has_won}
                color="red"
              />

              <div className="flex items-center justify-center rounded-2xl border border-gray-800 bg-black/30 p-5">
                <div className="text-center">
                  <p className="text-xs font-bold uppercase tracking-[0.2em] text-gray-500">
                    Placar
                  </p>
                  <p className="mt-1 text-3xl font-black text-white">
                    {redTeam?.rounds_won ?? "—"} - {blueTeam?.rounds_won ?? "—"}
                  </p>
                  <p className="mt-1 text-sm text-gray-500">
                    {roundsPlayed} rounds
                  </p>
                </div>
              </div>

              <ScoreCard
                title="Time Blue"
                rounds={blueTeam?.rounds_won ?? "—"}
                won={blueTeam?.has_won}
                color="blue"
              />
            </div>

            <div className="grid grid-cols-1 gap-5 lg:grid-cols-2">
              <TeamTable
                title="Time Red"
                players={redPlayers}
                color="red"
                roundsPlayed={roundsPlayed}
              />

              <TeamTable
                title="Time Blue"
                players={bluePlayers}
                color="blue"
                roundsPlayed={roundsPlayed}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  )
}

function ScoreCard({ title, rounds, won, color }) {
  const colorClasses =
    color === "red"
      ? "border-red-500/30 bg-red-500/10 text-red-300"
      : "border-blue-500/30 bg-blue-500/10 text-blue-300"

  return (
    <div className={`rounded-2xl border p-5 ${colorClasses}`}>
      <p className="text-xs font-bold uppercase tracking-[0.2em] opacity-80">
        {title}
      </p>

      <div className="mt-2 flex items-end justify-between gap-3">
        <p className="text-3xl font-black">{rounds}</p>

        <span className="rounded-full border border-current px-3 py-1 text-xs font-bold">
          {won ? "Venceu" : "Perdeu"}
        </span>
      </div>
    </div>
  )
}

function TeamTable({ title, players, color, roundsPlayed }) {
  const titleColor = color === "red" ? "text-red-300" : "text-blue-300"

  return (
    <div className="overflow-hidden rounded-2xl border border-gray-800 bg-black/25">
      <div className="border-b border-gray-800 px-4 py-3">
        <h3 className={`font-black ${titleColor}`}>{title}</h3>
      </div>

      <div className="divide-y divide-gray-800">
        {players.map((player) => {
          const kills = player.stats?.kills || 0
          const deaths = player.stats?.deaths || 0
          const assists = player.stats?.assists || 0

          const totalShots =
            (player.stats?.headshots || 0) +
            (player.stats?.bodyshots || 0) +
            (player.stats?.legshots || 0)

          const hs =
            totalShots > 0
              ? ((player.stats?.headshots / totalShots) * 100).toFixed(1)
              : "0.0"

          return (
            <div
              key={player.puuid}
              className="grid grid-cols-[1fr_auto] gap-4 px-4 py-3 transition-colors hover:bg-white/[0.03]"
            >
              <div className="min-w-0">
                <p className="truncate font-bold text-white">
                  {player.name}
                  <span className="font-normal text-gray-500">
                    #{player.tag}
                  </span>
                </p>

                <p className="mt-0.5 truncate text-xs text-gray-500">
                  {player.character || "Agente"} ·{" "}
                  {player.currenttier_patched || "Rank indisponível"}
                </p>
              </div>

              <div className="grid grid-cols-4 gap-3 text-right text-sm">
                <MiniValue label="KDA" value={`${kills}/${deaths}/${assists}`} />
                <MiniValue label="ACS" value={calcAcs(player, roundsPlayed)} />
                <MiniValue label="DMG" value={player.damage_made || 0} />
                <MiniValue label="HS%" value={`${hs}%`} />
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}

function MiniValue({ label, value }) {
  return (
    <div>
      <p className="font-black text-white">{value}</p>
      <p className="text-[10px] font-bold uppercase tracking-wider text-gray-600">
        {label}
      </p>
    </div>
  )
}

function calcAcs(player, roundsPlayed) {
  const score = player.stats?.score || 0
  return score > 0 && roundsPlayed > 0
    ? Math.round(score / roundsPlayed)
    : "—"
}

export default DetalhesModal