import React from "react";

export const Hero: React.FC = () => {
  return (
    <section className="min-h-[80vh] flex items-center justify-center px-6 py-16 md:px-12 pt-24 md:pt-32">
      <div className="max-w-6xl mx-auto text-center">
        {/* Main Heading */}
        <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
          <span className="bg-gradient-to-r from-blue-400 via-blue-500 to-amber-400 bg-clip-text text-transparent">
            Brogrammers
          </span>
        </h1>

        {/* Tagline */}
        <p className="text-xl md:text-2xl text-gray-300 mb-4 font-light">
          Transforming Events Into Experiences
        </p>

        {/* Description */}
        <div className="max-w-3xl mx-auto mb-12">
          <p className="text-base md:text-lg text-gray-400 leading-relaxed mb-4">
            We deliver complete event solutions – from cutting-edge hardware
            setups to custom software development. Whether you need projection
            systems, interactive displays, or bespoke event applications, we've
            got you covered.
          </p>

          {/* Key Services */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-10">
            <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 hover:border-blue-500/50 transition-all duration-300">
              <div className="text-3xl mb-3">🎯</div>
              <h3 className="text-lg font-semibold mb-2 text-blue-400">
                Hardware Setup
              </h3>
              <p className="text-sm text-gray-400">
                Professional projectors, displays, and event infrastructure
              </p>
            </div>

            <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 hover:border-amber-500/50 transition-all duration-300">
              <div className="text-3xl mb-3">💻</div>
              <h3 className="text-lg font-semibold mb-2 text-amber-400">
                Custom Software
              </h3>
              <p className="text-sm text-gray-400">
                Tailored applications for interactive and engaging events
              </p>
            </div>

            <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 hover:border-green-500/50 transition-all duration-300">
              <div className="text-3xl mb-3">🚀</div>
              <h3 className="text-lg font-semibold mb-2 text-green-400">
                Full Solutions
              </h3>
              <p className="text-sm text-gray-400">
                End-to-end event management and technical support
              </p>
            </div>
          </div>
        </div>

        {/* CTA */}
        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <a
            href="#projects"
            className="px-8 py-4 bg-blue-600 hover:bg-blue-700 rounded-lg font-medium transition-all duration-300 shadow-lg hover:shadow-blue-500/50"
          >
            View Our Work
          </a>
          <a
            href="#contact"
            className="px-8 py-4 bg-transparent border-2 border-gray-600 hover:border-amber-500 rounded-lg font-medium transition-all duration-300"
          >
            Get In Touch
          </a>
        </div>
      </div>
    </section>
  );
};
