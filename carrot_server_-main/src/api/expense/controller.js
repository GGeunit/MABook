const repository = require('./repository')

exports.index = async (req, res) => {
  const { page = 1, size = 10, keyword = '' } = req.query;
  const userId = req.user.id; // 현재 로그인한 사용자의 ID

  // 사용자 입력에서 불필요한 공백을 제거하고, 대소문자 구분 없이 검색하기 위해 소문자로 변환
  const trimmedKeyword = keyword.trim().toLowerCase();

  const items = await repository.index(page, size, trimmedKeyword);

  const modifiedItems = items.map(item => ({
    ...item,
    is_me: (userId == item.user_id),
    category: {
      id: item.category_id,
      name: item.category_name
    }
  }));

  res.json({ result: 'ok', data: modifiedItems });
}

exports.store = async (req, res) => {
  const { description, price, date, category } = req.body;
  const categoryId = parseInt(category.id);
  const user = req.user;

  const result = await repository.create(user.id, categoryId, description, price, date);

  if (result.affectedRows > 0) {
    res.json({ result: 'ok', data: result.insertId });
  } else {
    res.json({ result: 'fail', message: '오류가 발생하였습니다.' });
  }
}

exports.show = async (req, res) => {
  const id = req.params.id;
  const user = req.user;

  const item = await repository.show(id);

  const modifiedItem = {
    ...item,
    writer: {
      id: item.user_id,
      name: item.user_name
    },
    category: {
      id: item.category_id,
      name: item.category_name
    },
    is_me: (user.id == item.user_id)
  };

  delete modifiedItem.user_id;
  delete modifiedItem.user_name;
  delete modifiedItem.category_id;
  delete modifiedItem.category_name;

  res.json({ result: 'ok', data: modifiedItem });
}

exports.update = async (req, res) => {
  const id = req.params.id;
  const { description, price, category, date } = req.body;
  const user = req.user;
  const formattedDate = date.split('T')[0];

  const item = await repository.show(id);

  if (user.id !== item.user_id) {
    return res.json({ result: 'fail', message: '타인의 글을 수정할 수 없습니다.' });
  }

  const result = await repository.update(description, price, category.id, formattedDate, id);

  if (result.affectedRows > 0) {
    res.json({ result: 'ok', data: { id, description, price, category, date } });
  } else {
    res.json({ result: 'fail', message: '오류가 발생하였습니다.' });
  }
}

exports.delete = async (req, res) => {
  const id = req.params.id;
  const user = req.user;

  const item = await repository.show(id);

  if (user.id !== item.user_id) {
    res.json({ result: 'fail', message: '타인의 글을 삭제 할수 없습니다.' })
  } else {
    await repository.delete(id);
    res.json({ result: "ok", data: id });
  }
}

