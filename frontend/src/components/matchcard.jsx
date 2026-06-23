import Tooltip from "./tooltip";

function MatchCard({ partida, agentImages, onClick }) {
  const getResultadoStyle = (resultado) => {
    if (resultado === "Vitória") {
      return {
        label: "Vitória",
        indicator: "bg-green-500",
        badge: "border-green-500/30 bg-green-500/10 text-green-300",
      };
    }

    if (resultado === "Empate") {
      return {
        label: "Empate",
        indicator: "bg-yellow-500",
        badge: "border-yellow-500/30 bg-yellow-500/10 text-yellow-300",
      };
    }

    return {
      label: "Derrota",
      indicator: "bg-red-500",
      badge: "border-red-500/30 bg-red-500/10 text-red-300",
    };
  };

  const getKdColor = (kdr) => {
    const kd = Number(kdr);

    if (Number.isNaN(kd)) return "text-white";
    if (kd >= 1) return "text-green-400";

    return "text-red-400";
  };

  const resultadoStyle = getResultadoStyle(partida.resultado);
  const agentImage = agentImages[partida.agente];
  const kdColor = getKdColor(partida.kdr);

  return (
    <article
      onClick={onClick}
      className="group relative overflow-visible cursor-pointer"
    >
      <div className="relative overflow-visible rounded-2xl border border-gray-800 bg-gray-950/80 p-3 transition-all hover:-translate-y-0.5 hover:border-gray-700 hover:bg-gray-900/90 hover:shadow-xl hover:shadow-black/30">
        {/* indicador lateral */}
        <div
          className={`absolute left-0 top-4 bottom-4 w-1 rounded-r-full ${resultadoStyle.indicator}`}
        />

        <div className="relative z-10 flex flex-col gap-3 lg:flex-row lg:items-center">
          <div className="flex min-w-0 flex-1 items-center gap-4 pl-2">
            {/* agente */}
            <div className="relative h-20 w-20 flex-shrink-0 overflow-hidden rounded-2xl border border-gray-700 bg-gray-900">
              {agentImage ? (
                <img
                  src={agentImage}
                  alt={partida.agente}
                  className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-110"
                />
              ) : (
                <div className="flex h-full w-full items-center justify-center text-2xl font-semibold text-gray-500">
                  {partida.agente?.[0] || "?"}
                </div>
              )}
            </div>

            <div className="min-w-0">
              <div className="mb-2 flex flex-wrap items-center gap-2">
                <span
                  className={`rounded-full border px-3 py-1 text-xs font-semibold ${resultadoStyle.badge}`}
                >
                  {resultadoStyle.label}
                </span>

                <span className="rounded-full border border-gray-800 bg-black/30 px-3 py-1 text-xs text-gray-400">
                  {partida.modo || "Competitive"}
                </span>
              </div>

              <h3 className="truncate text-xl font-semibold tracking-tight text-white">
                {partida.mapa || "Mapa desconhecido"}
              </h3>

              <p className="mt-1 truncate text-sm text-gray-500">
                {partida.agente || "Agente"}
              </p>
            </div>
          </div>

          {/* estatísticas */}
          <div className="relative z-20 grid grid-cols-2 gap-3 overflow-visible sm:grid-cols-5 lg:min-w-[560px]">
            <MiniStat
              label="KDA"
              value={`${partida.kills}/${partida.deaths}/${partida.assists}`}
              tooltip="Abates, Mortes e Assistências nessa partida."
            />

            <MiniStat
              label="K/D"
              value={partida.kdr ?? "—"}
              valueClassName={kdColor}
              tooltip="Média de Abates por Morte nessa partida."
            />

            <MiniStat
              label="ACS"
              value={partida.acs ?? "—"}
              tooltip="Pontuação de Combate nessa partida."
            />

            <MiniStat
              label="HS%"
              value={`${partida.headshot_percent ?? "—"}%`}
              tooltip="Porcentagem de tiros na cabeça nessa partida."
            />

            <MiniStat
              label="FB"
              value={partida.first_bloods ?? "—"}
              tooltip="Quantidade de primeiros abates."
            />
          </div>
        </div>
      </div>
    </article>
  );
}

function MiniStat({ label, value, tooltip, valueClassName = "text-white" }) {
  return (
    <div className="relative overflow-visible rounded-xl border border-gray-800 bg-black/25 px-3 py-3 text-center">
      <p className={`text-sm font-semibold ${valueClassName}`}>{value}</p>

      <p className="mt-1 text-[10px] font-semibold uppercase tracking-[0.16em] text-gray-500">
        {tooltip ? (
          <Tooltip text={tooltip}>
            <span className="border-b border-dotted border-gray-600">
              {label}
            </span>
          </Tooltip>
        ) : (
          label
        )}
      </p>
    </div>
  );
}

export default MatchCard;
