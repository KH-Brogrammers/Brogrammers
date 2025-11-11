import React from "react";
import type { GalleryData } from "../utils/mockData";

interface CardProps {
  cardData: GalleryData;
  onPreview: () => void;
}

export const Card: React.FC<CardProps> = ({ cardData, onPreview }) => {
  const handleExternalLink = (e: React.MouseEvent) => {
    e.stopPropagation();
    window.open(cardData?.link, "_blank", "noopener,noreferrer");
  };

  return (
    <div className="group relative w-full max-w-md bg-slate-800/50 rounded-xl overflow-hidden border border-slate-700/50 hover:border-blue-500/50 transition-all duration-300 hover:shadow-xl hover:shadow-blue-500/10">
      {/* Image Container */}
      <div className="relative h-64 overflow-hidden bg-slate-900">
        <img
          src={cardData?.image}
          alt={cardData?.title}
          className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/60 to-transparent opacity-80" />

        {/* Overlay on hover */}
        <div className="absolute inset-0 bg-blue-600/0 group-hover:bg-blue-600/10 transition-all duration-300" />
      </div>

      {/* Content */}
      <div className="p-6 space-y-4">
        <div>
          <h3 className="text-xl font-bold text-white mb-2 group-hover:text-blue-400 transition-colors">
            {cardData?.title}
          </h3>
          <p className="text-sm text-gray-400 line-clamp-2">
            {cardData?.summary}
          </p>
        </div>

        {/* Action Buttons */}
        <div className="flex gap-3">
          <button
            onClick={onPreview}
            className="flex-1 px-4 py-2.5 bg-blue-600 hover:bg-blue-700 rounded-lg font-medium text-sm transition-all duration-300 flex items-center justify-center gap-2 group/btn"
          >
            <svg
              className="w-4 h-4 group-hover/btn:scale-110 transition-transform"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"
              />
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
            Preview
          </button>

          <button
            onClick={handleExternalLink}
            className="px-4 py-2.5 bg-slate-700 hover:bg-slate-600 rounded-lg font-medium text-sm transition-all duration-300 flex items-center justify-center gap-2"
            title="Visit live project"
          >
            <svg
              className="w-4 h-4"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
};
