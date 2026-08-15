-- VÉLORA Fashion Store — Supabase schema
create extension if not exists pgcrypto;

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text,
  price numeric not null default 0,
  discount numeric default 0,
  image text,
  images jsonb default '[]'::jsonb,
  sizes jsonb default '[]'::jsonb,
  colors jsonb default '[]'::jsonb,
  stock integer default 0,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  order_code text unique not null,
  customer_name text not null,
  phone text not null,
  address text not null,
  pincode text not null,
  payment_method text default 'cod',
  total numeric not null default 0,
  items jsonb default '[]'::jsonb,
  status text not null default 'placed',
  created_at timestamptz default now()
);

create table if not exists site_settings (
  id integer primary key,
  logo text default 'VÉLORA',
  hero_title text default 'Everyday, elevated.',
  hero_text text default 'Curated fashion essentials designed for your everyday style.',
  announcement text default 'Free shipping on selected orders • New collection live',
  accent text default '#111111'
);

insert into site_settings(id) values(1) on conflict(id) do nothing;

alter table products enable row level security;
alter table orders enable row level security;
alter table site_settings enable row level security;

-- Public catalogue/settings
create policy "public can read active products" on products for select using (active = true);
create policy "public can read settings" on site_settings for select using (true);

-- Demo-friendly order policy: allows customer order creation and order lookup by order code.
-- For production, use customer authentication and stricter policies.
create policy "public can create orders" on orders for insert with check (true);
create policy "public can read orders" on orders for select using (true);

-- Admin policies require the authenticated account.
-- For production, replace these with a proper admin-role claim/table.
create policy "authenticated can manage products" on products for all to authenticated using (true) with check (true);
create policy "authenticated can manage orders" on orders for all to authenticated using (true) with check (true);
create policy "authenticated can manage settings" on site_settings for all to authenticated using (true) with check (true);

-- Optional sample products
insert into products(name,category,price,discount,image,stock,sizes,colors)
values
('Classic Oversized Tee','Men',799,0,'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=80',20,'["S","M","L","XL"]','["Black","White"]'),
('Minimal Linen Shirt','Men',1299,10,'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&w=700&q=80',15,'["M","L","XL"]','["White","Beige"]'),
('Elegant Summer Dress','Women',1599,15,'https://images.unsplash.com/photo-1595777457583-95e059d581b8?auto=format&fit=crop&w=700&q=80',10,'["S","M","L"]','["Black","Cream"]')
on conflict do nothing;
