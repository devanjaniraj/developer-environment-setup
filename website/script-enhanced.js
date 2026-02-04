// Theme Toggle
function toggleTheme() {
    document.body.classList.toggle('light-mode');
    const isDark = !document.body.classList.contains('light-mode');
    localStorage.setItem('theme', isDark ? 'dark' : 'light');
}

// Load saved theme
function loadTheme() {
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme === 'light') {
        document.body.classList.add('light-mode');
    }
}

// Initialize on load
document.addEventListener('DOMContentLoaded', () => {
    loadTheme();
    initWizard();
    animateTerminal();
    setupPlatformButtons();
    setupContactForm();
    setupNewsletterForm();
});

// Setup Wizard State
let currentStep = 1;
const totalSteps = 4;
let selectedPlatform = 'windows';
let selectedLanguages = ['nodejs', 'python'];
let selectedDatabases = ['postgresql', 'mongodb'];

// Initialize wizard dots
function initWizard() {
    const dotsContainer = document.getElementById('wizardDots');
    if (!dotsContainer) return;
    
    dotsContainer.innerHTML = '';
    for (let i = 1; i <= totalSteps; i++) {
        const dot = document.createElement('div');
        dot.className = 'wizard-dot' + (i === 1 ? ' active' : '');
        dot.onclick = () => jumpToStep(i);
        dotsContainer.appendChild(dot);
    }
}

// Jump to specific step
function jumpToStep(step) {
    if (step >= 1 && step <= totalSteps) {
        currentStep = step;
        updateWizardUI();
    }
}

// Change wizard step
function changeStep(direction) {
    const steps = document.querySelectorAll('.wizard-step');
    const dots = document.querySelectorAll('.wizard-dot');
    
    currentStep += direction;
    
    if (currentStep > totalSteps) currentStep = totalSteps;
    if (currentStep < 1) currentStep = 1;
    
    steps.forEach(s => s.classList.remove('active'));
    dots.forEach(d => d.classList.remove('active'));
    
    steps[currentStep - 1].classList.add('active');
    dots[currentStep - 1].classList.add('active');
    
    updateWizardUI();
    
    if (currentStep === totalSteps) {
        generateInstructions();
    }
}

function updateWizardUI() {
    document.getElementById('prevBtn').disabled = currentStep === 1;
    const nextBtn = document.getElementById('nextBtn');
    nextBtn.textContent = currentStep === totalSteps ? 'Finish' : 'Next >';
    nextBtn.innerHTML = currentStep === totalSteps ? 
        '<i class="fas fa-check"></i> Finish' : 
        'Next <i class="fas fa-arrow-right"></i>';
}

function startSetup() {
    document.getElementById('setup').scrollIntoView({ behavior: 'smooth' });
}

// Platform selection
function setupPlatformButtons() {
    document.querySelectorAll('.platform-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.platform-btn').forEach(b => b.classList.remove('selected'));
            this.classList.add('selected');
            selectedPlatform = this.dataset.platform;
        });
    });
}

// Generate custom instructions
function generateInstructions() {
    const languages = Array.from(document.querySelectorAll('input[name="language"]:checked')).map(i => i.value);
    const databases = Array.from(document.querySelectorAll('input[name="database"]:checked')).map(i => i.value);
    
    let instructions = '';
    
    if (selectedPlatform === 'windows') {
        instructions = `
<div class="instruction-step">
    <h4>Step 1: Clone Repository</h4>
    <code>git clone https://github.com/devanjaniraj/developer-environment-setup.git<br/>
cd developer-environment-setup</code>
</div>

<div class="instruction-step">
    <h4>Step 2: Run Setup Script</h4>
    <code>.\\scripts\\setup.ps1</code>
</div>

<div class="instruction-step">
    <h4>Step 3: Verify Installation</h4>
    <code>node -v && npm -v && python --version</code>
</div>

<div class="instruction-step">
    <h4>Your Selection:</h4>
    <p><strong>Platform:</strong> Windows</p>
    <p><strong>Languages:</strong> ${languages.join(', ')}</p>
    <p><strong>Databases:</strong> ${databases.join(', ')}</p>
</div>
        `;
    } else if (selectedPlatform === 'macos') {
        instructions = `
<div class="instruction-step">
    <h4>Step 1: Clone Repository</h4>
    <code>git clone https://github.com/devanjaniraj/developer-environment-setup.git<br/>
cd developer-environment-setup</code>
</div>

<div class="instruction-step">
    <h4>Step 2: Run Setup Script</h4>
    <code>chmod +x scripts/setup-macos.sh<br/>
./scripts/setup-macos.sh</code>
</div>

<div class="instruction-step">
    <h4>Step 3: Verify Installation</h4>
    <code>node -v && npm -v && python3 --version</code>
</div>

<div class="instruction-step">
    <h4>Your Selection:</h4>
    <p><strong>Platform:</strong> macOS</p>
    <p><strong>Languages:</strong> ${languages.join(', ')}</p>
    <p><strong>Databases:</strong> ${databases.join(', ')}</p>
</div>
        `;
    } else {
        instructions = `
<div class="instruction-step">
    <h4>Step 1: Clone Repository</h4>
    <code>git clone https://github.com/devanjaniraj/developer-environment-setup.git<br/>
cd developer-environment-setup</code>
</div>

<div class="instruction-step">
    <h4>Step 2: Run Setup Script</h4>
    <code>chmod +x scripts/setup-linux.sh<br/>
./scripts/setup-linux.sh</code>
</div>

<div class="instruction-step">
    <h4>Step 3: Verify Installation</h4>
    <code>node -v && npm -v && python3 --version</code>
</div>

<div class="instruction-step">
    <h4>Your Selection:</h4>
    <p><strong>Platform:</strong> Linux</p>
    <p><strong>Languages:</strong> ${languages.join(', ')}</p>
    <p><strong>Databases:</strong> ${databases.join(', ')}</p>
</div>
        `;
    }
    
    document.getElementById('installationOutput').innerHTML = instructions;
}

