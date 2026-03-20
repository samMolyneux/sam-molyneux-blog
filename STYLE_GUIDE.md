# Style Guide

Standards and conventions for sam-molyneux.com, derived from existing pages.

---

## 1. General Principles

- No JavaScript. No frameworks. No Sass. Pure semantic HTML and CSS.
- No flexbox unless absolutely necessary.
- Single global stylesheet (`/styles.css`).
- Nostalgic, early-2000s aesthetic with textured background image.
- Max content width: 750px, centered on the page.
- All URLs use trailing slashes (e.g., `/bikepacking/agadir/`).

---

## 2. HTML Document Structure

Every page must include:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sam Molyneux - [Page Title]</title>
    <meta name="description" content="[One-line description]">
    <link rel="canonical" href="https://sam-molyneux.com/[path]/">
    <link rel="human-json" href="/human.json">

    <!-- Open Graph -->
    <meta property="og:title" content="Sam Molyneux - [Page Title]">
    <meta property="og:description" content="[Description]">
    <meta property="og:type" content="website|article">
    <meta property="og:url" content="https://sam-molyneux.com/[path]/">
    <!-- og:image only when a relevant image exists -->

    <!-- Stylesheet (always absolute path from subpages) -->
    <link rel="stylesheet" href="/styles.css">

    <!-- RSS feed link (listing pages only) -->
    <link rel="alternate" type="application/rss+xml" title="[Feed Name]" href="/[section]/feed.xml">
</head>
```

### Rules

- `<title>`: Format is `Sam Molyneux - [Page Title]`. Homepage is just `Sam Molyneux`.
- `og:type`: Use `article` for blog posts, `website` for everything else.
- `og:image`: Only include when a representative image exists. Use full absolute URL.
- RSS `<link>`: Only on listing/index pages, not on individual posts.

---

## 3. Navigation Header

### Homepage

```html
<header>
    <nav>
        <a href="/bikepacking" class="link-unstyled"><img src="/gifs/bike.gif" alt="Bikepacking" width="80" height="60"></a>
        <h1>Sam Molyneux</h1>
        <a href="/tech" class="link-unstyled"><img src="/gifs/pc-transparent.gif" alt="Tech" width="31" height="32"></a>
    </nav>
</header>
```

### All Other Pages

```html
<header>
    <nav>
        <a href="/bikepacking" class="link-unstyled"><img src="/gifs/bike.gif" alt="Bikepacking" width="80" height="60"></a>
        <a href="/" class="link-unstyled"><span class="site-title">Sam Molyneux</span></a>
        <a href="/tech" class="link-unstyled"><img src="/gifs/pc-transparent.gif" alt="Tech" width="31" height="32"></a>
    </nav>
</header>
```

### Rules

- Homepage uses a plain `<h1>` for the site title (not a link).
- All other pages wrap the site title in an `<a>` linking back to `/` with class `link-unstyled`.
- The bike GIF links to `/bikepacking`, the PC GIF links to `/tech`.

---

## 4. Page Types

### 4a. Blog Post Page

Wrapper: `<main class="post"><article>...</article></main>`

```html
<main class="post">
    <article>
        <hgroup>
            <h1>Post Title</h1>
            <p>Travel date range (bikepacking only)</p>
        </hgroup>
        <p><small>Published <time datetime="YYYY-MM-DD">[Month] [Day ordinal] [Year]</time></small></p>

        <!-- Content: figures and/or sections -->
    </article>

    <footer class="desc">
        <p><a href="/about">Why does it feel like I've gone through a time machine?</a></p>
    </footer>
</main>
```

#### Rules

- Always wrapped in `<main class="post">` then `<article>`.
- Title in `<hgroup>` with `<h1>`.
- Bikepacking posts include a `<p>` inside `<hgroup>` with the travel date range.
- Tech posts may omit the date range `<p>` from `<hgroup>`.
- Published date uses `<p><small>Published <time datetime="YYYY-MM-DD">[date]</time></small></p>` immediately after `<hgroup>`.
- Date format: `Month Dayth Year` (e.g., "March 19th 2026"). No comma before year.
- Ends with the "time machine" link section (optional for tech-only posts).

### 4b. Listing/Index Page

Wrapper: `<main>` (no class)

```html
<main>
    <h1>Section Title</h1>

    <article class="block">
        <hgroup>
            <h2>Post Title</h2>
            <p>Travel date range (bikepacking only)</p>
        </hgroup>
        <p><small>Published <time datetime="YYYY-MM-DD">[date]</time></small></p>
        <p>Short excerpt (<a href="/[category]/[slug]">read 'Post Title'</a>)</p>
    </article>

    <!-- More articles... -->

    <footer class="desc">
        <p><a href="/about">Why does it feel like I've gone through a time machine?</a></p>
        <p><a href="/[section]/feed.xml">RSS</a></p>
    </footer>
