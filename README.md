# VÉLORA Fashion Store

Files:
- index.html — customer storefront, search, cart, checkout, order tracking
- admin.html — admin dashboard, product CRUD, orders/status, website settings
- supabase.sql — database tables and policies

Setup:
1. Create a Supabase project.
2. Run supabase.sql in Supabase SQL Editor.
3. Create an Auth user for the admin in Supabase Authentication.
4. Put your Supabase project URL and anon/publishable key in BOTH HTML files where `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` appear.
5. Deploy the folder to Netlify or another static host.
6. Open `/admin.html` for the admin panel.

Important:
- The starter checkout uses Cash on Delivery. The online-payment option is only a placeholder until a payment gateway is connected.
- For production, tighten RLS so customers can only read their own orders and create a secure customer identity flow.
- Direct phone image upload can be added through Supabase Storage; the current admin accepts image URLs to keep the starter deployment simple.
- 
