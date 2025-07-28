---
name: new-cpp-project
description: Scaffold a new C++ project with modern standards, build system, and testing framework
---

Create a new C++ project with the following structure and requirements:

## Project Structure
{project_name}/
├── CMakeLists.txt              # Modern CMake (3.20+)
├── README.md                   # Project documentation
├── .gitignore                  # C++ specific gitignore
├── include/{project_name}/     # Public headers
├── src/                        # Source files
├── tests/                      # Unit tests
├── benchmarks/                 # Performance benchmarks
├── docs/                       # Documentation
└── .claude/                    # Claude Code configuration
├── agents/                 # Project-specific agents (empty initially)
├── commands/               # Project commands (empty initially)
└── CLAUDE.md               # Project context

## Build System Requirements
- **CMake 3.20+** with modern target-based configuration
- **C++17 minimum** (C++20 preferred for new projects)
- **Conan 2.0** or **vcpkg** for dependency management
- **CTest integration** for automated testing
- **Google Benchmark** integration for performance testing
- **Compiler flags**: Enable all warnings, treat warnings as errors
- **Sanitizers**: AddressSanitizer and UBSan in debug builds
- **Static analysis**: Integration with clang-tidy

## Testing Framework
- **Google Test** for unit testing
- **Google Mock** for mocking
- **Test coverage** reporting with gcov/llvm-cov
- **Continuous integration** ready (GitHub Actions template)

## Code Standards
- **Modern C++** idioms (RAII, smart pointers, move semantics)
- **Const correctness** and type safety
- **Header-only libraries** where appropriate
- **Documentation** with Doxygen comments
- **Formatting** with clang-format configuration

## Initial Files to Generate
1. **CMakeLists.txt** - Complete build configuration
2. **README.md** - Project description and build instructions
3. **main.cpp** - Simple hello world application
4. **example_test.cpp** - Sample unit test
5. **example_benchmark.cpp** - Sample benchmark
6. **.gitignore** - Comprehensive C++ gitignore
7. **.clang-format** - Consistent formatting rules
8. **CLAUDE.md** - Project context for Claude Code

## Project Context Template
Create a CLAUDE.md file with:
- Project purpose and architecture overview
- Build commands and development workflow
- Performance requirements (if applicable)
- Code style and contribution guidelines
- Testing and benchmarking standards

Ask for:
- **Project name**
- **Brief description**
- **Performance requirements** (general/high-performance/real-time)
- **Dependencies** (if any specific libraries needed)
- **Target platforms** (Linux/macOS/Windows)

Then generate all files with appropriate content for the specified requirements.
