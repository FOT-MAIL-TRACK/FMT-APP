const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');

// Load environment variables
dotenv.config();

// Initialize app
const app = express();

// Middleware to parse JSON
app.use(express.json());

app.use(cors()); 

// Connect to MongoDB 
mongoose.connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.log(err));



// Import routes
const authRoutes = require('./routes/auth');
const trackingRoutes = require('./routes/tracking');

// Use routes
app.use('/api/auth', authRoutes);


// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
