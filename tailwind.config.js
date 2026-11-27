import typography from '@tailwindcss/typography'
/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ['class'],
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  safelist: ['bg-rose-50', 'text-rose-600', 'bg-blue-50', 'text-blue-600', 'bg-green-50', 'text-green-600', 'bg-orange-50', 'text-orange-600', 'bg-purple-50', 'text-purple-600', 'bg-pink-50', 'text-pink-600', 'bg-amber-50', 'text-amber-600', 'bg-slate-50', 'text-slate-600'],
  theme: { extend: { colors: { border: 'hsl(var(--border))', input: 'hsl(var(--input))', ring: 'hsl(var(--ring))', background: 'hsl(var(--background))', foreground: 'hsl(var(--foreground))', primary: { DEFAULT: 'hsl(var(--primary))', foreground: 'hsl(var(--primary-foreground))' }, secondary: { DEFAULT: 'hsl(var(--secondary))', foreground: 'hsl(var(--secondary-foreground))' }, muted: { DEFAULT: 'hsl(var(--muted))', foreground: 'hsl(var(--muted-foreground))' }, accent: { DEFAULT: 'hsl(var(--accent))', foreground: 'hsl(var(--accent-foreground))' }, popover: { DEFAULT: 'hsl(var(--popover))', foreground: 'hsl(var(--popover-foreground))' }, card: { DEFAULT: 'hsl(var(--card))', foreground: 'hsl(var(--card-foreground))' } }, borderRadius: { xl: 'var(--radius)' } } },
  plugins: [typography],
}
