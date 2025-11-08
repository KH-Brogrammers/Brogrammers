import React from "react";
import { Hero } from "../Components/Hero";
import { ProjectsSection } from "../Components/ProjectsSection";
import { ContactSection } from "../Components/ContactSection";

export const Landing: React.FC = () => {
  return (
    <div className="w-full">
      {/* Hero Section */}
      <Hero />

      {/* Divider */}
      <div className="max-w-7xl mx-auto px-6">
        <div className="h-px bg-gradient-to-r from-transparent via-slate-700 to-transparent" />
      </div>

      {/* Projects Section */}
      <ProjectsSection />

      {/* Divider */}
      <div className="max-w-7xl mx-auto px-6">
        <div className="h-px bg-gradient-to-r from-transparent via-slate-700 to-transparent" />
      </div>

      {/* Contact Section */}
      <ContactSection />
    </div>
  );
};
