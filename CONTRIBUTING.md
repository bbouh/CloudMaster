# Contributing to CloudMaster

Thank you for your interest in contributing to CloudMaster! This document provides guidelines and information for contributors.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [conduct@cloudmaster.com](mailto:conduct@cloudmaster.com).

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/cloudmaster-platform.git
   cd cloudmaster-platform
   ```
3. **Add the upstream repository**:
   ```bash
   git remote add upstream https://github.com/cloudmaster/cloudmaster-platform.git
   ```
4. **Create a new branch** for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

### Prerequisites

- Node.js 18 or higher
- npm 8 or higher
- Docker and Docker Compose
- PostgreSQL 15 or higher
- Redis 7 or higher

### Setup Steps

1. **Install dependencies**:
   ```bash
   npm run setup
   ```

2. **Set up environment variables**:
   ```bash
   cp backend/.env.example backend/.env
   cp frontend/.env.example frontend/.env
   ```

3. **Start the development environment**:
   ```bash
   docker-compose up -d
   npm run dev
   ```

## Contributing Guidelines

### Types of Contributions

We welcome several types of contributions:

- **Bug fixes**: Fix issues in the codebase
- **New features**: Add new functionality
- **Documentation**: Improve or add documentation
- **Tests**: Add or improve test coverage
- **Performance improvements**: Optimize code performance
- **Security enhancements**: Improve security measures

### Before You Start

1. **Check existing issues** to see if your contribution is already being worked on
2. **Create an issue** for significant changes to discuss the approach
3. **Ensure your changes align** with the project's goals and architecture

## Pull Request Process

### 1. Prepare Your Changes

- **Write clear, descriptive commit messages**
- **Keep changes focused** - one feature or bug fix per PR
- **Update documentation** as needed
- **Add tests** for new functionality
- **Ensure all tests pass**

### 2. Create a Pull Request

1. **Push your branch** to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a pull request** on GitHub with:
   - Clear title and description
   - Reference to related issues
   - Screenshots for UI changes
   - Testing instructions

### 3. Pull Request Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] New tests added for new functionality
- [ ] Manual testing completed

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)

## Related Issues
Closes #(issue number)
```

## Issue Reporting

### Bug Reports

When reporting bugs, please include:

- **Clear description** of the issue
- **Steps to reproduce** the problem
- **Expected behavior** vs actual behavior
- **Environment details** (OS, browser, Node.js version)
- **Screenshots** if applicable
- **Error messages** and logs

### Feature Requests

For feature requests, please include:

- **Clear description** of the feature
- **Use case** and motivation
- **Proposed implementation** (if you have ideas)
- **Alternative solutions** considered

## Coding Standards

### General Guidelines

- **Use TypeScript** for all new code
- **Follow existing code style** and patterns
- **Write self-documenting code** with clear variable names
- **Add comments** for complex logic
- **Keep functions small** and focused

### Frontend Standards

- **Use functional components** with hooks
- **Follow React best practices**
- **Use TailwindCSS** for styling
- **Implement responsive design**
- **Ensure accessibility** (WCAG AA compliance)

### Backend Standards

- **Use Express.js** patterns
- **Implement proper error handling**
- **Use Prisma** for database operations
- **Follow RESTful API** conventions
- **Implement proper validation**

### Code Style

- **Use ESLint** and **Prettier** for formatting
- **Follow conventional commits** for commit messages
- **Use meaningful variable names**
- **Avoid deep nesting** (max 3 levels)
- **Use early returns** to reduce complexity

## Testing

### Test Requirements

- **Unit tests** for all new functions
- **Integration tests** for API endpoints
- **Component tests** for React components
- **E2E tests** for critical user flows

### Running Tests

```bash
# Run all tests
npm test

# Run frontend tests
npm run test:frontend

# Run backend tests
npm run test:backend

# Run tests with coverage
npm run test:coverage
```

### Test Coverage

- **Maintain >80% test coverage**
- **Test edge cases** and error conditions
- **Mock external dependencies**
- **Use descriptive test names**

## Documentation

### Code Documentation

- **Document all public APIs**
- **Use JSDoc** for functions and classes
- **Include examples** in documentation
- **Keep documentation up to date**

### README Updates

- **Update README** for new features
- **Include setup instructions**
- **Document configuration options**
- **Provide usage examples**

## Review Process

### What We Look For

- **Code quality** and maintainability
- **Test coverage** and quality
- **Documentation** completeness
- **Performance** implications
- **Security** considerations
- **Accessibility** compliance

### Review Timeline

- **Initial review**: Within 2-3 business days
- **Follow-up reviews**: Within 1-2 business days
- **Final approval**: After all feedback addressed

## Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Notes

- **Document all changes** in release notes
- **Highlight breaking changes**
- **Include migration guides** for major versions
- **Credit contributors**

## Community

### Getting Help

- **GitHub Discussions** for questions and ideas
- **Discord** for real-time chat
- **Email** for private matters

### Recognition

- **Contributors** are listed in README
- **Significant contributions** are highlighted in release notes
- **Long-term contributors** may be invited to join the core team

## License

By contributing to CloudMaster, you agree that your contributions will be licensed under the MIT License.

## Contact

- **Email**: [contributors@cloudmaster.com](mailto:contributors@cloudmaster.com)
- **Discord**: [Join our server](https://discord.gg/cloudmaster)
- **Twitter**: [@CloudMasterEdu](https://twitter.com/CloudMasterEdu)

Thank you for contributing to CloudMaster! 🚀
