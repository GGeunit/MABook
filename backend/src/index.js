require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const userRoutes = require('./routes/user');
const accountRoutes = require('./routes/account');
const expenseRoutes = require('./routes/expense');
const regularExpenseRoutes = require('./routes/regularExpense');
const goalRoutes = require('./routes/goal');
const authMiddleware = require('./middleware/auth'); // 인증 미들웨어

const app = express();

// CORS 설정 추가
app.use(cors());
app.use(bodyParser.json());

// 라우트 설정
app.use('/users', userRoutes);
app.use('/accounts', authMiddleware, accountRoutes);
app.use('/expenses', authMiddleware, expenseRoutes);
app.use('/regular-expenses', authMiddleware, regularExpenseRoutes);
app.use('/goals', authMiddleware, goalRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});