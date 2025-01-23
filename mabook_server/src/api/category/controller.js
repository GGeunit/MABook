const repository = require('./repository')

exports.show = async (req, res) => {
  const item = await repository.show();

  res.json({ result: 'ok', data: item });
}