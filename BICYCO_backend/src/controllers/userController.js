const User = require('../models/User');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
require('dotenv').config();

const UserController = {
    async registerUser(req, res) {
        try {
            const { name, email, password, role } = req.body;

            // Check if user already exists
            const existingUser = await User.findByEmail(email);
            if (existingUser) return res.status(400).json({ message: "Email already registered" });

            // Register new user
            const newUser = await User.registerUser(name, email, password, role);
            res.status(201).json(newUser);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async loginUser(req, res) {
        try {
            const { email, password } = req.body;

            // Find user by email
            const user = await User.findByEmail(email);
            if (!user) return res.status(400).json({ message: "Invalid credentials" });

            // Check password
            const isMatch = await bcrypt.compare(password, user.password);
            if (!isMatch) return res.status(400).json({ message: "Invalid credentials" });

            // Generate JWT token
            const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET, { expiresIn: '7d' });
            res.json({ token, user: { id: user.id, name: user.name, email: user.email, role: user.role } });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    },

    async getUserProfile(req, res) {
        try {
            const userId = req.user.id;
            const user = await User.findByEmail(req.user.email);
            if (!user) return res.status(404).json({ message: "User not found" });

            res.json({ id: user.id, name: user.name, email: user.email, role: user.role });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    }
};

module.exports = UserController;
