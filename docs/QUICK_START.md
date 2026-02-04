# Quick Start Guide

Get your development environment ready in 15 minutes!

## ⚡ 5-Minute Setup

### Step 1: Clone Repository
```powershell
git clone https://github.com/yourusername/developer-environment-setup.git
cd developer-environment-setup
```

### Step 2: Run Setup Script
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\scripts\setup.ps1
```

### Step 3: Restart PowerShell
Close and reopen PowerShell completely.

### Step 4: Verify Installation
```powershell
.\scripts\verify-installation.ps1
```

## ✅ You're Done!

Your development environment is now ready. See the next section for first projects.

---

## 🚀 First Projects

### Node.js Project
```powershell
# Create project directory
mkdir my-express-app
cd my-express-app

# Initialize Node.js project
npm init -y

# Install Express
npm install express

# Create app.js
@"
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Express!');
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
"@ | Out-File app.js

# Run the app
node app.js
```

Visit `http://localhost:3000` in your browser.

### Python Project
```powershell
# Create project directory
mkdir my-flask-app
cd my-flask-app

# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# Install Flask
pip install flask

# Create app.py
@"
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello from Flask!'

if __name__ == '__main__':
    app.run(debug=True)
"@ | Out-File app.py

# Run the app
python app.py
```

Visit `http://localhost:5000` in your browser.

---

## 📦 Using Project Templates

### Express.js Template
```powershell
cp -r templates/express-starter my-api
cd my-api
npm install
npm start
```

### FastAPI Template
```powershell
cp -r templates/fastapi-starter my-api
cd my-api
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload
```

---

## 🐳 Using Docker & Databases

### Start All Databases
```powershell
docker-compose up -d
```

### View Running Containers
```powershell
docker ps
```

### Connect to PostgreSQL
```powershell
docker-compose exec postgres psql -U postgres
```

### View Logs
```powershell
docker-compose logs -f postgres
```

### Stop All Containers
```powershell
docker-compose down
```

---

## 📚 Learn More

- [Node.js Documentation](https://nodejs.org/docs/)
- [Express.js Guide](https://expressjs.com/)
- [Python Documentation](https://docs.python.org/3/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Docker Documentation](https://docs.docker.com/)

---

## 🆘 Troubleshooting

### Tools not found after setup
1. Close all PowerShell windows
2. Open a new PowerShell window
3. Try again

### Permission denied errors
Run PowerShell as Administrator

### Docker daemon not running
1. Open Docker Desktop
2. Wait for startup
3. Try again

See [Troubleshooting Guide](../docs/TROUBLESHOOTING.md) for more help.

---

**Next Steps:**
1. ✅ Run setup
2. ✅ Try a project template
3. ✅ Read the documentation
4. ✅ Start building!

Good luck! 🚀
