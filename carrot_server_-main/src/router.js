const express = require('express');
const router = express.Router();

const cors = require('cors');

const multer = require('multer');
const upload = multer({ dest: 'storage/' });
const authenticateToken = require('./middleware/authenticate');

const webController = require('./web/controller');
const categoryController = require('./api/category/controller');
const expenseController = require('./api/expense/controller');
const userController = require('./api/user/controller');
// const fileController = require('./api/file/controller');

const { logRequestTime } = require('./middleware/log');


router.get('/', webController.home);
router.get('/page/:route', logRequestTime, webController.page);

router.get('/category', categoryController.show);

router.use(logRequestTime);

router.use(cors());

// router.post('/file', upload.single('file'), fileController.upload);
// router.get('/file/:id', fileController.download);


// router.post('/auth/phone', apiUserController.phone);
// router.put('/auth/phone', apiUserController.phoneVerify);
router.post('/user/register', userController.register);
router.post('/user/login', userController.login);

router.use(authenticateToken);

router.get('/user/my', userController.show);
router.put('/user/my', userController.update);

router.get('/api/expense', expenseController.index);
router.post('/api/expense', expenseController.store);
router.get('/api/expense/:id', expenseController.show);
router.put('/api/expense/:id', expenseController.update);
router.delete('/api/expense/:id', expenseController.delete);

module.exports = router;

