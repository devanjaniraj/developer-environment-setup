# 🐍 Python Development Setup

Complete guide to setting up and working with Python in your development environment.

## Prerequisites

- Python 3.11+ installed
- pip package manager installed
- VS Code (optional but recommended)
- Basic command line knowledge

## Getting Started

### Verify Installation

```powershell
python --version       # Check Python version
pip --version          # Check pip version
python -m pip list     # List installed packages
```

### Create Your First Project

```powershell
# Create project directory
mkdir my-python-project
cd my-python-project

# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# Deactivate when done
deactivate
```

---

## Virtual Environments

### Why Use Virtual Environments?

Virtual environments isolate project dependencies, preventing conflicts between projects.

### Create Virtual Environment

```powershell
# Create venv
python -m venv venv

# Activate (Windows)
venv\Scripts\activate

# Activate (Mac/Linux)
source venv/bin/activate

# Deactivate
deactivate
```

### Verify Virtual Environment

```powershell
# Should show path to venv
where python

# Or check pip location
pip --version
```

---

## Essential pip Commands

### Package Management

```powershell
# Install package
pip install requests

# Install specific version
pip install requests==2.28.0

# Install from requirements file
pip install -r requirements.txt

# Install multiple packages
pip install flask django requests

# Upgrade package
pip install --upgrade requests
pip install -U requests

# Uninstall package
pip uninstall requests
```

### Information Commands

```powershell
# List installed packages
pip list

# Show package details
pip show requests

# Search for package
pip search requests

# Check outdated packages
pip list --outdated
```

### Requirements Management

```powershell
# Create requirements file
pip freeze > requirements.txt

# Install from requirements
pip install -r requirements.txt

# Update requirements
pip freeze > requirements.txt
```

---

## Basic Python

### Hello World

```powershell
@"
# Create hello.py
print('Hello, Python!')
print('Welcome to development!')
"@ | Out-File hello.py

# Run script
python hello.py
```

### Variables & Types

```python
# Strings
name = "John"
greeting = 'Hello'
multiline = """This is
a multiline
string"""

# Numbers
age = 30
height = 5.9
temperature = -10

# Booleans
is_active = True
is_admin = False

# Lists
colors = ['red', 'green', 'blue']
numbers = [1, 2, 3, 4, 5]

# Dictionaries
person = {
    'name': 'John',
    'age': 30,
    'city': 'New York'
}

# Tuples (immutable)
coordinates = (10, 20)

# Sets
unique_numbers = {1, 2, 3, 3}  # Removes duplicates
```

### Functions

```python
# Simple function
def greet(name):
    return f"Hello, {name}!"

print(greet("John"))

# Function with default parameter
def add(a, b=0):
    return a + b

print(add(5, 3))  # 8
print(add(5))     # 5

# Function with multiple return values
def get_user_info():
    return "John", 30, "john@example.com"

name, age, email = get_user_info()
```

### Conditionals

```python
age = 25

# If-else
if age >= 18:
    print("Adult")
else:
    print("Minor")

# If-elif-else
if age < 13:
    print("Child")
elif age < 18:
    print("Teen")
else:
    print("Adult")
```

### Loops

```python
# For loop
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

# For loop with list
colors = ['red', 'green', 'blue']
for color in colors:
    print(color)

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
for i in range(10):
    if i == 3:
        continue  # Skip this iteration
    if i == 7:
        break     # Exit loop
    print(i)
```

---

## Popular Packages

### Web Frameworks

```powershell
pip install flask          # Lightweight web framework
pip install django         # Full-featured web framework
pip install fastapi        # Modern async framework
pip install tornado        # Scalable web framework
```

### Database & ORM

```powershell
pip install sqlalchemy     # SQL toolkit and ORM
pip install psycopg2       # PostgreSQL adapter
pip install pymongo        # MongoDB driver
pip install redis          # Redis client
pip install alembic        # Database migrations
```

### Data Science

```powershell
pip install numpy          # Numerical computing
pip install pandas         # Data analysis
pip install matplotlib     # Plotting
pip install scikit-learn   # Machine learning
pip install tensorflow     # Deep learning
```

### Utilities

```powershell
pip install requests       # HTTP library
pip install beautifulsoup4 # Web scraping
pip install python-dotenv  # Environment variables
pip install click          # CLI creation
pip install pytest         # Testing framework
```

---

## Flask Setup

### Install Flask

```powershell
pip install flask
```

### Create Flask App

```powershell
@"
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/api/data')
def get_data():
    return jsonify({
        'message': 'API Response',
        'data': [1, 2, 3]
    })

@app.route('/api/user/<name>')
def greet_user(name):
    return jsonify({'greeting': f'Hello, {name}!'})

if __name__ == '__main__':
    app.run(debug=True, port=5000)
"@ | Out-File app.py

# Run Flask app
python app.py
```

