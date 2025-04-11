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
            fine_amount DECIMAL(10, 2) DEFAULT 0
        );`;
        await pool.query(query);
    
        // Apply unique constraint only for active bookings
        await pool.query(`
            CREATE UNIQUE INDEX IF NOT EXISTS unique_active_booking 
            ON bookings(user_id, cycle_id) 
            WHERE status = 'active';
        `);
    
        console.log("✅ Bookings table is ready");
    }
    ,

    async createBooking(userId, cycleId) {
        // Check if the latest booking is still active
        const latestBooking = await pool.query(
            `SELECT * FROM bookings 
             WHERE user_id = $1 AND cycle_id = $2 
             ORDER BY start_time DESC LIMIT 1`,
            [userId, cycleId]
        );
    
        if (latestBooking.rows.length > 0 && latestBooking.rows[0].status === 'active') {
            throw new Error("You already have an active booking for this cycle.");
        }
    
        // Insert new booking
        const query = `
        INSERT INTO bookings (user_id, cycle_id, status) 
        VALUES ($1, $2, 'active') RETURNING *;
        `;
        const result = await pool.query(query, [userId, cycleId]);
    
        return result.rows[0];
    }
    
    ,

    async completeBooking(bookingId, endTime, fineAmount = 0) {
        console.log(`🔍 Completing booking with ID: ${bookingId}`);
    
        const query = `
        UPDATE bookings 
        SET end_time = $1, status = 'completed', fine_amount = $2
        WHERE id = $3 AND status = 'active'
        RETURNING *;
        `;
        
        const values = [endTime, fineAmount, bookingId];
        const result = await pool.query(query, values);
    
        console.log("🔍 Booking Completion Result:", result.rows);
    
        if (result.rows.length === 0) {
            throw new Error("Booking not found or already completed.");
        }
    
        // Update cycle status to 'available'
        const cycleId = result.rows[0].cycle_id;
        console.log(`🔍 Updating cycle ID: ${cycleId} to 'available'`);
        await pool.query(`UPDATE cycles SET status = 'available' WHERE id = $1`, [cycleId]);
    
        return result.rows[0];
    }
    
    
    ,

    async getActiveBookingsByUser(userId) {
        const query = `SELECT * FROM bookings WHERE user_id = $1 AND status = 'active';`;
        const result = await pool.query(query, [userId]);
        return result.rows;
    }
};

module.exports = Booking;
