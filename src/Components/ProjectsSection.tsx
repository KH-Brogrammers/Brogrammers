import React, { useState } from "react";
import { mockGalleryData, type GalleryData } from "../utils/mockData";
import { Card } from "./Card";
import { VideoDialog } from "./VideoDialog";

export const ProjectsSection: React.FC = () => {
  const [selectedProject, setSelectedProject] = useState<GalleryData | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  const handlePreview = (project: GalleryData) => {
    setSelectedProject(project);
    setIsDialogOpen(true);
  };

  const handleCloseDialog = () => {
    setIsDialogOpen(false);
    setTimeout(() => setSelectedProject(null), 300);
  };

  return (
    <section id="projects" className="py-16 px-6 md:px-12">
      <div className="max-w-7xl mx-auto">
        {/* Section Header */}
        <div className="text-center mb-12">
          <h2 className="text-4xl md:text-5xl font-bold mb-4">
            <span className="bg-gradient-to-r from-blue-400 to-amber-400 bg-clip-text text-transparent">
              Our Projects
            </span>
          </h2>
          <p className="text-gray-400 max-w-2xl mx-auto">
            Explore our portfolio of successful event implementations – from 
            interactive exhibitions to cutting-edge digital experiences.
          </p>
        </div>

        {/* Projects Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 justify-items-center">
          {mockGalleryData.map((project) => (
            <Card
              key={project.id}
              cardData={project}
              onPreview={() => handlePreview(project)}
            />
          ))}
        </div>

        {/* Video Dialog */}
        {selectedProject && (
          <VideoDialog
            isOpen={isDialogOpen}
            onClose={handleCloseDialog}
            videoUrl={selectedProject.videoUrl}
            projectTitle={selectedProject.title}
            projectUrl={selectedProject.link}
          />
        )}
      </div>
    </section>
  );
};
