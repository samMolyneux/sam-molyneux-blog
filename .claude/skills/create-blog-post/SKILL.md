---
name: create-blog-post
description: Create a new bikepacking blog post from a folder of images
---

Create a bikepacking blog post outline from images in the `$ARGUMENTS` folder.

All HTML structure and styling must follow `STYLE_GUIDE.md`. Reference an existing bikepacking post for a working example.

1. Optimize all images in the folder and note orientations from the output:
   ```bash
   ./optimize-images.sh images/$ARGUMENTS
   ```
   The script auto-orients images and outputs per image:
   - `[landscape]` or `[portrait]` — parse to determine the correct CSS class (`feature-image-landscape` or `feature-image-portrait`)
   - `[date:YYYY:MM:DD HH:MM:SS]` — EXIF creation date. Parse the earliest and latest dates across all images to derive [DATES COVERED], formatted as "Month DDth to DDth YYYY" (e.g., "February 23rd to 28th 2026") or spanning months (e.g., "January 30th to February 5th 2026").

2. Use Glob to find all images in `images/$ARGUMENTS/`

3. Get pixel dimensions for the `width` and `height` attributes by passing all images to `identify` in a single invocation (avoid bash `for` loops — they trigger a permission prompt with "Unhandled node type: string"):

   ```bash
   identify -format "%f %w %h\n" images/$ARGUMENTS/*.JPG
   ```

4. Use AskUserQuestion to prompt for:
   - **Blog summary**: A short description for the blog index page (e.g., "Cycling along the coast from Agadir to Sidi Ifni")

5. Add an article entry to both index files:
   - Add to `bikepacking/index.html` at the top (after `<h1>Bikepacking</h1>`)
   - Add to `blog/index.html` at the top (after `<h1>Blog</h1>`)

   Use this template for both files:
   ```html
           <article class="block">
               <hgroup>
                   <h2>[TITLE]</h2>
                   <p>[DATES COVERED]</p>
               </hgroup>
               <p><small>Published <time datetime="[TODAY'S DATE ISO]">[TODAY'S DATE]</time></small></p>

               <p>[BLOG SUMMARY] (<a href="/bikepacking/[FOLDER]">read '[TITLE]'</a>)
               </p>

           </article>
   ```

6. Create `bikepacking/$ARGUMENTS/index.html` following the Blog Post Page template in STYLE_GUIDE.md (section 4a). Add a `<figure class="block">` for every image. Use the orientation from step 1 for the image class and the dimensions from step 3 for `width`/`height` attributes. Add `loading="lazy"` to all images except the first.

7. Replace placeholders:
   - [TITLE] with the folder name, replacing underscores with spaces, using sentence case - capitalize first word and proper nouns only, keep words like "to", "the", "a", "and", "of" lowercase (e.g., "agadir_to_sidi_ifni" becomes "Agadir to Sidi Ifni")
   - [TODAY'S DATE] with today's date formatted as "Month DDth YYYY" (e.g., "January 28th 2026")
   - [TODAY'S DATE ISO] with today's date in ISO 8601 format (e.g., "2026-01-28")
   - [DATES COVERED] with the date range derived from EXIF dates in step 1
   - [FOLDER] with the folder name as provided
   - [BLOG SUMMARY] with the user's answer from step 4

8. Generate alt text for each image by reading the image file with the Read tool, then writing a concise descriptive alt text for the `alt` attribute. Keep descriptions short (under ~15 words) and focus on the scene content.

9. Update the RSS feeds (both `bikepacking/feed.xml` and `blog/feed.xml`):

   Add a new `<item>` at the top of the `<channel>` (after the `<atom:link>` element):
   ```xml
       <item>
         <title>[TITLE]</title>
         <link>https://sam-molyneux.com/bikepacking/[FOLDER]</link>
         <pubDate>[RFC822_DATE]</pubDate>
         <description>[BLOG SUMMARY]</description>
       </item>
   ```

   Where [RFC822_DATE] is today's date in RFC 822 format (e.g., "Tue, 28 Jan 2026 00:00:00 +0000")

10. Update `bikepacking/index.html`'s `og:image` meta tag to point to the new post's first image:
   ```html
   <meta property="og:image" content="https://sam-molyneux.com/images/[FOLDER]/[FIRST_IMAGE]">
   ```

11. Append the new post URL to `sitemap.xml` (before the closing `</urlset>` tag):
    ```xml
      <url>
        <loc>https://sam-molyneux.com/bikepacking/[FOLDER]/</loc>
      </url>
    ```

12. Check that what was created matches the other bikepacking blog posts and conforms to STYLE_GUIDE.md, highlight any differences.

13. Report what was created
