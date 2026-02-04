# 🎯 Node.js Development Setup

Complete guide to setting up and working with Node.js in your development environment.

## Prerequisites

- Node.js v20.11+ installed
- npm v10.5+ installed
- VS Code (optional but recommended)
- Basic command line knowledge

## Getting Started

### Verify Installation

```powershell
node --version    # Check Node.js version
npm --version     # Check npm version
```

### Create Your First Project

```powershell
# Create project directory
mkdir my-node-project
cd my-node-project

# Initialize npm project
npm init -y
```

This creates `package.json` with default settings.

---

## Essential npm Commands

### Project Setup

```powershell
# Initialize new project
npm init              # Interactive setup
npm init -y           # Use defaults

# Install all dependencies
npm install

# Install specific package
npm install express   # Latest version
npm install express@4.18.2  # Specific version

# Install as development dependency
npm install --save-dev webpack

# Install globally
npm install -g nodemon
```

### Managing Dependencies

```powershell
# List all installed packages
npm list

# List outdated packages
npm outdated

# Update specific package
npm update express

# Update all packages
npm update

# Remove package
npm uninstall express

# Remove and update package.json
npm uninstall --save express
```

### Running Scripts

```powershell
# Run start script
npm start

# Run custom script
npm run dev
npm run build
npm run test

# List available scripts
npm run

# Run script with arguments
npm run dev -- --port 3001
```

---

## Express.js Setup

### Install Express

```powershell
npm install express
```

### Create Basic Server

```powershell
@"
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// Routes
app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.get('/api/data', (req, res) => {
  res.json({ message: 'API Response', data: [] });
});

app.post('/api/data', (req, res) => {
  const newData = req.body;
  res.status(201).json({ success: true, data: newData });
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

// Start server
app.listen(PORT, () => {
  console.log(\`Server running on http://localhost:\${PORT}\`);
});
"@ | Out-File -Encoding UTF8 server.js

# Run server
node server.js
```

Visit http://localhost:3000

### Auto-reload with Nodemon

```powershell
# Install nodemon globally
npm install -g nodemon

# Or install as dev dependency
npm install --save-dev nodemon

# Run with nodemon
nodemon server.js

# Update package.json
# "scripts": { "start": "nodemon server.js" }
npm start
```

---

## Popular Packages

### Web Frameworks

```powershell
npm install express         # Web framework
npm install fastify         # Fast web framework
npm install hapi            # Enterprise framework
```

### Database Packages

```powershell
npm install mongoose        # MongoDB ODM
npm install sequelize       # SQL ORM
npm install typeorm         # TypeORM
npm install prisma          # Modern ORM
npm install pg              # PostgreSQL client
```

### Utilities

```powershell
npm install dotenv          # Environment variables
npm install axios           # HTTP client
npm install lodash          # Utility library
npm install moment          # Date/time
npm install uuid            # Generate UUIDs
```

### Development Tools

```powershell
npm install --save-dev nodemon     # Auto-reload
npm install --save-dev eslint      # Linting
npm install --save-dev prettier    # Formatting
npm install --save-dev jest        # Testing
npm install --save-dev webpack     # Bundling
```

---

## TypeScript Setup

### Install TypeScript

```powershell
npm install --save-dev typescript
npm install --save-dev @types/node
```

### Initialize TypeScript

```powershell
npx tsc --init
```

### Create TypeScript File

```powershell
@"
interface User {
  id: number;
  name: string;
  email: string;
}

function greetUser(user: User): string {
  return \`Hello, \${user.name}!\`;
}

const user: User = {
  id: 1,
  name: 'John',
  email: 'john@example.com'
};

console.log(greetUser(user));
"@ | Out-File -Encoding UTF8 main.ts

# Compile to JavaScript
npx tsc main.ts

# Run compiled JavaScript
node main.js
```

---

## Project Structure Best Practices

