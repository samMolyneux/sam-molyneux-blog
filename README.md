# Sam Molyneux Blog

## Deployment

Deploy to Cloudflare Pages using Wrangler:

```bash
# Login (first time only)
wrangler login

# Deploy
wrangler pages deploy
```

## Image Optimization

Optimize images before committing to reduce load times. Requires ImageMagick (`sudo pacman -S imagemagick`).

```bash
# Optimize all images in a directory (resizes to 1920px wide, 85% quality)
./optimize-images.sh images/agadir

# Custom max width
./optimize-images.sh images/agadir 1200

# Custom width and quality
./optimize-images.sh images/agadir 1920 80
```
