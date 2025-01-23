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

exports.logout = async (req, res) => {
  res.json({ result: 'ok' });
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

exports.changePassword = async (req, res) => {
  console.log('Request Body:', req.body); // 디버깅 로그 추가
  const { current_password, new_password } = req.body;
  const user = req.user;

  console.log('User:', user); // 디버깅 로그 추가

  // 입력값 검증
  if (!current_password || !new_password) {
    console.log('Validation failed: current_password or new_password is missing'); // 디버깅 로그 추가
    return res.status(400).json({ result: 'fail', message: '현재 비밀번호와 새로운 비밀번호를 입력해야 합니다.' });
  }

  try {
    // 현재 비밀번호 해시화
    const currentPasswordHash = crypto.pbkdf2Sync(current_password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');
    console.log('Current Password Hash:', currentPasswordHash); // 디버깅 로그 추가

    const userRecord = await repository.login(user.user_id, currentPasswordHash);
    console.log('User Record:', userRecord); // 디버깅 로그 추가

    if (userRecord == null) {
      return res.status(400).json({ result: 'fail', message: '현재 비밀번호가 일치하지 않습니다.' });
    }

    // 새로운 비밀번호 해시화
    const newPasswordHash = crypto.pbkdf2Sync(new_password, process.env.SALT_KEY, 50, 100, 'sha512').toString('base64');
    console.log('New Password Hash:', newPasswordHash); // 디버깅 로그 추가

    // 비밀번호 변경
    const result = await repository.changePassword(user.id, newPasswordHash);
    console.log('Change Password Result:', result); // 디버깅 로그 추가

    if (result.affectedRows > 0) {
      res.status(200).json({ result: 'ok', message: '비밀번호가 변경되었습니다.' });
    } else {
      console.log('Password change failed, no rows affected'); // 디버깅 로그 추가
      res.status(500).json({ result: 'fail', message: '비밀번호 변경에 실패했습니다.' });
    }
  } catch (error) {
    console.error('비밀번호 변경 중 오류 발생:', error);
    res.status(500).json({ result: 'fail', message: '서버 오류가 발생했습니다.' });
  }
};