```
my-app/
├── src/
│   ├── index.js          # Entry point
│   ├── server.js         # Express setup
│   ├── routes/           # Route handlers
│   │   ├── users.js
│   │   └── products.js
│   ├── controllers/      # Business logic
│   │   ├── userController.js
│   │   └── productController.js
│   ├── models/           # Database models
│   │   ├── User.js
│   │   └── Product.js
│   ├── middleware/       # Custom middleware
│   │   ├── auth.js
│   │   └── validation.js
│   ├── utils/            # Helper functions
│   │   ├── logger.js
│   │   └── validators.js
│   └── config/           # Configuration
│       └── database.js
├── tests/                # Test files
│   ├── unit/
│   └── integration/
├── public/               # Static files
│   ├── css/
│   ├── js/
│   └── images/
├── .env                  # Environment variables
├── .env.example          # Example environment
├── .gitignore           # Git ignore rules
├── package.json         # Project metadata
├── package-lock.json    # Dependency lock
└── README.md            # Project documentation
```

---

## Environment Variables

### Create .env File

```powershell
@"
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
MONGODB_URL=mongodb://localhost:27017/dbname
API_KEY=your-api-key
SECRET_KEY=your-secret-key
"@ | Out-File .env

# Don't commit .env to git
echo ".env" >> .gitignore
```

### Load Environment Variables

```powershell
npm install dotenv

# In your code:
# require('dotenv').config();
# const PORT = process.env.PORT || 3000;
```

---

## Testing with Jest

### Install Jest

```powershell
npm install --save-dev jest
```

### Configure Jest

```powershell
# Initialize Jest config
npx jest --init

# Or add to package.json
# "test": "jest"
```

### Write Tests

```powershell
@"
function sum(a, b) {
  return a + b;
}

module.exports = sum;
"@ | Out-File math.js

@"
const sum = require('./math');

describe('sum function', () => {
  test('adds 1 + 2 to equal 3', () => {
    expect(sum(1, 2)).toBe(3);
  });

  test('adds 5 + 5 to equal 10', () => {
    expect(sum(5, 5)).toBe(10);
  });
});
"@ | Out-File math.test.js

# Run tests
npm test
```

---

## Debugging

### VS Code Debugging

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "skipFiles": ["<node_internals>/**"],
      "program": "${workspaceFolder}/server.js"
    }
  ]
}
```

Then press F5 to start debugging.

### Console Logging

```javascript
console.log('Regular log');
console.error('Error message');
console.warn('Warning message');
console.table([{id: 1, name: 'John'}]);
console.time('label');
// ... code to measure ...
console.timeEnd('label');
```

---

## Common Issues & Solutions

### Module Not Found

```powershell
# Clear npm cache
npm cache clean --force

# Reinstall dependencies
rm -r node_modules package-lock.json
npm install
```

### Port Already in Use

```powershell
# Find process using port
netstat -ano | findstr :3000

# Kill process (replace PID)
taskkill /PID <PID> /F

# Or use different port
NODE_ENV=development PORT=3001 node server.js
```

### EACCES Permission Denied

```powershell
# This usually doesn't happen on Windows
# If it does, reinstall Node.js with admin rights
```

---

## Best Practices

1. **Use package.json scripts** - Define common tasks
2. **Pin major versions** - Use `^` for flexibility, `~` for stability
3. **Use environment variables** - Never hardcode secrets
4. **Handle errors properly** - Use try-catch and error middleware
5. **Log appropriately** - Use logging libraries like Winston or Pino
6. **Write tests** - Aim for 70%+ code coverage
7. **Use linting** - ESLint catches common mistakes
8. **Format code** - Use Prettier for consistency
9. **Document code** - Write clear comments and docs
10. **Security** - Use helmet, validate inputs, sanitize outputs

---

## Resources

- [Node.js Official Docs](https://nodejs.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)
- [Express.js Guide](https://expressjs.com/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)

