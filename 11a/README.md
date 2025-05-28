# Steps to reproduce my Auth Integration

1. Sign up for a free account at Supabase.
2. Create a new project on Supabase.
4. Create a new JavaScript-based React project with `npm create vite`.
3. Press the connect button at the top of the page.
5. Press the "App Frameworks" tab, then choose React for the framework and Vite for "Using".
6. Create the `.env` and `utils/supabase.ts` files with the displayed text content.
7. Go to the Supabase Auth with React step-by-step guide: `https://supabase.com/docs/guides/auth/quickstarts/react`.
8. Install the packages in step 3 of the guide.
9. Replace the contents of your `App.jsx` with the code in step 4 of the guide.
10. In your `App.jsx`, remove the `supabase` constant, and instead insert `import supabase from './utils/supabase.js'` at the top of the file.
11. Start the app with `npm run dev`. You should now be presented with a combined login and signup form. Upon creating an account and logging in, the form will be replaced by the string "Logged in!" until you clear your browser cache.