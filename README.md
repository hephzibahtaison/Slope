# Slope 🎵 — Complete Full-Stack App

A real social music platform. People can sign up, post songs, follow artists, like tracks, and leave suggestions.

## Features (finished)

- Landing page
- Sign up / Login (real authentication)
- Protected routes
- Home feed (real songs from database)
- **Upload songs** (audio + cover → Supabase Storage)
- **User profiles** (with stats)
- **Follow / Unfollow**
- **Like songs**
- **Suggestions** from followers
- Search (songs + artists)
- Spotify-style sidebar layout

## How to run (only 4 steps)

### 1. Add your keys

Create a file named `.env.local` in the root folder:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 2. Database + Storage (if you haven’t already)

1. Supabase → SQL Editor → paste and run `supabase-schema.sql`
2. Storage → create two **public** buckets: `songs` and `covers`

### 3. Install & run

```bash
npm install
npm run dev
```

Open http://localhost:3000

### 4. Deploy (make it public)

1. Push to GitHub
2. Import into [vercel.com](https://vercel.com)
3. Add the same two environment variables
4. Deploy → you get a real public link

That’s it. People can start using Slope.

---

You only need to put your private Supabase keys. Everything else is ready.
