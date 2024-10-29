import React from 'react';
import './App.css';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import Home from './homePage'; // Import the Home component
import About from './About';

// Main App component
function App() {
  return (
    <Router>
      <nav>
        <Link to="/Home">Home</Link> 
    

      </nav>
      <Routes>
        <Route path="/" element={<Home />} />

      </Routes>
    </Router>
  );
}

export default App;
