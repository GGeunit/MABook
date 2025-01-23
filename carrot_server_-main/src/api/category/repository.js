const { pool } = require('../../database')

exports.show = async () => {
  const query = `SELECT * FROM category`;

  const [result] = await pool.query(query);
  return (result.length === 0) ? null : result;
}

 // 특정 카테고리의 지출 항목 조회
exports.getCategoryExpenses = async (categoryId) =>{
  const query = `
    SELECT e.id, e.description, e.price, e.date 
    FROM expense e 
    WHERE e.category_id = ?
  `;
  const [result] = await pool.query(query, [categoryId]);
  return result.length === 0 ? null : result;
}

