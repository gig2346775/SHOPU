-- Run this in Supabase: Dashboard → SQL Editor → New query → paste this → Run

create table shops (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid references auth.users not null,
  name text not null,
  slug text unique not null,
  whatsapp text,
  created_at timestamp default now()
);

create table products (
  id uuid primary key default gen_random_uuid(),
  shop_id uuid references shops(id) on delete cascade not null,
  name text not null,
  price numeric not null,
  description text,
  image_url text,
  created_at timestamp default now()
);

-- Security: turn on row level security
alter table shops enable row level security;
alter table products enable row level security;

-- Anyone can view shops and products (needed for the public storefront page)
create policy "Public can view shops" on shops for select using (true);
create policy "Public can view products" on products for select using (true);

-- Only the owner can create/edit/delete their own shop
create policy "Owner can insert their shop" on shops for insert with check (auth.uid() = owner_id);
create policy "Owner can update their shop" on shops for update using (auth.uid() = owner_id);
create policy "Owner can delete their shop" on shops for delete using (auth.uid() = owner_id);

-- Only the shop owner can manage their own products
create policy "Owner can insert products" on products for insert with check (
  auth.uid() = (select owner_id from shops where shops.id = shop_id)
);
create policy "Owner can update products" on products for update using (
  auth.uid() = (select owner_id from shops where shops.id = shop_id)
);
create policy "Owner can delete products" on products for delete using (
  auth.uid() = (select owner_id from shops where shops.id = shop_id)
);