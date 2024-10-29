function Home() {
  return (
    <div className="App">
      <div className="moving-background"></div> {/* Background for animation */}

      {/* Heading section */}
      <h1>Empowering DevOps</h1>

      {/* Add the logo image */}
      <img 
        src="https://mail.google.com/mail/u/0?ui=2&ik=0a9cd0fd67&attid=0.1&permmsgid=msg-a:r5636363533169762311&th=192be9341460f80f&view=att&disp=safe&realattid=f_m2navo3t0" 
        alt="AI Logo" 
        className="App-logo" // Use your existing logo class
        style={{ width: '300px', height: 'auto', marginTop: '20px' }}
      />
      
      {/* Subheading and description */}
      <h2>Build, Test, and Deploy Seamlessly with IaC-Driven CI/CD</h2>
      <h2>Welcome to the CI/CD Pipeline Application</h2>
      <p>
        This application demonstrates the use of continuous integration and deployment pipelines using GitHub Actions and Azure. 
        Explore the app to learn more about CI/CD practices and Infrastructure as Code (IaC) principles.
      </p>
      
    
      {/* Add an unordered list to showcase items */}
      <h3>Key Features:</h3>
      <p>Automated CI/CD pipelines</p>
      <p>GitHub Actions integration</p>
      <p>Azure cloud services</p>
      <p>Infrastructure as Code (IaC) with Bicep and ARM templates</p>
      <p>Scalable, secure and maintainable solutions</p>

      <ul style={{ padding: '10px', backgroundColor: 'rgba(0, 0, 0, 0.7)', listStyleType: 'disc', color: 'white', border: '1px solid white'}}>
      </ul>
     {/* Add a button that could navigate to another page */}
    
     <button onClick={() => window.location.href = "/about"}>
        Learn More About Us
     </button>
    </div>
  );
}

export default Home;
