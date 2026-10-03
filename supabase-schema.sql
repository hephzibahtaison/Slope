-- ============================================
-- SLOPE DATABASE SCHEMA
-- Run this in your Supabase SQL Editor
-- ============================================

-- Profiles (extends auth.users)
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  username text unique not null,
  full_name text,
  bio text,
  avatar_url text,
  cover_url text,
  is_artist boolean default true,
  created_at timestamptz default now()
);

-- Songs
create table public.songs (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  title text not null,
  caption text,
  genre text,
  audio_url text not null,
  cover_url text,
  duration_seconds integer default 0,
  plays integer default 0,
  created_at timestamptz default now()
);

-- Likes
create table public.likes (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  song_id uuid references public.songs(id) on delete cascade not null,
  created_at timestamptz default now(),
  unique(user_id, song_id)
);

-- Follows
create table public.follows (
  id uuid default gen_random_uuid() primary key,
  follower_id uuid references public.profiles(id) on delete cascade not null,
  following_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  unique(follower_id, following_id)
);

-- Suggestions (feedback from followers)
create table public.suggestions (
  id uuid default gen_random_uuid() primary key,
  song_id uuid references public.songs(id) on delete cascade not null,
  user_id uuid references public.profiles(id) on delete cascade not null,
  content text not null,
  created_at timestamptz default now()
);

-- Enable Row Level Security
alter table public.profiles enable row level security;
alter table public.songs enable row level security;
alter table public.likes enable row level security;
alter table public.follows enable row level security;
alter table public.suggestions enable row level security;

-- Profiles policies
create policy "Public profiles are viewable by everyone" on profiles for select using (true);
create policy "Users can insert their own profile" on profiles for insert with check (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);

-- Songs policies
create policy "Songs are viewable by everyone" on songs for select using (true);
create policy "Users can insert their own songs" on songs for insert with check (auth.uid() = user_id);
create policy "Users can update own songs" on songs for update using (auth.uid() = user_id);
create policy "Users can delete own songs" on songs for delete using (auth.uid() = user_id);

-- Likes policies
create policy "Likes are viewable by everyone" on likes for select using (true);
create policy "Users can like songs" on likes for insert with check (auth.uid() = user_id);
create policy "Users can unlike songs" on likes for delete using (auth.uid() = user_id);

-- Follows policies
create policy "Follows are viewable by everyone" on follows for select using (true);
create policy "Users can follow" on follows for insert with check (auth.uid() = follower_id);
create policy "Users can unfollow" on follows for delete using (auth.uid() = follower_id);

-- Suggestions policies
create policy "Suggestions are viewable by everyone" on suggestions for select using (true);
create policy "Users can leave suggestions" on suggestions for insert with check (auth.uid() = user_id);
create policy "Users can delete own suggestions" on suggestions for delete using (auth.uid() = user_id);

-- Storage bucket for audio + covers (run in Storage section or SQL)
-- insert into storage.buckets (id, name, public) values ('songs', 'songs', true);
-- insert into storage.buckets (id, name, public) values ('covers', 'covers', true);
