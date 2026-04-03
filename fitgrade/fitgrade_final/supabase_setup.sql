-- Run this in Supabase SQL Editor

-- Profiles table
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  name text,
  email text,
  checks_used int default 0,
  is_pro boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

-- Checks table
create table checks (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade,
  score float,
  label text,
  what_works text[],
  improvements text[],
  quick_swaps text[],
  photo_url text,
  mode text default 'photo',
  created_at timestamp with time zone default timezone('utc'::text, now())
);

-- Enable Row Level Security
alter table profiles enable row level security;
alter table checks enable row level security;

-- Policies: users can only see/edit their own data
create policy "Users can view own profile" on profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);
create policy "Users can insert own profile" on profiles for insert with check (auth.uid() = id);

create policy "Users can view own checks" on checks for select using (auth.uid() = user_id);
create policy "Users can insert own checks" on checks for insert with check (auth.uid() = user_id);
create policy "Users can delete own checks" on checks for delete using (auth.uid() = user_id);

-- Function to increment checks_used
create or replace function increment_checks_used(uid uuid)
returns void as $$
  update profiles set checks_used = checks_used + 1 where id = uid;
$$ language sql security definer;
