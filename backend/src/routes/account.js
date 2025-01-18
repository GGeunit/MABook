const express = require('express');
const accountController = require('../controllers/account');
const authMiddleware = require('../middleware/auth');
const router = express.Router();

router.post('/', authMiddleware, accountController.createAccount);
router.get('/', authMiddleware, accountController.getAccounts);
router.put('/:id', authMiddleware, accountController.updateAccount);
router.delete('/:id', authMiddleware, accountController.deleteAccount);

module.exports = router;