// Copy instructions
function copyInstructions() {
    const output = document.getElementById('installationOutput');
    const text = output.innerText;
    navigator.clipboard.writeText(text).then(() => {
        showNotification('Instructions copied to clipboard!');
    });
}

// Copy code block
function copyCode(btn) {
    const codeBlock = btn.previousElementSibling;
    const text = codeBlock.innerText;
    navigator.clipboard.writeText(text).then(() => {
        const originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fas fa-check"></i> Copied!';
        setTimeout(() => {
            btn.innerHTML = originalText;
        }, 2000);
    });
}

// Terminal animation
function animateTerminal() {
    const terminal = document.getElementById('terminalOutput');
    if (!terminal) return;
    
    const lines = [
        '$ git clone https://github.com/devanjaniraj/developer-environment-setup.git',
        '$ cd developer-environment-setup',
        '$ ./scripts/setup.ps1',
        'Installing Node.js... ✓',
        'Installing Python... ✓',
        'Installing Docker... ✓',
        'Setup complete! Ready to build. 🚀'
    ];
    
    let index = 0;
    terminal.innerHTML = '';
    
    function addLine() {
        if (index < lines.length) {
            const line = document.createElement('div');
            line.className = 'terminal-line' + (index === lines.length - 1 ? ' success' : '');
            line.textContent = lines[index];
            terminal.appendChild(line);
            index++;
            setTimeout(addLine, 500);
        }
    }
    
    addLine();
}

// Contact Form
function setupContactForm() {
    const form = document.getElementById('contactForm');
    if (!form) return;
    
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const formData = new FormData(form);
        
        // Here you would send to a backend or email service
        console.log('Form submitted:', Object.fromEntries(formData));
        
        showNotification('Thanks for reaching out! We\'ll get back to you soon. 📧');
        form.reset();
    });
}

// Newsletter Form
function setupNewsletterForm() {
    const form = document.getElementById('newsletterForm');
    if (!form) return;
    
    form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const email = form.querySelector('input[type="email"]').value;
        
        // Store email in localStorage as demo
        let subscribers = JSON.parse(localStorage.getItem('newsletter_subscribers') || '[]');
        if (!subscribers.includes(email)) {
            subscribers.push(email);
            localStorage.setItem('newsletter_subscribers', JSON.stringify(subscribers));
        }
        
        showNotification('Subscribed! Check your email for confirmation. 📬');
        form.reset();
    });
}

// Notification system
function showNotification(message) {
    const notification = document.createElement('div');
    notification.className = 'notification success';
    notification.innerHTML = `<i class="fas fa-check-circle"></i> ${message}`;
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Smooth scroll for navigation
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({ behavior: 'smooth' });
        }
    });
});

// Mobile menu toggle
const menuToggle = document.getElementById('menuToggle');
const navMenu = document.querySelector('.nav-menu');
if (menuToggle) {
    menuToggle.addEventListener('click', () => {
        navMenu.classList.toggle('active');
    });
}

// Scroll animations
window.addEventListener('scroll', () => {
    document.querySelectorAll('.feature-card, .template-card, .community-card').forEach(el => {
        const rect = el.getBoundingClientRect();
        if (rect.top < window.innerHeight - 100) {
            el.classList.add('fade-in');
        }
    });
});
