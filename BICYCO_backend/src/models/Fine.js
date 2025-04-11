const pool = require('../config/db');

const Fine = {
    async createTable() {
        const query = `
        CREATE TABLE IF NOT EXISTS fines (
            id SERIAL PRIMARY KEY,
            user_id INT REFERENCES users(id) ON DELETE CASCADE,
            booking_id INT REFERENCES bookings(id) ON DELETE CASCADE,
            amount DECIMAL(10, 2) NOT NULL,
            paid BOOLEAN DEFAULT FALSE,
            issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );`;
        await pool.query(query);
        console.log("✅ Fines table is ready");
    },

    async issueFine(bookingId, amount) {
        // Fetch the correct user_id from the bookings table
        const bookingResult = await pool.query(
            `SELECT user_id FROM bookings WHERE id = $1`,
            [bookingId]
        );
    
        if (bookingResult.rows.length === 0) {
            throw new Error("Booking not found.");
        }
    
        const userId = bookingResult.rows[0].user_id;
        console.log(`🔍 Issuing fine for user_id: ${userId}, booking_id: ${bookingId}, amount: ${amount}`);
    
        // Insert fine with the correct user_id
        const query = `
        INSERT INTO fines (user_id, booking_id, amount) 
        VALUES ($1, $2, $3) RETURNING *;
        `;
        const result = await pool.query(query, [userId, bookingId, amount]);
        
        return result.rows[0];
    }
    ,

    async markFineAsPaid(fineId) {
        const query = `
        UPDATE fines SET paid = TRUE WHERE id = $1 RETURNING *;
        `;
        const result = await pool.query(query, [fineId]);
        return result.rows[0];
    },

    async getUnpaidFines(userId) {
        const query = `SELECT * FROM fines WHERE user_id = $1 AND paid = FALSE;`;
        const result = await pool.query(query, [userId]);
        return result.rows;
    }
};

module.exports = Fine;
