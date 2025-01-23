const repository = require('./repository')

exports.show = async (req, res) => {
  const item = await repository.show();

  res.json({ result: 'ok', data: item });
}

exports.getCategoryExpenses = async (req, res) => {
  const { categoryId } = req.params;
  const item = await repository.getCategoryExpenses(categoryId);

  res.json({ result: 'ok', data: item });
}

// 새로운 함수 추가
exports.getCategoryById = async (req, res) => {
  try {
    const { categoryId } = req.params;
    const item = await repository.getCategoryById(categoryId);
    if (item) {
      res.json({ result: 'ok', data: item });
    } else {
      res.status(404).json({ result: 'error', message: 'Category not found' });
    }
  } catch (e) {
    res.status(500).json({ result: 'error', message: `Error fetching category: ${e.message}` });
  }
};