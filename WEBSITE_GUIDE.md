# Brogrammers - Professional Event Solutions Website

## 🎉 What's Been Built

A complete, professional website for your event solutions company with:

### ✨ Key Features

1. **Fixed Navigation Bar**
   - Appears on scroll with backdrop blur
   - Quick links to all sections
   - "Get Started" CTA button
   - Mobile-ready (burger menu button in place)

2. **Hero Section**
   - Compelling tagline: "Transforming Events Into Experiences"
   - Clear value proposition
   - Three service cards (Hardware, Software, Full Solutions)
   - Dual CTAs (View Work / Get In Touch)

3. **Projects Gallery**
   - 8 project cards in responsive grid (3 columns on desktop)
   - Compact card design with hover effects
   - Each card has:
     - Project image
     - Title and description
     - Preview button (opens video dialog)
     - External link button

4. **Video Preview Dialog**
   - Modal popup for project videos
   - Video player with controls
   - Fallback UI when no video available
   - Links to live project
   - Keyboard accessible (ESC to close)

5. **Contact Section**
   - Three contact methods (Email, Chat, Phone)
   - Contact form ready for integration
   - Professional layout

6. **Footer**
   - Company branding
   - Quick navigation
   - Copyright information

## 🎨 Design & Theme

- **Color Scheme**: Professional blue + warm amber (event-appropriate)
- **Background**: Dark slate gradients
- **Typography**: Clean, modern sans-serif
- **Layout**: Responsive grid system
- **Spacing**: Consistent padding and margins

## 📁 Project Structure

```
src/
├── Components/
│   ├── Card.tsx              (80 LOC) - Project cards
│   ├── Hero.tsx              (70 LOC) - Landing hero section
│   ├── VideoDialog.tsx       (160 LOC) - Video preview modal
│   ├── ProjectsSection.tsx   (65 LOC) - Projects grid
│   ├── ContactSection.tsx    (130 LOC) - Contact form
│   └── Navbar.tsx            (70 LOC) - Navigation bar
├── Pages/
│   └── Landing.tsx           (35 LOC) - Main page assembly
├── utils/
│   └── mockData.ts           - Project data
├── App.tsx                   - Root component
└── index.css                 - Global styles + theme colors
```

## 🚀 Quick Start

1. **Run the development server:**
   ```bash
   npm run dev
   ```

2. **Open in browser:**
   - Navigate to `http://localhost:5173` (or the port shown)

## 📹 Adding Project Videos

### Step 1: Add Video Files
Place your videos in `public/videos/`:
```
public/videos/
├── tagglabs.mp4
├── emotion-design.mp4
├── ai-photo-booth.mp4
└── ...
```

### Step 2: Update Mock Data
In `src/utils/mockData.ts`, uncomment the videoUrl lines:

```typescript
{
  id: "1",
  title: "Tagglabs",
  videoUrl: "/videos/tagglabs.mp4", // Uncomment this
}
```

### Step 3: Test
Click the "Preview" button on any card to see the video!

## 🔧 Customization Guide

### Update Company Info

**Contact Details** (`src/Components/ContactSection.tsx`):
```typescript
// Line ~27
<a href="mailto:your-email@company.com">
  your-email@company.com
</a>

// Line ~45
<a href="tel:+1234567890">
  +1 (234) 567-890
</a>
```

### Add/Edit Projects

Edit `src/utils/mockData.ts`:
```typescript
export const mockGalleryData: GalleryData[] = [
  {
    id: "unique-id",
    title: "Project Name",
    summary: "Brief description",
    image: "/images/project.webp",
    link: "https://project-url.com",
    videoUrl: "/videos/project.mp4", // Optional
  },
  // ... more projects
];
```

### Change Colors

Edit `src/index.css` (lines 4-20):
```css
:root {
  --color-primary: #2563eb;      /* Main brand color */
  --color-accent: #f59e0b;       /* Accent color */
  --color-dark: #0f172a;         /* Background dark */
  /* ... etc */
}
```

### Modify Hero Text

Edit `src/Components/Hero.tsx`:
- Line ~8: Main heading
- Line ~14: Tagline
- Line ~19-23: Description
- Lines ~27-49: Service cards

## 📱 Responsive Design

- **Mobile**: Single column, stacked layout
- **Tablet**: 2 columns for projects
- **Desktop**: 3 columns for projects
- All components adapt automatically

## 🎯 Component Features

### Card Component
- Hover effects with scale animation
- Two action buttons
- Compact design (max-w-md)
- Image with gradient overlay

### Video Dialog
- Autoplay with controls
- Keyboard navigation (ESC)
- Click outside to close
- Smooth animations
- Fallback for missing videos

### Navbar
- Fixed position
- Appears on scroll
- Backdrop blur effect
- Mobile-ready structure

## 🔐 Security Note

**About Embedding External Websites:**

Most modern websites (including yours) have security headers that prevent embedding in iframes:
- `X-Frame-Options: DENY`
- `Content-Security-Policy: frame-ancestors 'none'`

**Solution Implemented:**
- Video previews for project demos
- External links open in new tabs
- Best practice for security and UX

## 📈 Next Steps

### Immediate:
1. ✅ Add your actual contact information
2. ✅ Upload project videos to `public/videos/`
3. ✅ Update project descriptions
4. ✅ Replace favicon (`public/vite.svg`)

### Optional Enhancements:
- Connect contact form to email service (EmailJS, Formspree, etc.)
- Add Google Analytics
- Implement mobile menu (currently just button)
- Add loading states
- Add more sections (testimonials, team, services detail)
- Set up backend for form submissions

## 🐛 Troubleshooting

**Videos not playing:**
- Check file path is correct (`/videos/filename.mp4`)
- Ensure video is in `public/videos/` folder
- Check browser console for errors

**Images not showing:**
- Verify images are in `public/images/`
- Check file extensions match (.webp, .jpg, .png)

**Styling issues:**
- Clear browser cache
- Check Tailwind is working (`npm run dev`)
- Verify no CSS conflicts

## 📝 Code Quality

- ✅ All components under 250 lines
- ✅ DRY principles followed
- ✅ TypeScript types defined
- ✅ Responsive design
- ✅ Accessible (ARIA labels, keyboard navigation)
- ✅ No console errors
- ✅ Clean code structure

## 🎨 Color Palette Reference

- **Primary Blue**: #2563eb - CTAs, links, accents
- **Amber**: #f59e0b - Energy, highlights
- **Slate Dark**: #0f172a - Backgrounds
- **Slate Gray**: #475569 - Borders, dividers
- **White**: #ffffff - Primary text
- **Gray**: #94a3b8 - Secondary text

## 🤝 Support

For questions or modifications:
1. Check component comments
2. Review `IMPLEMENTATION_SUMMARY.md`
3. Check `VIDEO_INSTRUCTIONS.md` for video setup

---

**Built with React, TypeScript, Tailwind CSS, and Vite**

Enjoy your new professional event company website! 🎉
