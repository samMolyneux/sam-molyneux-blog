---
name: create-blog-post
description: Create a new blog post from a folder of images
disable-model-invocation: true
allowed-tools: Read, Bash, Write, Glob, Edit, AskUserQuestion
argument-hint: [folder-name]
---

Create a blog post outline from images in the `$ARGUMENTS` folder:

1. Optimize all images in the folder:
   ```bash
   ./optimize-images.sh images/$ARGUMENTS
   ```

2. Use Glob to find all images in `images/$ARGUMENTS/`

3. Use AskUserQuestion to prompt for:
   - **Dates covered**: The date range for this blog post (e.g., "January 5th to 7th 2026")
   - **Blog summary**: A short description for the blog index page (e.g., "Cycling along the coast from Agadir to Sidi Ifni")

4. Add an article entry to `blog/index.html` at the top (after `<h1>Blog</h1>`), using this template:

```html
        <article class="block">
            <span><h2>[TITLE]</h2> [DATES COVERED]</span>
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
    <link rel="stylesheet" href="/styles.css">
</head>

<body>
    <header>
        <a href="/" class="link-unstyled">
            <img src="/gifs/bike.gif" alt="Bike animation">
            <span class="site-title">Sam Molyneux</span>
            <img src="/gifs/pc-transparent.gif" alt="Computer animation">
        </a>
    </header>

    <main class="post">
        <span><h1>[TITLE]</h1> [DATES COVERED]</span>
        <p><small>Published [TODAY'S DATE]</small></p>

        <!-- For each image, add a figure block like this: -->
        <figure class="block">
            <img src="/images/[FOLDER]/[FILENAME]"
                alt=""
                class="feature-image feature-image-landscape">
        </figure>

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

8. Report what was created
