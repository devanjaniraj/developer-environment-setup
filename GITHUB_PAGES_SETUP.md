# GitHub Pages Deployment Guide

## 🚀 Deploy Your Website to GitHub Pages

Your website is now ready to be deployed to GitHub Pages! Follow these steps:

---

## Step 1: Push to GitHub

```bash
cd developer-environment-setup

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit changes
git commit -m "feat: Add interactive website and complete developer setup"

# Add remote origin
git remote add origin https://github.com/devanjaniraj/developer-environment-setup.git

# Push to main branch
git branch -M main
git push -u origin main
```

---

## Step 2: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** (gear icon)
3. Scroll to **Pages** section (left sidebar)
4. Under "Build and deployment":
   - **Source:** Select `Deploy from a branch`
   - **Branch:** Select `main`
   - **Folder:** Select `/ (root)`

> **Alternative for subdirectory:**
> If you want to deploy only the website folder:
> - **Folder:** Select `/website` instead

5. Click **Save**

---

## Step 3: Wait for Deployment

GitHub will automatically build and deploy your site. Check the **Actions** tab to see the deployment progress.

**Your site will be live at:**
- `https://devanjaniraj.github.io/developer-environment-setup/` (if deploying from root)
- `https://devanjaniraj.github.io/developer-environment-setup/website/` (if deploying from website folder)

---

## Step 4: Custom Domain (Optional)

To use a custom domain:

1. In repository **Settings > Pages**
2. Under "Custom domain", enter your domain name
3. Click **Save**
4. Update DNS records at your domain provider:
   - Add CNAME record pointing to `devanjaniraj.github.io`
   - Or use A records (see GitHub docs)

---

## Configuration Files Included

### `/.github/workflows/pages.yml` (Create if not exists)

This workflow automatically deploys your website when you push to main:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup Pages
        uses: actions/configure-pages@v3

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: 'website'

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

> Already created in `.github/workflows/pages.yml`

---

## Troubleshooting

### Issue: Website not appearing

**Solution 1:** Check repository visibility
- Go to **Settings > General**
- Ensure repository is **Public** (not Private)

**Solution 2:** Check branch settings
- Go to **Settings > Pages**
- Verify correct branch and folder are selected

**Solution 3:** Wait for deployment
- Go to **Actions** tab
- Check if deployment workflow completed successfully

**Solution 4:** Clear browser cache
- Hard refresh: `Ctrl+Shift+R` (Windows) or `Cmd+Shift+R` (Mac)

### Issue: Assets not loading (CSS, images)

**Solution:** Update file paths in HTML
- Change relative paths: `href="styles.css"` works fine
- No need for absolute paths unless using subdirectory

### Issue: GitHub Pages URL is different

**Solution:** Update hardcoded URLs
If you deployed to subdirectory `/website`, update:
- Navigation links
- Asset paths
- Any hardcoded URLs

---

## Verification

Once deployed, verify everything works:

✅ **Check deployment:**
```bash
# Replace with your actual GitHub Pages URL
curl -I https://devanjaniraj.github.io/developer-environment-setup/
```

✅ **Test website:**
- Open GitHub Pages URL in browser
- Check all pages load
- Test interactive features
- Verify responsive design on mobile

---

## Update Your README

Add GitHub Pages link to your main README.md:

```markdown
## 🌐 Live Website

Visit the interactive website: https://devanjaniraj.github.io/developer-environment-setup/

Or run locally:
```bash
cd website
python -m http.server 8000
```
```

---

## Performance Tips

1. **Minimize CSS/JS** (optional)
   - Use build tools like esbuild or webpack
   - Reduces page load time

2. **Optimize Images**
   - Compress images before committing
   - Use modern formats (WebP)

3. **Enable Caching**
   - GitHub Pages uses CDN (CloudFlare)
   - Automatic caching of static assets

4. **Monitor Performance**
   - Use Google PageSpeed Insights
   - Check Core Web Vitals

---

## Next Steps

After deployment:

1. **Share your website** 
   - Add link to GitHub profile
   - Share on social media
   - Include in portfolio

2. **Monitor traffic**
   - Use Google Analytics
   - Track visitor engagement

3. **Keep updating**
   - Regular commits = frequent updates
   - Changes auto-deploy to GitHub Pages

4. **Get feedback**
   - Add GitHub Discussions
   - Collect issues/feature requests

---

## Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Jekyll (optional static site generator)](https://jekyllrb.com/)

---

## Need Help?

If you encounter issues:

1. Check [GitHub Pages Troubleshooting](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#limits-on-use-of-github-pages)
2. Review [Actions logs](https://github.com/devanjaniraj/developer-environment-setup/actions)
3. Open an issue on GitHub
4. Contact support

---

**Your website will be live in minutes!** 🚀
