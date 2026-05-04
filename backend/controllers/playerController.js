const playerService = require('../services/playerService');

async function getPlayer(req, res) {
  const { region, name, tag } = req.params;

  try {
    const data = await playerService.getPlayerData(region, name, tag);
    res.status(200).json({ success: true, data });
  } catch (err) {
    console.error('Erro completo:', err); // ← já tinha isso?
    res.status(err.status || 500).json({ success: false, message: err.message });
  }
}

async function updatePlayer(req, res) {
  const { region, name, tag } = req.params;

  try {
    const data = await playerService.getPlayerData(region, name, tag, true);
    res.status(200).json({ success: true, data });
  } catch (err) {
    console.error('Erro no updatePlayer:', err);
    res.status(err.status || 500).json({ success: false, message: err.message });
  }
}

module.exports = { getPlayer, updatePlayer };