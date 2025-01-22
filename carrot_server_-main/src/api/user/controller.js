const repository = require('./repository');
const crypto = require('crypto');
const jwt = require('./jwt');

exports.register = async (req, res) => {
  const { userId, password, name } = req.body;

  const result = await crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512');

  const { affectedRows, insertId } = await repository.register(userId, result.toString('base64'), name);

  if (affectedRows > 0) {
    const data = await jwt({ id: insertId, name });
    res.json({ result: 'ok', access_token: data })
  } else {
    res.json({ result: 'fail', message: '알 수 없는 오류' });
  }
}


exports.login = async (req, res) => {
  const { userId, password } = req.body;

  const result = await crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512');

  const item = await repository.login(userId, result.toString('base64'));

  if (item == null) {
    res.json({ result: 'fail', message: '아이디 혹은 비밀번호를 확인해 주세요.' })
  } else {
    const data = await jwt({ id: item.id, name: item.name });
    res.json({ result: 'ok', access_token: data })
  }
}

exports.show = async (req, res) => {

  const user = req.user; // 미들웨어에서 추가된 사용자 정보
  // 데이터베이스에서 사용자 정보 조회

  const item = await repository.findId(user.id);

  // 사용자 정보가 없을 경우
  if (item == null) {
    res.json({ result: 'fail', message: '회원을 찾을 수 없습니다.' });
  } else {
    // 사용자 정보가 있을 경우
    res.json({ result: 'ok', data: item });
  }
}
exports.update = async (req, res) => {
  const { name } = req.body;
  const user = req.user;

  const result = await repository.update(user.id, name);

  if (result.affectedRows > 0) {
    const item = await repository.findId(user.id);
    res.json({ result: 'ok', data: item });
  } else {
    res.json({ result: 'fail', message: '오류가 발생하였습니다.' });
  }
}
