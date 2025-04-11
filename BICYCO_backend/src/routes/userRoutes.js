const express = require('express');
const router = express.Router();
const UserController = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');

// User Registration
router.post('/register', UserController.registerUser);

// User Login
router.post('/login', UserController.loginUser);

// Get User Profile (Protected Route)
router.get('/profile', authMiddleware, UserController.getUserProfile);

module.exports = router;
