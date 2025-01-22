const { pool } = require('../../database')

exports.register = async (userId, password, name) => {
  const query = `INSERT INTO user (user_id, password, name) VALUES (?,?,?)`;
  return await pool.query(query, [userId, password, name]);
}

exports.login = async (userId, password) => {
  const query = `SELECT * FROM user WHERE user_id = ? AND password = ?`;
  let result = await pool.query(query, [userId, password]);
  return (result.length < 0) ? null : result[0];
}

// exports.findByPhone = async (phone) => {
//   let result = await pool.query(`SELECT count(*) count FROM user where phone = ?`, [phone]);
//   return (result.length < 0) ? null : result[0];
// }
exports.findId = async (id) => {
  const result = await pool.query(`SELECT id, name FROM user WHERE id = ?`, [`${id}`]);
  return (result.length < 0) ? null : result[0];
}
exports.update = async (id, name) => {
  const query = `UPDATE user SET name = ? WHERE id = ?`;
  return await pool.query(query, [name, id]);
<<<<<<< HEAD
}
=======
}
>>>>>>> cb14c44f45d442c68ffb7a5f007fcddf52603efe
