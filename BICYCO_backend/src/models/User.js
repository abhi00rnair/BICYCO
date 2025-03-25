const { Pool } = require('pg');
const pool = require('../config/db');
const bcrypt = require('bcryptjs');

const User = {
    async createTable() {
        const query = `
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) UNIQUE NOT NULL,
            password TEXT NOT NULL,
            role VARCHAR(50) DEFAULT 'student',  -- 'student', 'admin'
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );`;
        await pool.query(query);
        console.log("✅ Users table is ready");
    },

    async registerUser(name, email, password, role = 'student') {
        const hashedPassword = await bcrypt.hash(password, 10);
        const query = `
        INSERT INTO users (name, email, password, role) 
        VALUES ($1, $2, $3, $4) RETURNING id, name, email, role;
        `;
        const values = [name, email, hashedPassword, role];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async findByEmail(email) {
        const query = `SELECT * FROM users WHERE email = $1;`;
        const result = await pool.query(query, [email]);
        return result.rows[0];
    }
};

module.exports = User;
