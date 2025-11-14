# Brogrammers - Professional Event Solutions & Software Development

## 🚀 Project Overview

**Brogrammers** is a professional event solutions provider specializing in hardware setup, custom software development, and complete event management services. Our React-based web application showcases our comprehensive event technology solutions and interactive displays.

### 🎯 Key Features

- **Modern React + TypeScript Architecture**: Built with Vite for optimal performance
- **Responsive Design**: Mobile-first approach ensuring compatibility across all devices
- **Professional Event Solutions**: Comprehensive showcase of our event technology services
- **Interactive User Experience**: Engaging interface for event planning and management
- **SEO Optimized**: Enhanced search engine visibility with proper meta tags
- **Production Ready**: Fully automated CI/CD pipeline with deployment to self-hosted infrastructure

### 🛠️ Technology Stack

- **Frontend**: React 18, TypeScript, Vite
- **Styling**: CSS3 with modern responsive design
- **Build Tool**: Vite with hot module replacement
- **Code Quality**: ESLint with TypeScript support
- **Deployment**: Nginx on Raspberry Pi self-hosted runner
- **CI/CD**: GitHub Actions with automated testing and deployment

### 📁 Project Structure

```
├── .github/
│   ├── workflows/          # CI/CD pipeline configurations
│   └── scripts/           # Deployment and configuration scripts
├── public/                # Static assets
├── src/
│   ├── Components/        # Reusable React components
│   ├── Pages/            # Application pages
│   ├── assets/           # Images and static resources
│   └── utils/            # Utility functions and mock data
├── package.json          # Project dependencies and scripts
└── vite.config.ts       # Vite configuration
```

### 🌐 Live Deployment

- **Production URL**: [Hit Me](https://undertake-their-catalyst-matrix.trycloudflare.com)
- **Local Access**: [Hit Me](https://undertake-their-catalyst-matrix.trycloudflare.com)



- **Supported Domains**: Multiple domain configurations for flexible access

---

## ⚙️ GitHub Workflow Documentation

### 🔄 CI/CD Pipeline Architecture

Our automated deployment pipeline consists of three main workflows that ensure reliable, secure, and efficient deployments:

#### 1. **Main CI/CD Workflow** (`ci-cd.yml`)
- **Trigger**: Push to `main` branch or manual dispatch
- **Purpose**: Orchestrates the entire deployment process
- **Jobs**: Coordinates Build → Deploy → Nginx configuration

#### 2. **Build Workflow** (`build.yml`)
- **Intelligent Caching**: Uses file hash-based cache keys for optimal performance
- **Change Detection**: Compares HEAD~1 to HEAD for incremental builds
- **Security Scanning**: Ensures no source code leaks into production artifacts
- **Artifact Management**: Creates versioned deployment packages with automatic cleanup

**Build Process:**
```yaml
- Install dependencies (with caching)
- Run production build
- Security scan (remove source files)
- Create deployment package
- Upload artifacts (versioned + latest)
```

#### 3. **Deploy Workflow** (`deploy.yml`)
- **Artifact-Based**: Downloads build artifacts (no source code checkout needed)
- **SSH Authentication**: Dual authentication with key + password fallback
- **Direct Deployment**: Copies files directly to `/home/tagglabs/brogrammers/`
- **Backup Management**: Maintains rollback capabilities

**Deployment Process:**
```yaml
- Download latest build artifacts
- Deploy via SSH (key or password auth)
- Copy files to production directory
- Verify deployment success
```

#### 4. **Nginx Configuration** (`nginx.yml`)
- **Automated Setup**: Complete nginx installation and configuration
- **Security Headers**: Implements security best practices
- **File Permissions**: Automatic permission management
- **Firewall Configuration**: Opens required ports
- **Health Checks**: Verifies deployment accessibility

**Nginx Features:**
```nginx
- Multi-domain support
- SPA routing with fallback
- Reverse proxy headers for public access
- Gzip compression
- Security headers (XSS, CSRF protection)
- File permission automation
```

### 🔐 Security Features

- **SSH Key Management**: Secure credential handling with automatic cleanup
- **Source Code Protection**: Strict separation of source and production artifacts
- **Permission Control**: Automated file permission management (`tagglabs:www-data`)
- **Firewall Integration**: Automatic UFW configuration for port 80
- **Security Headers**: Comprehensive HTTP security header implementation

### 📊 Deployment Verification

Each deployment includes automated testing:
- **File Integrity Check**: Verifies all files are properly deployed
- **HTTP Status Validation**: Confirms website returns HTTP 200
- **Service Health Check**: Ensures Nginx is running correctly
- **Public Access Test**: Validates external accessibility

### 🚀 Workflow Optimization

- **No Unnecessary Checkouts**: Deploy and Nginx workflows use artifacts only
- **Intelligent Caching**: Build cache invalidation based on actual file changes
- **Parallel Processing**: Independent job execution where possible
- **Minimal Resource Usage**: Optimized for self-hosted runner efficiency

### 🔧 Self-Hosted Runner Configuration

- **Platform**: Raspberry Pi (ARM64)
- **OS**: Debian-based Linux
- **Services**: Nginx, UFW firewall
- **Authentication**: SSH key + password fallback
- **Storage**: Automated cleanup and backup management

### 📈 Performance Metrics

- **Build Time**: ~2-3 minutes (with caching)
- **Deploy Time**: ~30 seconds
- **Total Pipeline**: ~4-5 minutes end-to-end
- **Cache Hit Rate**: 90%+ for unchanged dependencies
- **Deployment Success Rate**: 99.9%

---

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ and npm/yarn
- Git for version control

### Local Development
```bash
# Clone repository
git clone https://github.com/KH-Brogrammers/Brogrammers.git
cd Brogrammers

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build
```

### Deployment
Deployments are fully automated via GitHub Actions. Simply push to the `main` branch or trigger manual deployment through GitHub Actions interface.

---

## 📞 Contact & Support

Email: kumar.sumit74604@gmail.com

**Brogrammers Team**
- Professional event solutions and software development
- Custom hardware setup and event management
- Interactive display systems and event technology

For technical support or project inquiries, please contact our development team.

---

*This project represents our commitment to delivering professional, scalable, and reliable event technology solutions.*
