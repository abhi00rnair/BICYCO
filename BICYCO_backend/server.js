const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
require('dotenv').config();

// Database Connection
const pool = require('./src/config/db');

// Models (Ensuring Tables Exist)
const User = require('./src/models/User');
const Cycle = require('./src/models/Cycle');
const Booking = require('./src/models/Booking');
const Fine = require('./src/models/Fine');
const Maintenance = require('./src/models/Maintenance');

// Create Tables on Startup
(async () => {
    await User.createTable();
    await Cycle.createTable();
    await Booking.createTable();
    await Fine.createTable();
    await Maintenance.createTable();
})();

// Initialize Express App
const app = express();

// Middleware
app.use(express.json());  // Parse JSON requests
app.use(cors());          // Enable CORS
app.use(helmet());        // Secure HTTP headers
app.use(morgan('dev'));   // Logger for requests

// Default Route
app.get('/', (req, res) => {
    res.send('🚴 BICYCO API is running...');
});

// Import and Use Routes
const userRoutes = require('./src/routes/userRoutes');
const cycleRoutes = require('./src/routes/cycleRoutes');
const bookingRoutes = require('./src/routes/bookingRoutes');
const fineRoutes = require('./src/routes/fineRoutes');
const maintenanceRoutes = require('./src/routes/maintenanceRoutes');

app.use('/api/users', userRoutes);
app.use('/api/cycles', cycleRoutes);
app.use('/api/bookings', bookingRoutes);
app.use('/api/fines', fineRoutes);
app.use('/api/maintenance', maintenanceRoutes);

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`🚀 Server running on port ${PORT}`);
});
