import { useState } from 'react';
import './App.css';

function App() {
  const [count, setCount] = useState(0);
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);

  const fetchUsers = async () => {
    setLoading(true);
    try {
      const response = await fetch('http://localhost:3000/api/users');
      const data = await response.json();
      setUsers(data);
    } catch (error) {
      console.error('Error fetching users:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="App">
      <header>
        <h1>React Starter App</h1>
        <p>Welcome to your React application</p>
      </header>

      <main>
        <section>
          <h2>Counter</h2>
          <p>Count: {count}</p>
          <button onClick={() => setCount(count + 1)}>Increment</button>
          <button onClick={() => setCount(count - 1)}>Decrement</button>
          <button onClick={() => setCount(0)}>Reset</button>
        </section>

        <section>
          <h2>Fetch Users</h2>
          <button onClick={fetchUsers} disabled={loading}>
            {loading ? 'Loading...' : 'Fetch Users'}
          </button>
          {users.length > 0 && (
            <ul>
              {users.map((user) => (
                <li key={user.id}>
                  {user.name} ({user.email})
                </li>
              ))}
            </ul>
          )}
        </section>
      </main>
    </div>
  );
}

export default App;