</main>
```

#### Rules

- Posts listed in reverse chronological order (newest first).
- Each post is an `<article class="block">`.
- Post titles use `<h2>` inside `<hgroup>`.
- Link text format: `read 'Post Title'` (with single quotes).
- Footer section includes both the about link and an RSS link.

### 4c. Static Page (About, etc.)

Wrapper: `<main>` (no class)

```html
<main>
    <h1>Page Title</h1>
    <section class="block">
        <!-- Content -->
    </section>
</main>
```

---

## 5. Content Blocks

All content lives inside either `<section class="block">` (for text) or `<figure class="block">` (for images). These are the two primary content containers.

### Text Block

```html
<section class="block">
    <p>Paragraph text.</p>
    <h2>Section heading</h2>
    <p>More text.</p>
</section>
```

### Image Block

```html
<figure class="block">
    <img src="/images/[slug]/[filename]"
         alt="Detailed description"
         width="1920" height="1440"
         loading="lazy"
         class="feature-image feature-image-landscape">
    <figcaption>Optional caption</figcaption>
</figure>
```

### Rules

- `.block` provides padding (40px) and whitesmoke background.
- Inside `.post`, blocks get additional 20px margin.
- Text content and images are never mixed in the same block (a `<section>` should not contain `<figure>` elements and vice versa).
- Multiple consecutive sections or figures are separate blocks.

---

## 6. Image Standards

### Classes

| Class | Usage |
|-------|-------|
| `feature-image` | Required base class on all post images |
| `feature-image-landscape` | Landscape/wide images: `width: 100%` |
| `feature-image-portrait` | Portrait/tall images: `width: 50%` |

### Rules

- Images are always wrapped in `<figure class="block">`.
- All images must have descriptive `alt` text.
- Images stored in `/images/[post-slug]/`.
- `<figcaption>` is optional, placed after the `<img>`.
- All images must include `width` and `height` attributes with actual pixel dimensions (prevents layout shift). CSS controls the rendered size via `width: auto` paired with a fixed height — this preserves aspect ratio while the HTML attributes reserve the correct space.
- All images except the first on each page must include `loading="lazy"` (the first image is above the fold).
- Nav header GIFs and project list GIFs include `width`/`height` but never `loading="lazy"` (always above the fold).

---

## 7. Typography

### Headings

| Level | Usage | Size | Responsive Size |
|-------|-------|------|-----------------|
| `<h1>` | Page/post title | 2.5rem | 2rem |
| `<h2>` | Major sections, post titles in listings | 2rem | 1.75rem |
| `<h3>` | Subsections | 1.5rem | 1.25rem |
| `<h4>` | Sub-subsections | default | default |

- All headings: `color: #2c3e50`.
- Heading hierarchy must be respected (no skipping levels).
- `<hgroup>` used to pair a heading with a subtitle or date.

### Body Text

- Body color: `#333`.
- Line height: `1.6`.
- Standard `<p>` tags with browser-default margins.

### Small/Meta Text

- Published dates: `<p><small>Published <time datetime="YYYY-MM-DD">[date]</time></small></p>`.
- Disclaimers: `<p><small>[disclaimer text]</small></p>`.
- The `<time>` element's `datetime` attribute uses ISO 8601 format (`YYYY-MM-DD`).

### Emphasis

- `<em>` for italic emphasis.
- `<strong>` for bold emphasis.

### Inline Code

- `<code>` for inline code references.
- Renders in browser-default monospace.

### Blockquotes

- `<blockquote>` element.
- Styled: 3px solid `#999` left border, `#555` text color, 1em left padding.
- Can contain `<p>`, `<ul>`, `<ol>`, and other block-level elements.

### Links

- Default browser styling (blue, underlined) for content links.
- `.link-unstyled` class for navigation/decorative links: inherits color, no underline.

---

## 8. Lists

### Unordered Lists

```html
<ul>
    <li>Item one</li>
    <li>Item two</li>
</ul>
```

### Ordered Lists

```html
<ol>
    <li>First step</li>
    <li>Second step</li>
</ol>
```

### Rules

- Default browser bullet/number styling.
- Lists can appear inside `<section class="block">`, `<blockquote>`, or `<figcaption>`.
- No custom list styling except on `.projects-list` (homepage only).

---

## 9. CSS Classes Reference

| Class | Element | Purpose |
|-------|---------|---------|
| `.block` | `section`, `figure`, `article` | Content container: whitesmoke bg, 40px padding |
| `.post` | `main` | Blog post wrapper; adds 20px margin to child `.block` |
| `.desc` | `footer`, `section` | Centered text section. Use `<footer>` for page footers, `<section>` for mid-page content (homepage only) |
| `.center` | any | Centers text |
| `.link-unstyled` | `a` | Removes link styling (color + underline) |
| `.site-title` | `span` | Site name in nav (non-homepage) |
| `.feature-image` | `img` | Block display, centered |
| `.feature-image-landscape` | `img` | 100% width |
| `.feature-image-portrait` | `img` | 50% width |
| `.projects-list` | `ul` wrapper | Homepage project list |

