# ❓ Frequently Asked Questions (FAQ)

Answers to common questions about this development environment setup.

## Installation & Setup

**Q: Do I need administrator rights?**
A: Yes, some installations (especially Docker and system-wide tools) require administrator access.

**Q: How long does setup take?**
A: The automated script usually takes 30-60 minutes depending on internet speed and system performance.

**Q: Can I skip some installations?**
A: Yes! Use script parameters:
```powershell
.\scripts\setup.ps1 -SkipDocker  # Skip Docker
.\scripts\setup.ps1 -SkipExtensions  # Skip VS Code extensions
```

**Q: What if I only want Node.js?**
A: Install manually from nodejs.org, or modify the setup script to skip unwanted tools.

**Q: Do I need Docker?**
A: No, Docker is optional. Skip it if you don't need databases.

---

## Version & Compatibility

**Q: Which Windows versions are supported?**
A: Windows 10 (Build 2004+) or Windows 11. Older versions may have issues.

**Q: What Node.js version should I use?**
A: The script installs v20.11+. It's LTS and well-supported.

**Q: Can I use Python 2?**
A: Not recommended. The setup uses Python 3.11+. Python 2 is deprecated.

**Q: Are there Mac/Linux versions?**
A: This setup is Windows-specific, but most tools work on Mac/Linux with similar instructions.

---

## Performance & Resources

**Q: Will this slow down my computer?**
A: Not significantly. The tools are lightweight. Docker can use resources, so give it 4GB+ RAM allocation.

**Q: How much disk space do I need?**
A: About 10GB minimum. If installing databases via Docker, add 5-10GB more.

**Q: Can I run this on a laptop?**
A: Yes! Works well on modern laptops (8GB+ RAM recommended).

**Q: Should I use SSD or HDD?**
A: SSD is much faster, but HDD works too.

---

## Node.js / JavaScript

**Q: What's the difference between npm and yarn?**
A: npm is default. Yarn is an alternative. Stick with npm unless you have a specific reason.

**Q: How do I install a package globally?**
A: Use `npm install -g package-name`. Creates command-line tool.

**Q: What's the difference between --save and --save-dev?**
A: `--save` (default) adds to dependencies (production). `--save-dev` adds to devDependencies (only for development).

**Q: How do I update all packages?**
A: Run `npm update` to update all to latest minor version.

**Q: What's package-lock.json?**
A: Locks exact versions for reproducibility. Always commit it.

---

## Python

**Q: What's a virtual environment?**
A: Isolated Python environment per project. Prevents version conflicts between projects.

**Q: Do I always need venv?**
A: Strongly recommended, yes. Keeps dependencies organized.

**Q: What's the difference between pip and conda?**
A: pip is default. Conda is more powerful but heavier. Start with pip.

**Q: How do I check what's installed?**
A: Run `pip list` while venv is activated.

**Q: Can I have multiple Python versions?**
A: Yes, use `python3.9`, `python3.10`, etc. Or tools like pyenv.

---

## Docker & Databases

**Q: Do I need all 5 databases?**
A: No, pick what you need. Comment out others in docker-compose.yml.