Visit http://localhost:5000

---

## Django Setup

### Install Django

```powershell
pip install django
```

### Create Django Project

```powershell
# Create project
django-admin startproject myproject

# Navigate to project
cd myproject

# Create app
python manage.py startapp myapp

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run server
python manage.py runserver
```

Visit http://localhost:8000

---

## FastAPI Setup

### Install FastAPI

```powershell
pip install fastapi uvicorn
```

### Create FastAPI App

```powershell
@"
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    name: str
    email: str
    age: int = None

@app.get('/')
def read_root():
    return {'Hello': 'World'}

@app.get('/api/users/{user_id}')
def read_user(user_id: int):
    return {'user_id': user_id, 'name': 'John'}

@app.post('/api/users/')
def create_user(user: User):
    return {'created': user}

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='0.0.0.0', port=8000)
"@ | Out-File main.py

# Run FastAPI app
python main.py

# Or with uvicorn
uvicorn main:app --reload
```

Visit http://localhost:8000/docs for interactive API docs

---

## Testing with pytest

### Install pytest

```powershell
pip install pytest
```

### Create Tests

```powershell
@"
def add(a, b):
    return a + b

def multiply(a, b):
    return a * b
"@ | Out-File math.py

@"
import pytest
from math import add, multiply

def test_add():
    assert add(2, 3) == 5
    assert add(0, 0) == 0
    assert add(-1, 1) == 0

def test_multiply():
    assert multiply(2, 3) == 6
    assert multiply(0, 5) == 0
    assert multiply(-2, 3) == -6

def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError):
        1 / 0
"@ | Out-File test_math.py

# Run tests
pytest

# Run with verbose output
pytest -v

# Run specific test
pytest test_math.py::test_add
```

---

## Project Structure Best Practices

```
my-app/
├── venv/                    # Virtual environment
├── src/
│   ├── __init__.py
│   ├── main.py             # Entry point
│   ├── config.py           # Configuration
│   ├── models/             # Data models
│   │   ├── __init__.py
│   │   ├── user.py
│   │   └── product.py
│   ├── routes/             # API routes
│   │   ├── __init__.py
│   │   ├── users.py
│   │   └── products.py
│   ├── services/           # Business logic
│   │   ├── __init__.py
│   │   ├── user_service.py
│   │   └── product_service.py
│   ├── database/           # Database utilities
│   │   ├── __init__.py
│   │   └── connection.py
│   └── utils/              # Helper functions
│       ├── __init__.py
│       ├── logger.py
│       └── validators.py
├── tests/                  # Test files
│   ├── __init__.py
│   ├── test_users.py
│   └── test_products.py
├── .env                    # Environment variables
├── .env.example           # Example env file
├── .gitignore             # Git ignore rules
├── requirements.txt       # Package dependencies
├── README.md              # Project documentation
└── pytest.ini             # pytest configuration
```

---

## Environment Variables

### Create .env File

```powershell
@"
FLASK_ENV=development
FLASK_DEBUG=True
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
API_KEY=your-api-key
SECRET_KEY=your-secret-key
"@ | Out-File .env

# Add to .gitignore
echo ".env" >> .gitignore
```

### Load Environment Variables

```powershell
pip install python-dotenv

# In your code:
# from dotenv import load_dotenv
# load_dotenv()
# import os
# database_url = os.getenv('DATABASE_URL')
```

---

## Common Issues & Solutions

### Module Not Found

```powershell
# Activate virtual environment
venv\Scripts\activate

# Reinstall dependencies
pip install -r requirements.txt
```

### Permission Denied

```powershell
# Run as administrator if needed
# Or use --user flag
pip install --user package-name
```

### Slow Installation

```powershell
# Use --no-cache-dir flag
pip install --no-cache-dir -r requirements.txt

# Or upgrade pip
python -m pip install --upgrade pip
```

---

## Best Practices

1. **Always use virtual environments** - Isolate project dependencies
2. **Use requirements.txt** - Track all dependencies
3. **Use environment variables** - Never hardcode secrets
4. **Write docstrings** - Document your functions
5. **Use type hints** - Makes code clearer
6. **Write tests** - Aim for 70%+ code coverage
7. **Use logging** - Instead of print() for production
8. **Follow PEP 8** - Python style guide
9. **Use linting** - pylint or flake8
10. **Keep dependencies updated** - Regularly update packages

---

## Resources

- [Python Official Docs](https://docs.python.org/3/)
- [pip Documentation](https://pip.pypa.io/en/stable/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Django Documentation](https://www.djangoproject.com/download/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Real Python Tutorials](https://realpython.com/)

