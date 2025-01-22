const express = require('express');
const router = express.Router();

const multer = require('multer');
const upload = multer({ dest: 'storage/' });
const authenticateToken = require('./middleware/authenticate');

const webController = require('./web/controller');
const expenseController = require('./expense/controller');
const userController = require('./user/controller');
// const fileController = require('./api/file/controller');

const { logRequestTime } = require('./middleware/log');


router.get('/', webController.home);
router.get('/page/:route', logRequestTime, webController.page);

router.use(logRequestTime);

// router.post('/file', upload.single('file'), fileController.upload);
// router.get('/file/:id', fileController.download);


// router.post('/auth/phone', apiUserController.phone);
// router.put('/auth/phone', apiUserController.phoneVerify);
router.post('/user/register', userController.register);
router.post('/user/login', userController.login);

router.use(authenticateToken);

router.get('/user/my', userController.show);
router.put('/user/my', userController.update);

router.get('/expense', expenseController.index);
router.post('/expense', expenseController.store);
router.get('/expense/:id', expenseController.show);
router.put('/expense/:id', expenseController.update);
router.delete('/expense/:id', expenseController.delete);

module.exports = router;
