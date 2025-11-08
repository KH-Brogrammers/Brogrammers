import React from "react";

export const ContactSection: React.FC = () => {
  return (
    <section id="contact" className="py-16 px-6 md:px-12 mt-12">
      <div className="max-w-4xl mx-auto">
        {/* Contact Header */}
        <div className="text-center mb-12">
          <h2 className="text-4xl md:text-5xl font-bold mb-4">
            <span className="bg-gradient-to-r from-blue-400 to-amber-400 bg-clip-text text-transparent">
              Let's Create Something Amazing
            </span>
          </h2>
          <p className="text-gray-400 max-w-2xl mx-auto">
            Ready to transform your event? Get in touch with us to discuss 
            your project requirements and see how we can bring your vision to life.
          </p>
        </div>

        {/* Contact Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 text-center hover:border-blue-500/50 transition-all duration-300">
            <div className="text-3xl mb-3">📧</div>
            <h3 className="text-lg font-semibold mb-2 text-blue-400">Email</h3>
            <a 
              href="mailto:contact@brogrammers.com" 
              className="text-sm text-gray-400 hover:text-gray-300 transition-colors"
            >
              contact@brogrammers.com
            </a>
          </div>

          <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 text-center hover:border-amber-500/50 transition-all duration-300">
            <div className="text-3xl mb-3">💬</div>
            <h3 className="text-lg font-semibold mb-2 text-amber-400">Chat</h3>
            <p className="text-sm text-gray-400">
              Available Mon-Fri, 9AM-6PM
            </p>
          </div>

          <div className="bg-slate-800/50 backdrop-blur-sm rounded-lg p-6 border border-slate-700/50 text-center hover:border-green-500/50 transition-all duration-300">
            <div className="text-3xl mb-3">📞</div>
            <h3 className="text-lg font-semibold mb-2 text-green-400">Call</h3>
            <a 
              href="tel:+1234567890" 
              className="text-sm text-gray-400 hover:text-gray-300 transition-colors"
            >
              +1 (234) 567-890
            </a>
          </div>
        </div>

        {/* Quick Contact Form */}
        <div className="bg-slate-800/30 backdrop-blur-sm rounded-xl p-8 border border-slate-700/50">
          <form className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label htmlFor="name" className="block text-sm font-medium text-gray-300 mb-2">
                  Name
                </label>
                <input
                  type="text"
                  id="name"
                  className="w-full px-4 py-3 bg-slate-900/50 border border-slate-600 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors"
                  placeholder="Your name"
                />
              </div>
              <div>
                <label htmlFor="email" className="block text-sm font-medium text-gray-300 mb-2">
                  Email
                </label>
                <input
                  type="email"
                  id="email"
                  className="w-full px-4 py-3 bg-slate-900/50 border border-slate-600 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors"
                  placeholder="your.email@example.com"
                />
              </div>
            </div>
            <div>
              <label htmlFor="message" className="block text-sm font-medium text-gray-300 mb-2">
                Project Details
              </label>
              <textarea
                id="message"
                rows={4}
                className="w-full px-4 py-3 bg-slate-900/50 border border-slate-600 rounded-lg text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 transition-colors resize-none"
                placeholder="Tell us about your event and requirements..."
              />
            </div>
            <button
              type="submit"
              className="w-full md:w-auto px-8 py-3 bg-blue-600 hover:bg-blue-700 rounded-lg font-medium transition-all duration-300 shadow-lg hover:shadow-blue-500/50"
            >
              Send Message
            </button>
          </form>
        </div>
      </div>
    </section>
  );
};
