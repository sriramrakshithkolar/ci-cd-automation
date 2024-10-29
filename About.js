import React from 'react';
import './App.css';  // Importing the global CSS file for styling

function About() {
  return (
    <div className="App">
      <h1>About This Application</h1>
      <p>
        This application is a demonstration of a Single Page Application (SPA) built using React.
        It leverages React Router to navigate between pages without reloading the entire application.
        The goal is to show how Continuous Integration and Continuous Deployment (CI/CD) pipelines
        can be set up using GitHub Actions and Azure as the cloud platform.
      </p>
      <p>
        Technologies used in this application:
      </p>
      {/* <ul>
        <li>React</li>
        <li>React Router</li>
        <li>GitHub Actions</li>
        <li>Azure</li>
      </ul> */}
      <p>
        Explore the application to learn more about implementing a CI/CD pipeline using Infrastructure as Code (IaC) principles.
      </p>
    </div>
  );
}

export default About;
