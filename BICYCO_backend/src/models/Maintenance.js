const pool = require('../config/db');

const Maintenance = {
    async createTable() {
        const query = `
        CREATE TABLE IF NOT EXISTS maintenance (
            id SERIAL PRIMARY KEY,
            cycle_id INT REFERENCES cycles(id) ON DELETE CASCADE,
            reported_by INT REFERENCES users(id) ON DELETE SET NULL,
            issue_description TEXT NOT NULL,
            status VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'in_progress', 'resolved'
            reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            resolved_at TIMESTAMP
        );`;
        await pool.query(query);
        console.log("✅ Maintenance table is ready");
    },

    async reportIssue(cycleId, userId, issueDescription) {
        const query = `
        INSERT INTO maintenance (cycle_id, reported_by, issue_description) 
        VALUES ($1, $2, $3) RETURNING *;
        `;
        const values = [cycleId, userId, issueDescription];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async updateStatus(issueId, status, resolvedAt = null) {
        const query = `
        UPDATE maintenance 
        SET status = $1, resolved_at = $2
        WHERE id = $3 RETURNING *;
        `;
        const values = [status, resolvedAt, issueId];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async getPendingIssues() {
        const query = `SELECT * FROM maintenance WHERE status = 'pending';`;
        const result = await pool.query(query);
        return result.rows;
    }
};

module.exports = Maintenance;
