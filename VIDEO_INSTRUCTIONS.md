# Adding Project Videos

To add video previews to your projects, follow these steps:

## 1. Add Your Video Files

Place your video files in the `public/videos/` directory:

```
public/
  videos/
    tagglabs.mp4
    emotion-design.mp4
    sc-exhibit-1.mp4
    ...
```

## 2. Update Mock Data

In `src/utils/mockData.ts`, uncomment the `videoUrl` property for each project:

```typescript
{
  id: "1",
  title: "Tagglabs",
  summary: "AI-powered platform...",
  image: "/images/card_1.webp",
  link: "https://tagglabs.ai/",
  videoUrl: "/videos/tagglabs.mp4", // Uncomment this line
}
```

## 3. Supported Video Formats

- MP4 (recommended)
- WebM
- OGG

## 4. Video Best Practices

- **Resolution**: 1920x1080 (Full HD) or 1280x720 (HD)
- **Duration**: 30-60 seconds for preview
- **Size**: Keep under 10MB for fast loading
- **Codec**: H.264 for MP4

## 5. Testing

After adding videos:
1. Run `npm run dev`
2. Click the "Preview" button on any card
3. The video should play in the dialog

If no video is provided, users will see a placeholder with a link to the live project.
