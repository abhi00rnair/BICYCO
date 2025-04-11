const pool = require('../config/db');

const Cycle = {
    async createTable() {
        const query = `
        CREATE TABLE IF NOT EXISTS cycles (
            id SERIAL PRIMARY KEY,
            cycle_number VARCHAR(50) UNIQUE NOT NULL,
            status VARCHAR(20) DEFAULT 'available',  -- 'available', 'booked', 'maintenance'
            location VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );`;
        await pool.query(query);
        console.log("✅ Cycles table is ready");
    },

    async addCycle(cycleNumber, location) {
        const query = `
        INSERT INTO cycles (cycle_number, location) 
        VALUES ($1, $2) RETURNING *;
        `;
        const values = [cycleNumber, location];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async getAvailableCycles() {
        const query = `SELECT * FROM cycles WHERE status = 'available';`;
        const result = await pool.query(query);
        return result.rows;
    },

    async updateCycleStatus(id, status) {
        console.log(`🔍 Updating cycle ID: ${id} to status: ${status}`);
    
        const query = `UPDATE cycles SET status = $1 WHERE id = $2 RETURNING *;`;
        const values = [status, id];
        const result = await pool.query(query, values);
    
        if (result.rows.length === 0) {
            throw new Error(`Cycle ID ${id} not found or status update failed.`);
        }
    
        console.log("✅ Cycle Status Updated:", result.rows[0]);
        return result.rows[0];
    }
    
};

module.exports = Cycle;
