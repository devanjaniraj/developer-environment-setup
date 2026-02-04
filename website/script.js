// Setup Wizard State
let currentStep = 1;
const totalSteps = 4;
let selectedPlatform = 'windows';
let selectedLanguages = ['nodejs', 'python'];
let selectedDatabases = ['postgresql', 'mongodb'];

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    initWizard();
    animateTerminal();
    setupPlatformButtons();
});

// Initialize wizard dots
function initWizard() {
    const dotsContainer = document.getElementById('wizardDots');
    for (let i = 1; i <= totalSteps; i++) {
        const dot = document.createElement('div');
        dot.className = 'wizard-dot' + (i === 1 ? ' active' : '');
        dotsContainer.appendChild(dot);
    }
}

// Change wizard step
function changeStep(direction) {
    const steps = document.querySelectorAll('.wizard-step');
    const dots = document.querySelectorAll('.wizard-dot');
    
    steps[currentStep - 1].classList.remove('active');
    dots[currentStep - 1].classList.remove('active');
    
    currentStep += direction;
    
    if (currentStep > totalSteps) currentStep = totalSteps;
    if (currentStep < 1) currentStep = 1;
    
    steps[currentStep - 1].classList.add('active');
    dots[currentStep - 1].classList.add('active');
    
    // Update buttons
    document.getElementById('prevBtn').disabled = currentStep === 1;
    document.getElementById('nextBtn').textContent = 
        currentStep === totalSteps ? 'Finish' : 'Next >';
    
    // Generate instructions on last step
    if (currentStep === totalSteps) {
        generateInstructions();
    }
}

// Start setup wizard
function startSetup() {
    document.getElementById('setup').scrollIntoView({ behavior: 'smooth' });
}

// Setup platform buttons
function setupPlatformButtons() {
    const platformBtns = document.querySelectorAll('.platform-btn');
    platformBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            platformBtns.forEach(b => b.classList.remove('selected'));
            btn.classList.add('selected');
            selectedPlatform = btn.dataset.platform;
        });
    });
    
    // Set default
    platformBtns[0].classList.add('selected');
}

// Generate installation instructions
function generateInstructions() {
    const output = document.getElementById('installationOutput');
    let commands = '';
    
    if (selectedPlatform === 'windows') {
        commands = `
<h4>Windows PowerShell Commands:</h4>
<pre>
# Clone the repository
git clone https://github.com/devanjaniraj/developer-environment-setup.git
cd developer-environment-setup

# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Run setup script
.\\scripts\\setup.ps1

# Verify installation
node -v
npm -v
python --version
git --version
docker --version
</pre>

<h4>Selected Components:</h4>
<ul>
    <li><strong>Languages:</strong> ${selectedLanguages.join(', ')}</li>
    <li><strong>Databases:</strong> ${selectedDatabases.join(', ')}</li>
</ul>

<h4>Next Steps:</h4>
<ol>
    <li>Copy and run the commands above</li>
    <li>Follow the prompts in PowerShell</li>
    <li>Restart PowerShell after installation</li>
    <li>Verify all tools are installed correctly</li>
    <li>Choose a project template to start building</li>
</ol>
        `;
    } else if (selectedPlatform === 'macos') {
        commands = `
<h4>macOS Terminal Commands:</h4>
<pre>
# Clone the repository
git clone https://github.com/devanjaniraj/developer-environment-setup.git
cd developer-environment-setup

# Run setup script
chmod +x scripts/setup-macos.sh
./scripts/setup-macos.sh

# Verify installation
node -v
npm -v
python3 --version
git --version
docker --version
</pre>

<h4>Selected Components:</h4>
<ul>
    <li><strong>Languages:</strong> ${selectedLanguages.join(', ')}</li>
    <li><strong>Databases:</strong> ${selectedDatabases.join(', ')}</li>
</ul>
        `;
    } else {
        commands = `
<h4>Linux Terminal Commands:</h4>
<pre>
# Clone the repository
git clone https://github.com/devanjaniraj/developer-environment-setup.git
cd developer-environment-setup

# Run setup script
chmod +x scripts/setup-linux.sh
./scripts/setup-linux.sh

# Verify installation
node -v
npm -v
python3 --version
git --version
docker --version
</pre>

<h4>Selected Components:</h4>
<ul>
    <li><strong>Languages:</strong> ${selectedLanguages.join(', ')}</li>
    <li><strong>Databases:</strong> ${selectedDatabases.join(', ')}</li>
</ul>
        `;
    }
    
    output.innerHTML = commands;
}

// Copy instructions
function copyInstructions() {
    const output = document.getElementById('installationOutput');
    const text = output.innerText;
    
    navigator.clipboard.writeText(text).then(() => {
        alert('Instructions copied to clipboard!');
    });
}

// Copy code block
function copyCode(button) {
    const codeBlock = button.previousElementSibling;
    const text = codeBlock.textContent;
    
    navigator.clipboard.writeText(text).then(() => {
        button.innerHTML = '<i class="fas fa-check"></i>';
        setTimeout(() => {
            button.innerHTML = '<i class="fas fa-copy"></i>';
        }, 2000);
    });
}

// Animate terminal
function animateTerminal() {
    const commands = [
        'Installing Node.js... ✓',
        'Installing Python... ✓',
        'Installing Git... ✓',
        'Installing Docker... ✓',
        'Configuring VS Code... ✓',
        'Setup complete! 🎉'
    ];
    
    let index = 0;
    const terminalOutput = document.getElementById('terminalOutput');
    
    setInterval(() => {
        if (index < commands.length) {
            const line = document.createElement('div');
            line.className = 'terminal-line';
            line.textContent = '$ ' + commands[index];
            terminalOutput.appendChild(line);
            index++;
            
            // Keep only last 6 lines
            while (terminalOutput.children.length > 9) {
                terminalOutput.removeChild(terminalOutput.firstChild);
            }
        } else {
            index = 0;
            terminalOutput.innerHTML = `
                <div class="terminal-line">$ git clone https://github.com/devanjaniraj/developer-environment-setup.git</div>
                <div class="terminal-line">$ cd developer-environment-setup</div>
                <div class="terminal-line">$ .\\scripts\\setup.ps1</div>
            `;
        }
    }, 2000);
}

// Track language selections
document.addEventListener('change', (e) => {
    if (e.target.name === 'language') {
        const value = e.target.value;
        if (e.target.checked) {
            selectedLanguages.push(value);
        } else {
            selectedLanguages = selectedLanguages.filter(l => l !== value);
        }
    }
    
    if (e.target.name === 'database') {
        const value = e.target.value;
        if (e.target.checked) {
            selectedDatabases.push(value);
        } else {
            selectedDatabases = selectedDatabases.filter(d => d !== value);
        }
    }
});

// Mobile menu toggle
document.getElementById('menuToggle')?.addEventListener('click', () => {
    const navMenu = document.querySelector('.nav-menu');
    navMenu.style.display = navMenu.style.display === 'flex' ? 'none' : 'flex';
});

// Smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({ behavior: 'smooth' });
        }
    });
});
