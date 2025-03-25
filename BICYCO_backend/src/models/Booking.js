const pool = require('../config/db');

const Booking = {
    async createTable() {
        const query = `
        CREATE TABLE IF NOT EXISTS bookings (
            id SERIAL PRIMARY KEY,
            user_id INT REFERENCES users(id) ON DELETE CASCADE,
            cycle_id INT REFERENCES cycles(id) ON DELETE CASCADE,
            start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            end_time TIMESTAMP,
            status VARCHAR(20) DEFAULT 'active',  -- 'active', 'completed', 'late'
            fine_amount DECIMAL(10, 2) DEFAULT 0,
            UNIQUE (user_id, cycle_id, status)  -- Removing invalid WHERE clause
        );`;
        await pool.query(query);
        console.log("✅ Bookings table is ready");
    },

    async createBooking(userId, cycleId) {
        const query = `
        INSERT INTO bookings (user_id, cycle_id) 
        VALUES ($1, $2) RETURNING *;
        `;
        const values = [userId, cycleId];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async completeBooking(bookingId, endTime, fineAmount = 0) {
        const query = `
        UPDATE bookings 
        SET end_time = $1, status = 'completed', fine_amount = $2
        WHERE id = $3 RETURNING *;
        `;
        const values = [endTime, fineAmount, bookingId];
        const result = await pool.query(query, values);
        return result.rows[0];
    },

    async getActiveBookingsByUser(userId) {
        const query = `SELECT * FROM bookings WHERE user_id = $1 AND status = 'active';`;
        const result = await pool.query(query, [userId]);
        return result.rows;
    }
};

module.exports = Booking;
