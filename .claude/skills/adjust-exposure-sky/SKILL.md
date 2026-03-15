---
name: adjust-exposure-sky
description: Increase exposure of a blog post image while preserving the sky using a luminosity mask
---

Brighten a blog post image's foreground while leaving the sky untouched, using a luminosity mask.

1. Use Grep to search for `$ARGUMENTS` (an alt text snippet) across `bikepacking/*/index.html` to find the matching `<img>` tag. Extract the image `src` path from the match.

2. Run the luminosity mask adjustment:
   ```bash
   magick <image_path> \
     ( +clone -brightness-contrast 8x3 ) \
     ( -clone 0 -colorspace gray -threshold 55% -negate -blur 0x10 ) \
     -composite <image_path>_adjusted.JPG
   ```
   This works by:
   - Creating a brightened copy of the image
   - Creating a mask from the original: converting to grayscale, thresholding so the bright sky becomes white, negating so sky=black and ground=white, then blurring to smooth the transition
   - Compositing: where mask is white (ground), use brightened version; where black (sky), keep original

3. Open both the original and adjusted images in `imv` so the user can compare before and after:
   ```bash
   imv <image_path> <image_path>_adjusted.JPG &
   ```

4. If the user approves, replace the original with the adjusted version:
   ```bash
   mv <image_path>_adjusted.JPG <image_path>
   ```

5. If the user wants adjustments, the main tuning parameters are:
   - `8x3` in `-brightness-contrast` — first number is brightness, second is contrast
   - `55%` in `-threshold` — controls where the sky/ground boundary falls. Lower catches more as "sky", higher catches less
