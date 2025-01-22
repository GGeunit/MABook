const { pool } = require('../../database')

exports.show = async () => {
  const query = `SELECT * FROM category`;

  const [result] = await pool.query(query);
  return (result.length === 0) ? null : result;
}