<script setup lang="ts">
import { ref } from 'vue'

const count = ref(0)

function increment() {
  count.value++
}
</script>

<template>
  <div class="home">
    <h1>Welcome to Vue.js Starter!</h1>
    <p>Get started by editing <code>src/views/HomeView.vue</code></p>
    
    <div class="counter">
      <button @click="increment">Count is: {{ count }}</button>
    </div>

    <div class="features">
      <div class="feature">
        <h3>⚡ Vite</h3>
        <p>Lightning fast HMR</p>
      </div>
      <div class="feature">
        <h3>🔷 TypeScript</h3>
        <p>Type safety built-in</p>
      </div>
      <div class="feature">
        <h3>🍍 Pinia</h3>
        <p>State management</p>
      </div>
      <div class="feature">
        <h3>🛣️ Vue Router</h3>
        <p>Client-side routing</p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.home {
  text-align: center;
}

h1 {
  color: #42b883;
  margin-bottom: 1rem;
}

code {
  background: #f4f4f4;
  padding: 0.2rem 0.5rem;
  border-radius: 3px;
}

.counter {
  margin: 2rem 0;
}

button {
  background: #42b883;
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: background 0.3s;
}

button:hover {
  background: #35a372;
}

.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
}

.feature {
  padding: 1.5rem;
  background: #f8f8f8;
  border-radius: 8px;
}

.feature h3 {
  margin-bottom: 0.5rem;
}
</style>
