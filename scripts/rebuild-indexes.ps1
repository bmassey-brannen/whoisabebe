# scripts/rebuild-indexes.ps1
Write-Host "Rebuilding WhoIsAbebe index pages..." -ForegroundColor Cyan

$pages = @(
  "src/pages/index.astro",
  "src/pages/articles/index.astro",
  "src/pages/documents/index.astro",
  "src/pages/entities/index.astro",
  "src/pages/network/index.astro",
  "src/pages/reports/index.astro",
  "src/pages/timeline/index.astro"
)

foreach ($page in $pages) {
  $dir = Split-Path $page
  if (!(Test-Path $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
}

@'
---
import BaseLayout from "../layouts/BaseLayout.astro";
import articles from "../data/articles.json";
import entities from "../data/entities.json";
import documents from "../data/documents.json";
import timeline from "../data/timeline.json";

const latestArticles = articles.slice(0, 6);
const featuredEntities = entities.slice(0, 6);
const latestDocs = documents.slice(0, 6);
const timelineItems = timeline.slice(0, 5);
---

<BaseLayout title="Who Is Abebe?">
  <main class="home">
    <section class="hero">
      <p class="eyebrow">Local development. Public records. Open questions.</p>
      <h1>Who Is Abebe?</h1>
      <p class="lede">
        Tracking properties, LLCs, public claims, documents, grants, and development activity connected to the St. George Crossing story.
      </p>

      <div class="hero-links">
        <a href="/reports/st-george-crossing/">Read the St. George Crossing Report</a>
        <a href="/entities/">Explore Entities</a>
        <a href="/documents/">View Documents</a>
      </div>
    </section>

    <section class="stats">
      <div><strong>{articles.length}</strong><span>Articles</span></div>
      <div><strong>{entities.length}</strong><span>Entities</span></div>
      <div><strong>{documents.length}</strong><span>Documents</span></div>
      <div><strong>{timeline.length}</strong><span>Timeline Events</span></div>
    </section>

    <section class="grid">
      <div>
        <h2>Published Articles</h2>
        {latestArticles.map((item) => (
          <article class="card">
            <p>{item.date || item.publishedDate || "Date unknown"}</p>
            <h3><a href={item.url}>{item.title}</a></h3>
            {item.source && <span>{item.source}</span>}
          </article>
        ))}
        <a class="more" href="/articles/">View all articles →</a>
      </div>

      <div>
        <h2>Entities</h2>
        {featuredEntities.map((item) => (
          <article class="card">
            <h3>{item.name}</h3>
            <p>{item.type || item.category || "Entity"}</p>
            {item.address && <span>{item.address}</span>}
          </article>
        ))}
        <a class="more" href="/entities/">View all entities →</a>
      </div>
    </section>

    <section class="grid">
      <div>
        <h2>Documents</h2>
        {latestDocs.map((item) => (
          <article class="card">
            <p>{item.date || "Date unknown"}</p>
            <h3><a href={item.url || item.file || "#"}>{item.title}</a></h3>
            {item.type && <span>{item.type}</span>}
          </article>
        ))}
        <a class="more" href="/documents/">View archive →</a>
      </div>

      <div>
        <h2>Timeline</h2>
        {timelineItems.map((item) => (
          <article class="card">
            <p>{item.date || "Date unknown"}</p>
            <h3>{item.title}</h3>
            {item.description && <span>{item.description}</span>}
          </article>
        ))}
        <a class="more" href="/timeline/">View timeline →</a>
      </div>
    </section>
  </main>
</BaseLayout>

<style>
  .home { max-width: 1120px; margin: 0 auto; padding: 3rem 1rem; }
  .hero { padding: 4rem 0; border-bottom: 1px solid #ddd; }
  .eyebrow { text-transform: uppercase; letter-spacing: .12em; font-size: .8rem; opacity: .7; }
  h1 { font-size: clamp(3rem, 8vw, 6rem); margin: 0; line-height: .9; }
  .lede { max-width: 760px; font-size: 1.25rem; line-height: 1.6; }
  .hero-links { display: flex; flex-wrap: wrap; gap: 1rem; margin-top: 2rem; }
  .hero-links a, .more { font-weight: 700; }
  .stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; margin: 2rem 0; }
  .stats div { border: 1px solid #ddd; padding: 1.25rem; border-radius: 14px; }
  .stats strong { display: block; font-size: 2rem; }
  .stats span { opacity: .7; }
  .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin: 3rem 0; }
  .card { border: 1px solid #ddd; border-radius: 14px; padding: 1rem; margin-bottom: 1rem; }
  .card p { margin: 0 0 .4rem; opacity: .7; font-size: .9rem; }
  .card h3 { margin: 0 0 .4rem; }
  .card span { opacity: .75; }
  @media (max-width: 800px) {
    .stats, .grid { grid-template-columns: 1fr; }
  }
</style>
'@ | Set-Content "src/pages/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
import articles from "../../data/articles.json";
---

<BaseLayout title="Articles | Who Is Abebe?">
  <main class="page">
    <h1>Published Articles</h1>
    <p>Local coverage and public reporting connected to the development story.</p>

    <section>
      {articles.map((item) => (
        <article class="card">
          <p>{item.date || item.publishedDate || "Date unknown"}</p>
          <h2><a href={item.url}>{item.title}</a></h2>
          {item.source && <span>{item.source}</span>}
        </article>
      ))}
    </section>
  </main>
</BaseLayout>

<style>
  .page { max-width: 960px; margin: 0 auto; padding: 3rem 1rem; }
  .card { border-bottom: 1px solid #ddd; padding: 1.5rem 0; }
  .card p { opacity: .7; margin: 0 0 .5rem; }
  .card h2 { margin: 0; }
</style>
'@ | Set-Content "src/pages/articles/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
import documents from "../../data/documents.json";
---

<BaseLayout title="Documents | Who Is Abebe?">
  <main class="page">
    <h1>Document Archive</h1>
    <p>Primary documents, screenshots, PDFs, public records, and supporting evidence.</p>

    <section class="grid">
      {documents.map((item) => (
        <article class="card">
          <p>{item.date || "Date unknown"}</p>
          <h2><a href={item.url || item.file || "#"}>{item.title}</a></h2>
          {item.type && <span>{item.type}</span>}
          {item.description && <p>{item.description}</p>}
        </article>
      ))}
    </section>
  </main>
</BaseLayout>

<style>
  .page { max-width: 1100px; margin: 0 auto; padding: 3rem 1rem; }
  .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem; }
  .card { border: 1px solid #ddd; border-radius: 14px; padding: 1rem; }
  .card p:first-child { opacity: .7; margin-top: 0; }
</style>
'@ | Set-Content "src/pages/documents/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
import entities from "../../data/entities.json";
---

<BaseLayout title="Entities | Who Is Abebe?">
  <main class="page">
    <h1>Entities</h1>
    <p>LLCs, properties, addresses, people, and organizations in the research file.</p>

    <section class="grid">
      {entities.map((item) => (
        <article class="card">
          <h2>{item.name}</h2>
          <p>{item.type || item.category || "Entity"}</p>
          {item.address && <span>{item.address}</span>}
          {item.description && <p>{item.description}</p>}
        </article>
      ))}
    </section>
  </main>
</BaseLayout>

<style>
  .page { max-width: 1100px; margin: 0 auto; padding: 3rem 1rem; }
  .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem; }
  .card { border: 1px solid #ddd; border-radius: 14px; padding: 1rem; }
  .card h2 { margin-top: 0; }
  .card span { opacity: .75; }
</style>
'@ | Set-Content "src/pages/entities/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
import relationships from "../../data/relationships.json";
---

<BaseLayout title="Network | Who Is Abebe?">
  <main class="page">
    <h1>Network Map</h1>
    <p>Known relationships between entities, addresses, people, properties, and public records.</p>

    <section>
      {relationships.map((item) => (
        <article class="card">
          <h2>{item.from} → {item.to}</h2>
          <p>{item.relationship || item.type || "Relationship"}</p>
          {item.notes && <span>{item.notes}</span>}
        </article>
      ))}
    </section>
  </main>
</BaseLayout>

<style>
  .page { max-width: 960px; margin: 0 auto; padding: 3rem 1rem; }
  .card { border-bottom: 1px solid #ddd; padding: 1.25rem 0; }
  .card h2 { margin: 0 0 .5rem; }
</style>
'@ | Set-Content "src/pages/network/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
---

<BaseLayout title="Reports | Who Is Abebe?">
  <main class="page">
    <h1>Reports</h1>
    <p>Longform investigative writeups built from the public record archive.</p>

    <article class="card">
      <p>Featured Report</p>
      <h2><a href="/reports/st-george-crossing/">St. George Crossing</a></h2>
      <span>The developing master report for the 1200+ acre project and connected entities.</span>
    </article>
  </main>
</BaseLayout>

<style>
  .page { max-width: 900px; margin: 0 auto; padding: 3rem 1rem; }
  .card { border: 1px solid #ddd; border-radius: 14px; padding: 1.5rem; }
  .card p { opacity: .7; margin-top: 0; }
</style>
'@ | Set-Content "src/pages/reports/index.astro"

@'
---
import BaseLayout from "../../layouts/BaseLayout.astro";
import timeline from "../../data/timeline.json";
---

<BaseLayout title="Timeline | Who Is Abebe?">
  <main class="page">
    <h1>Timeline</h1>
    <p>A chronological view of filings, purchases, articles, public claims, and development milestones.</p>

    <section>
      {timeline.map((item) => (
        <article class="event">
          <p>{item.date || "Date unknown"}</p>
          <h2>{item.title}</h2>
          {item.description && <span>{item.description}</span>}
        </article>
      ))}
    </section>
  </main>
</BaseLayout>

<style>
  .page { max-width: 900px; margin: 0 auto; padding: 3rem 1rem; }
  .event { border-left: 3px solid #111; padding: 0 0 1.5rem 1rem; margin-bottom: 1rem; }
  .event p { opacity: .7; margin: 0 0 .4rem; }
  .event h2 { margin: 0 0 .4rem; }
</style>
'@ | Set-Content "src/pages/timeline/index.astro"

Write-Host "Done. Now run: npm run dev" -ForegroundColor Green