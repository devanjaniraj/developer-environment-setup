# Testing Guide

Complete guide to testing your applications.

## Types of Tests

### Unit Tests
Test individual functions and components in isolation.

```typescript
// Example: sum.test.ts
import { sum } from './sum';

describe('sum function', () => {
  it('should add two numbers correctly', () => {
    expect(sum(2, 3)).toBe(5);
  });

  it('should handle negative numbers', () => {
    expect(sum(-2, 3)).toBe(1);
  });
});
```

### Integration Tests
Test how different parts work together.

```typescript
// Example: api.test.ts
import request from 'supertest';
import app from './app';

describe('User API', () => {
  it('should create a new user', async () => {
    const response = await request(app)
      .post('/api/users')
      .send({ name: 'John', email: 'john@example.com' });
    
    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty('id');
  });
});
```

### E2E Tests
Test complete user workflows.

```typescript
// Example: user-flow.spec.ts
import { test, expect } from '@playwright/test';

test('user can sign up and log in', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await page.click('text=Sign Up');
  await page.fill('input[name="email"]', 'test@example.com');
  await page.fill('input[name="password"]', 'password123');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL('/dashboard');
});
```

## Setup Instructions

### Jest with TypeScript

```bash
npm install -D jest ts-jest @types/jest
npx ts-jest config:init
```

### React Testing Library

```bash
npm install -D @testing-library/react @testing-library/jest-dom
```

### Playwright E2E

```bash
npm init playwright@latest
```

## Best Practices

1. **Test Behavior, Not Implementation**
2. **Keep Tests Independent**
3. **Use Descriptive Test Names**
4. **Follow AAA Pattern** (Arrange, Act, Assert)
5. **Mock External Dependencies**
6. **Maintain High Coverage** (aim for 80%+)

## Running Tests

```bash
# Run all tests
npm test

# Watch mode
npm test -- --watch

# Coverage report
npm test -- --coverage

# Specific file
npm test -- user.test.ts
```

## CI/CD Integration

Tests run automatically on:
- Every pull request
- Before deployment
- On scheduled intervals
