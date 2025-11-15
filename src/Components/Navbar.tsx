import React, { useState, useEffect } from "react";

export const Navbar: React.FC = () => {
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <nav
      className={`fixed top-0 left-0 right-0 z-40 transition-all duration-300 ${
        isScrolled
          ? "bg-slate-950/90 backdrop-blur-lg border-b border-slate-800/50 shadow-lg"
          : "bg-transparent"
      }`}
    >
      <div className="max-w-7xl mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          {/* Logo */}
          <a href="#" className="flex items-center gap-3">
            <img 
              src="/logo.png" 
              alt="Brogrammers Logo" 
              className="w-8 h-8 object-contain bg-transparent"
            />
            <span className="text-2xl font-bold bg-gradient-to-r from-blue-400 to-amber-400 bg-clip-text text-transparent">
              Brogrammers
            </span>
          </a>

          {/* Navigation Links */}
          <div className="hidden md:flex items-center gap-8">
            <a
              href="#"
              className="text-sm text-gray-300 hover:text-white transition-colors"
            >
              Home
            </a>
            <a
              href="#projects"
              className="text-sm text-gray-300 hover:text-white transition-colors"
            >
              Projects
            </a>
            <a
              href="#contact"
              className="text-sm text-gray-300 hover:text-white transition-colors"
            >
              Contact
            </a>
            <a
              href="#contact"
              className="px-6 py-2 bg-blue-600 hover:bg-blue-700 rounded-lg text-sm font-medium transition-all duration-300"
            >
              Get Started
            </a>
          </div>

          {/* Mobile Menu Button */}
          <button className="md:hidden text-gray-300 hover:text-white">
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
          </button>
        </div>
      </div>
    </nav>
  );
};
