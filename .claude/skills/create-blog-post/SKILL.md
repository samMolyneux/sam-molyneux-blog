---
name: create-blog-post
description: Create a new bikepacking blog post from a folder of images
disable-model-invocation: true
allowed-tools: Read, Bash, Write, Glob, Edit, AskUserQuestion
argument-hint: [folder-name]
---

Create a bikepacking blog post outline from images in the `$ARGUMENTS` folder:

1. Optimize all images in the folder:
   ```bash
   ./optimize-images.sh images/$ARGUMENTS
   ```

2. Use Glob to find all images in `images/$ARGUMENTS/`

3. Use AskUserQuestion to prompt for:
   - **Dates covered**: The date range for this blog post (e.g., "January 5th to 7th 2026")
   - **Blog summary**: A short description for the blog index page (e.g., "Cycling along the coast from Agadir to Sidi Ifni")

4. Add an article entry to both index files:
   - Add to `bikepacking/index.html` at the top (after `<h1>Bikepacking</h1>`)
   - Add to `blog/index.html` at the top (after the intro `<p class="block">All posts from...`)

   Use this template for both files:
   ```html
           <article class="block">
               <hgroup>
                   <h2>[TITLE]</h2>
                   <p>[DATES COVERED]</p>
               </hgroup>
               <p><small>Published [TODAY'S DATE]</small></p>

               <p>[BLOG SUMMARY] (<a href="/bikepacking/[FOLDER]">read '[TITLE]'</a>)
               </p>

           </article>
   ```

5. Create `bikepacking/$ARGUMENTS/index.html` using this template:

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sam Molyneux - [TITLE]</title>
    <meta name="description" content="[BLOG SUMMARY]">
    <link rel="canonical" href="https://sam-molyneux.com/bikepacking/[FOLDER]/">
    <meta property="og:title" content="Sam Molyneux - [TITLE]">
    <meta property="og:description" content="[BLOG SUMMARY]">
    <meta property="og:type" content="article">
    <meta property="og:url" content="https://sam-molyneux.com/bikepacking/[FOLDER]/">
    <meta property="og:image" content="https://sam-molyneux.com/images/[FOLDER]/[FIRST_IMAGE]">
    <link rel="stylesheet" href="/styles.css">
</head>

<body>
    <header>
        <nav>
            <a href="/bikepacking" class="link-unstyled"><img src="/gifs/bike.gif" alt="Bikepacking"></a>
            <a href="/" class="link-unstyled"><span class="site-title">Sam Molyneux</span></a>
            <a href="/tech" class="link-unstyled"><img src="/gifs/pc-transparent.gif" alt="Tech"></a>
        </nav>
    </header>

    <main class="post">
        <article>
        <hgroup>
            <h1>[TITLE]</h1>
            <p>[DATES COVERED]</p>
        </hgroup>
        <p><small>Published [TODAY'S DATE]</small></p>

        <!-- For each image, add a figure block like this: -->
        <figure class="block">
            <img src="/images/[FOLDER]/[FILENAME]"
                alt=""
                class="feature-image feature-image-landscape">
        </figure>

        </article>

        <section class="desc">
            <p><a href="/about">Why does it feel like I've gone through a time machine?</a></p>
        </section>

    </main>
</body>

</html>
```

6. Replace placeholders:
   - [TITLE] with the folder name, replacing underscores with spaces, using sentence case - capitalize first word and proper nouns only, keep words like "to", "the", "a", "and", "of" lowercase (e.g., "agadir_to_sidi_ifni" becomes "Agadir to Sidi Ifni")
   - [TODAY'S DATE] with today's date formatted as "Month DDth YYYY" (e.g., "January 28th 2026")
   - [DATES COVERED] with the user's answer from step 3
   - [FOLDER] with the folder name as provided
   - [FILENAME] with each image filename
   - [BLOG SUMMARY] with the user's answer from step 3

7. Add a figure.block for every image found in the folder (no figcaption needed initially)

8. Update the RSS feeds (both `bikepacking/feed.xml` and `blog/feed.xml`):

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

9. Update `bikepacking/index.html`'s `og:image` meta tag to point to the new post's first image:
   ```html
   <meta property="og:image" content="https://sam-molyneux.com/images/[FOLDER]/[FIRST_IMAGE]">
   ```

10. Append the new post URL to `sitemap.xml` (before the closing `</urlset>` tag):
    ```xml
      <url>
        <loc>https://sam-molyneux.com/bikepacking/[FOLDER]/</loc>
      </url>
    ```

11. Report what was created
