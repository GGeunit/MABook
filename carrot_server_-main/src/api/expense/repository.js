const { pool } = require('../../database')

exports.index = async (page, size, keyword) => {
  const offset = (page - 1) * size;

  let query = `
    SELECT e.*, c.name AS category_name, u.name AS user_name 
    FROM expense e
    LEFT JOIN category c ON e.category_id = c.id
    LEFT JOIN user u ON e.user_id = u.user_id
  `;

  const params = [];

  if (keyword) {
    query += ` WHERE LOWER(c.name) LIKE ? OR LOWER(e.description) LIKE ?`;
    const keywordParam = `%${keyword.toLowerCase()}%`;
    params.push(keywordParam, keywordParam);
  }

  query += ` ORDER BY e.id DESC LIMIT ? OFFSET ?`;
  params.push(size.toString(), offset.toString());

  return await pool.query(query, params);
}

exports.create = async (userId, categoryId, description, price, date) => {
  const query = `INSERT INTO expense (user_id, category_id, description, price, date) VALUES (?, ?, ?, ?, ?)`;
  return await pool.query(query, [userId, categoryId, description, price, date]);
}

exports.show = async (id) => {
  const query = `
    SELECT e.*, c.name AS category_name, u.name AS user_name
    FROM expense e
    LEFT JOIN category c ON e.category_id = c.id
    LEFT JOIN user u ON e.user_id = u.user_id
    WHERE e.id = ?
  `;
  let result = await pool.query(query, [id]);
  return (result.length === 0) ? null : result[0];
}

exports.update = async (description, price, date, categoryId, id) => {
  const query = `UPDATE expense SET description = ?, price = ?, date = ?, category_id = ? WHERE id = ?`;
  const params = [description, price, date, categoryId, id];
  return await pool.query(query, params);
}

exports.delete = async id => {
  return await pool.query(`DELETE FROM expense WHERE id = ?`, [id]);
}