**Q: How do I stop only PostgreSQL?**
A: Use `docker-compose stop postgres` (doesn't remove data).

**Q: Will my data persist?**
A: Yes, volumes ensure data survives container restarts.

**Q: How do I reset a database?**
A: Remove the volume: `docker volume rm repo-fix_postgres_data`

**Q: Can I access databases from outside containers?**
A: Yes, they expose ports (5432, 27017, etc.) to localhost.

**Q: Why is Docker so slow on Windows?**
A: Hyper-V virtualization overhead. Use WSL 2 for better performance.

---

## Git & Version Control

**Q: What's the difference between Git and GitHub?**
A: Git is version control software. GitHub is hosting service for Git repositories.

**Q: How do I undo a commit?**
A: Use `git reset --soft HEAD~1` (keeps changes) or `git reset --hard HEAD~1` (discards changes).

**Q: What's a merge conflict?**
A: When two branches modify same lines. You must resolve manually before merging.

**Q: Should I use Git SSH or HTTPS?**
A: Either works. SSH is slightly more secure but requires setup.

**Q: How do I merge my feature branch?**
A: 
```powershell
git checkout main
git pull
git merge feature/my-feature
git push
```

---

## VS Code

**Q: What extensions do I need?**
A: The setup includes 50+ recommended extensions. Start with those.

**Q: How do I change the theme?**
A: Ctrl+K Ctrl+T to open theme picker.

**Q: How do I disable an extension?**
A: Click the extension, then "Disable" button.

**Q: How do I format my code?**
A: Select code, press Shift+Alt+F.

**Q: Can I sync settings across computers?**
A: Yes, VS Code has built-in Settings Sync feature.

---

## Troubleshooting

**Q: Command works in terminal but not in VS Code?**
A: VS Code may need to be restarted or shell path configured.

**Q: My antivirus is blocking npm install?**
A: Add node_modules folder to antivirus whitelist.

**Q: Setup script fails silently?**
A: Run without `-Quiet` flag to see detailed output.

**Q: Can I reinstall without losing data?**
A: Yes, just don't delete .env files or databases. Skip setup where needed.

**Q: Should I commit node_modules and venv?**
A: No! Add both to .gitignore. Others can recreate with `npm install` or `pip install -r requirements.txt`.

---

## Projects & Templates

**Q: Can I use the templates as starting point?**
A: Yes! Copy them and customize: `cp -r templates/express-starter my-project`

**Q: How do I create my own template?**
A: Create project structure in templates/ folder. Others can copy and use it.

**Q: Can I add more templates?**
A: Yes, add to templates/ folder. Consider contributing back!

---

## Security & Passwords

**Q: Should I hardcode API keys?**
A: Never! Use environment variables in .env file.

**Q: What should I do if I accidentally committed secrets?**
A: Remove from git history using `git-filter-branch` or use BFG Repo-Cleaner.

**Q: Are my environment variables safe?**
A: .env file is in .gitignore so it's not committed. Keep .env file safe locally.

**Q: How do I securely store passwords?**
A: Use environment variables or secret management tools like HashiCorp Vault.

---

## Networking

**Q: Why can't I access databases?**
A: Ensure Docker is running and ports are not blocked by firewall.

**Q: How do I access database from remote machine?**
A: Databases only listen on localhost by default. Modify docker-compose.yml to expose externally (not recommended for production).

**Q: Can I use VPN with this setup?**
A: Yes, but some VPNs block Docker. Try WSL 2 backend for Docker.

---

## Updates & Maintenance

**Q: How do I update all tools?**
A: Run setup script again, or manually update Node.js, Python, Docker, etc.

**Q: How do I update npm packages?**
A: Run `npm update` (minor versions) or `npm outdated` to check.

**Q: How do I update pip packages?**
A: Run `pip install --upgrade package-name` or use `pip-upgrade` tool.

**Q: Should I always use latest versions?**
A: Use stable/LTS versions. Cutting-edge versions may have bugs.

---

## Cost & Licensing

**Q: Is this setup free?**
A: Yes! All tools are free and open source.

**Q: Can I use this commercially?**
A: Yes, MIT license allows commercial use.

**Q: Do I need any licenses?**
A: No, all included tools are free.

**Q: What about GitHub?**
A: Free for public and private repositories.

---

## Community & Support

**Q: Can I contribute to this project?**
A: Yes! See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

**Q: How do I report a bug?**
A: Open an issue on GitHub with details and steps to reproduce.

**Q: Where can I ask questions?**
A: Use GitHub Discussions or open an issue.

**Q: Is there a community?**
A: Check GitHub Issues and Discussions for active members.

---

## Additional Resources

- [Official Setup Guide](./INSTALLATION_GUIDE.md)
- [Quick Start](./QUICK_START.md)
- [Troubleshooting Guide](./TROUBLESHOOTING.md)
- [Error Reference](./ERROR_REFERENCE.md)
- [GitHub Repository](https://github.com/devanjaniraj/developer-environment-setup)

---

**Still have questions?**

1. Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
2. Search [GitHub Issues](https://github.com/devanjaniraj/developer-environment-setup/issues)
3. Start a [GitHub Discussion](https://github.com/devanjaniraj/developer-environment-setup/discussions)