---

## 10. Color Palette

| Token | Value | Usage |
|-------|-------|-------|
| Heading color | `#2c3e50` | All headings, site title |
| Body text | `#333` | Paragraphs, default text |
| Secondary text | `#555` | Blockquote text |
| Meta text | `#666` | Footer text |
| Blockquote border | `#999` | Left border on blockquotes |
| Block background | `whitesmoke` | `.block` elements |
| Page background | textured image | `images/recbg.jpeg` |

---

## 11. Responsive Breakpoints

Single breakpoint at `768px`:

| Property | Desktop | Mobile (<=768px) |
|----------|---------|-------------------|
| Body padding | 0 20px | 0 15px |
| h1 / .site-title | 2.5rem | 2rem |
| h2 | 2rem | 1.75rem |
| h3 | 1.5rem | 1.25rem |

---

## 12. Feed (RSS) Standards

Three feeds must be kept in sync:
- `/blog/feed.xml` — all posts
- `/bikepacking/feed.xml` — bikepacking posts only
- `/tech/feed.xml` — tech posts only

### Feed Format

```xml
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Sam Molyneux - [Section]</title>
    <link>https://sam-molyneux.com/[section]</link>
    <description>[Feed description]</description>
    <atom:link href="https://sam-molyneux.com/[section]/feed.xml" rel="self" type="application/rss+xml"/>
    <item>
      <title>[Post Title]</title>
      <link>https://sam-molyneux.com/[full-post-url]</link>
      <pubDate>[RFC 2822 date]</pubDate>
      <description>[Short excerpt]</description>
    </item>
  </channel>
</rss>
```

### Rules

- Items in reverse chronological order.
- Dates in RFC 2822 format: `Thu, 19 Mar 2026 00:00:00 +0000`.
- When a post is added, update both the section feed AND `/blog/feed.xml`.

---

## 13. New Post Checklist

When publishing a new post:

1. Create `/[category]/[post_slug]/index.html`
2. Add images to `/images/[post_slug]/`
3. Add `<article class="block">` entry to `/[category]/index.html` (at the top)
4. Add `<article class="block">` entry to `/blog/index.html` (at the top, maintaining overall chronological order)
5. Add `<item>` to `/[category]/feed.xml` (at the top)
6. Add `<item>` to `/blog/feed.xml` (at the top)
7. Add `<url>` to `/sitemap.xml`

---

## 14. Markdown to HTML Mapping

When converting markdown content to styled HTML for this site, use the following mappings. A live reference page demonstrating each mapping is available at `/reference/`.

### Inline Elements

| Markdown | HTML |
|----------|------|
| `**bold**` | `<strong>bold</strong>` |
| `*italic*` | `<em>italic</em>` |
| `` `code` `` | `<code>code</code>` |
| `[text](url)` | `<a href="url">text</a>` |

### Block Elements

| Markdown | HTML |
|----------|------|
| `# Heading 1` | `<h1>Heading 1</h1>` (page title only, inside `<hgroup>`) |
| `## Heading 2` | `<h2>Heading 2</h2>` |
| `### Heading 3` | `<h3>Heading 3</h3>` |
| `#### Heading 4` | `<h4>Heading 4</h4>` |
| Paragraph text | `<p>Paragraph text</p>` |
| `> quote` | `<blockquote><p>quote</p></blockquote>` |
| `- item` | `<ul><li>item</li></ul>` |
| `1. item` | `<ol><li>item</li></ol>` |
| `![alt](src)` | See image block structure below |
| `---` | Not used. Use a new `<section class="block">` for thematic breaks. |

### Image Mapping

Markdown image syntax maps to a full figure block:

```
![Alt text](/images/slug/file.jpg)
```

Becomes:

```html
<figure class="block">
    <img src="/images/slug/file.jpg"
         alt="Alt text"
         width="1920" height="1440"
         loading="lazy"
         class="feature-image feature-image-landscape">
</figure>
```

If a caption is needed, add `<figcaption>` after the `<img>`. Omit `loading="lazy"` for the first image on each page.

### Structural Rules

- Thematic breaks (`---`) become new `<section class="block">` elements rather than `<hr>` tags.
- All text content is wrapped in `<section class="block">`.
- All images are wrapped in `<figure class="block">`.
- Nested blockquotes are not used. Keep blockquotes flat.
- Code blocks (triple backtick) are not currently styled. Use inline `<code>` for code references.
