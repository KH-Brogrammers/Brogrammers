import { Route, Routes } from "react-router";
import "./App.css";
import { Landing } from "./Pages/Landing";
import { Navbar } from "./Components/Navbar";

function App() {
  return (
    <div className="min-h-screen w-full overflow-x-hidden bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950">
      {/* Navigation */}
      <Navbar />

      {/* Main Content */}
      <main className="w-full">
        <Routes>
          <Route path="/" element={<Landing />} />
        </Routes>
      </main>

      {/* Footer */}
      <footer className="w-full border-t border-slate-800 mt-16">
        <div className="max-w-7xl mx-auto px-6 py-8">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <div className="text-center md:text-left">
              <h3 className="text-xl font-bold text-white mb-2">Brogrammers</h3>
              <p className="text-sm text-gray-400">
                Professional Event Solutions & Software Development
              </p>
            </div>

            <div className="flex gap-6">
              <a
                href="#projects"
                className="text-sm text-gray-400 hover:text-blue-400 transition-colors"
              >
                Projects
              </a>
              <a
                href="#contact"
                className="text-sm text-gray-400 hover:text-blue-400 transition-colors"
              >
                Contact
              </a>
            </div>
          </div>

          <div className="mt-6 pt-6 border-t border-slate-800 text-center">
            <p className="text-xs text-gray-500">
              © {new Date().getFullYear()} Brogrammers. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default App;
