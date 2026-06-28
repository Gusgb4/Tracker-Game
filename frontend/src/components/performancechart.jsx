import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

function PerformanceChart({ partidas = [] }) {
  const dados = [...partidas]
    .reverse()
    .map((partida, index) => {
      const score =
        partida.performance_score ??
        partida.desempenho_score ??
        partida.score_desempenho ??
        partida.performanceScore ??
        null;

      return {
        partida: index + 1,
        label: `P${index + 1}`,
        score: Number(score),
        mapa: partida.mapa || "Mapa desconhecido",
        agente: partida.agente || "Agente",
        resultado: partida.resultado || "Resultado",
      };
    })
    .filter((item) => Number.isFinite(item.score));

  if (dados.length === 0) {
    return (
      <section className="rounded-2xl border border-gray-800 bg-gray-950/80 p-6">
        <h2 className="text-xl font-bold text-white">Evolução de Score</h2>
        <p className="mt-1 text-sm text-gray-400">
          Ainda não há dados suficientes para gerar o gráfico.
        </p>
      </section>
    );
  }

  const mediaScore = calcularMediaScore(dados);
  const corPrincipal = getScoreColor(mediaScore);

  return (
    <section className="rounded-2xl border border-gray-800 bg-gray-950/80 p-6">
      <div className="mb-5 flex flex-wrap items-end justify-between gap-3">
        <div>
          <h2 className="text-xl font-bold text-white">Evolução de Score</h2>
          <p className="text-sm text-gray-400">
            Performance Score nas últimas {dados.length} partidas competitivas.
          </p>
        </div>

        <span className="rounded-full border border-gray-800 bg-black/30 px-3 py-1 text-xs text-gray-400">
          Score Médio: {Math.round(mediaScore)} • {dados.length} partidas
        </span>
      </div>

      <div className="h-72 w-full">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart
            data={dados}
            margin={{
              top: 10,
              right: 10,
              left: -20,
              bottom: 0,
            }}
          >
            <CartesianGrid strokeDasharray="3 3" stroke="#1f2937" />

            <XAxis
              dataKey="label"
              tick={{ fill: "#9ca3af", fontSize: 12 }}
              axisLine={{ stroke: "#374151" }}
              tickLine={{ stroke: "#374151" }}
            />

            <YAxis
              domain={[0, 100]}
              tick={{ fill: "#9ca3af", fontSize: 12 }}
              axisLine={{ stroke: "#374151" }}
              tickLine={{ stroke: "#374151" }}
            />

            <Tooltip content={<CustomTooltip corPrincipal={corPrincipal} />} />

            <Line
              type="monotone"
              dataKey="score"
              stroke={corPrincipal}
              strokeWidth={3}
              dot={{
                r: 4,
                fill: corPrincipal,
                stroke: "#020617",
                strokeWidth: 2,
              }}
              activeDot={{
                r: 6,
                fill: corPrincipal,
                stroke: "#020617",
                strokeWidth: 2,
              }}
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </section>
  );
}

function CustomTooltip({ active, payload, corPrincipal }) {
  if (!active || !payload || payload.length === 0) return null;

  const item = payload[0].payload;

  return (
    <div className="rounded-xl border border-gray-700 bg-gray-950/95 px-4 py-3 shadow-xl">
      <p className="text-xs font-semibold uppercase tracking-[0.14em] text-gray-500">
        Partida {item.partida}
      </p>

      <p className="mt-1 text-sm font-semibold text-white">
        {item.mapa} • {item.agente}
      </p>

      <p className="mt-1 text-xs text-gray-400">{item.resultado}</p>

      <p className="mt-2 text-sm font-semibold" style={{ color: corPrincipal }}>
        Score: {Math.round(item.score)}
      </p>
    </div>
  );
}

function getScoreColor(score) {
  const valor = Number(score);

  if (!Number.isFinite(valor)) return "#ffffff";

  if (valor >= 80) return "#60a5fa";
  if (valor >= 60) return "#4ade80";
  if (valor >= 40) return "#facc15";
  if (valor >= 20) return "#fb923c";

  return "#ef4444";
}

function calcularMediaScore(dados) {
  if (!dados.length) return 0;

  const total = dados.reduce((acc, item) => acc + item.score, 0);

  return total / dados.length;
}

export default PerformanceChart;
