export interface GalleryData {
  id: string;
  title: string;
  summary: string;
  image: string;
  link: string;
  videoUrl?: string; // Optional video URL for preview
}

export const mockGalleryData: GalleryData[] = [
  {
    id: "1",
    title: "Tagglabs",
    summary: "AI-powered platform for intelligent tagging and content organization solutions.",
    image: "/images/card_1.webp",
    link: "https://tagglabs.ai/",
    // videoUrl: "/videos/tagglabs.mp4", // Add your video path here
  },
  {
    id: "2",
    title: "Emotion Design",
    summary: "Creative digital experiences that connect emotionally with audiences.",
    image: "/images/card_2.webp",
    link: "https://emotion.design/",
    // videoUrl: "/videos/emotion-design.mp4",
  },
  {
    id: "6",
    title: "Supreme Court Exhibit 4",
    summary: "Interactive exhibition solution for legal documentation and presentation.",
    image: "/images/card_6.webp",
    link: "https://sc24exhibit23.f1.tagg.live/",
    // videoUrl: "/videos/sc-exhibit-4.mp4",
  },
  {
    id: "8",
    title: "AI Photo Booth",
    summary: "Advanced AI-powered photo booth experience with real-time processing.",
    image: "/images/card_8.webp",
    link: "https://mpidc25-videobooth.f1.tagg.live/",
    // videoUrl: "/videos/ai-photo-booth.mp4",
  },
  {
    id: "3",
    title: "Supreme Court Exhibit 1",
    summary: "Digital archive system for historical legal documents and artifacts.",
    image: "/images/card_3.webp",
    link: "https://sc24exhibit11.f1.tagg.live/",
    // videoUrl: "/videos/sc-exhibit-1.mp4",
  },
  {
    id: "4",
    title: "Supreme Court Exhibit 2",
    summary: "Interactive museum display with multimedia content integration.",
    image: "/images/card_4.webp",
    link: "https://sc24exhibit12.f1.tagg.live/",
    // videoUrl: "/videos/sc-exhibit-2.mp4",
  },
  {
    id: "5",
    title: "Supreme Court Exhibit 3",
    summary: "Touchscreen kiosk solution for visitor information and navigation.",
    image: "/images/card_5.webp",
    link: "https://sc24exhibit27.f1.tagg.live/",
    // videoUrl: "/videos/sc-exhibit-3.mp4",
  },
  {
    id: "7",
    title: "Supreme Court Exhibit 5",
    summary: "Immersive storytelling platform for constitutional history.",
    image: "/images/card_7.webp",
    link: "https://sc24exhibit37.f1.tagg.live/",
    // videoUrl: "/videos/sc-exhibit-5.mp4",
  },
];
