# Claude Code Global Context

## Development Focus
General **modern C++ development** with emphasis on code quality, maintainability, and performance best practices.

## Programming Languages & Standards
- **C++17/20/23**: Modern C++ standards with feature adoption as appropriate
- **Performance awareness**: Write efficient code without premature optimization
- **Memory safety**: Prefer smart pointers and RAII over manual memory management
- **Standard library**: Leverage STL algorithms, containers, and utilities

## Code Quality Standards
- **Modern C++ idioms**: Use standard library features and modern patterns
- **Clear abstractions**: Prefer readable code over micro-optimizations
- **const correctness**: Immutable by default where possible
- **Exception safety**: Follow RAII principles for resource management

## Build System & Tools
- **CMake**: Primary build system for cross-platform compatibility
- **Vim/Neovim**: Preferred editor with LSP integration
- **GCC/Clang**: Modern compiler support with appropriate warning levels
- **Standard tooling**: gdb, valgrind, sanitizers for debugging and analysis

## Testing & Quality Assurance
- **GoogleTest/Catch2**: Unit testing frameworks
- **Test-driven development**: Write tests for new functionality
- **Static analysis**: clang-tidy, cppcheck for code quality
- **Sanitizers**: AddressSanitizer, UBSanitizer for safety checks

## Performance Philosophy
1. **Correctness first**: Get it working correctly, then optimize if needed
2. **Measure before optimizing**: Profile to identify actual bottlenecks
3. **Algorithmic efficiency**: Choose appropriate data structures and algorithms
4. **Memory awareness**: Understand allocation patterns and lifetimes
5. **Standard library**: Leverage optimized standard algorithms

## Code Review Standards
- **Readability**: Code should be self-documenting with clear intent
- **Safety**: Check for memory safety, exception safety, and edge cases
- **API design**: Evaluate interfaces for usability and maintainability
- **Testing**: Ensure adequate test coverage for new code
- **Performance**: Consider performance implications of design choices

## Project Structure Conventions
- `src/`: Source files organized by functional modules
- `include/`: Public headers with clear API boundaries
- `tests/`: Unit tests mirroring source structure
- `cmake/`: Build configuration and find modules
- `docs/`: Documentation and design documents

## Development Environment
- **Cross-platform**: Code should work on Linux, macOS, and Windows
- **Standard tooling**: Use widely available tools and libraries
- **Version control**: Git with clear commit messages and branching strategy
- **CI/CD**: Automated testing and builds where applicable

## Documentation Standards
- **API documentation**: Document public interfaces and usage examples
- **Design decisions**: Explain architectural choices and trade-offs
- **Build instructions**: Clear setup and build process documentation
- **Code comments**: Explain "why" not "what" in complex sections

## Dependencies & Libraries
- **Standard library first**: Prefer STL over external dependencies
- **Established libraries**: Use well-maintained, widely-adopted libraries
- **Dependency management**: Use modern tools like Conan or vcpkg where appropriate
- **Version pinning**: Specify library versions for reproducible builds

## Debugging & Profiling
- **Debug builds**: Full symbol information and minimal optimization
- **Logging**: Structured logging with appropriate levels
- **Profiling tools**: Use perf, Instruments, or Visual Studio profiler as needed
- **Memory debugging**: Regular use of sanitizers and static analysis

## Security Considerations
- **Input validation**: Validate all external inputs and data
- **Memory safety**: Use modern C++ features to prevent buffer overflows
- **Secure coding**: Follow established secure coding practices
- **Dependency security**: Keep dependencies updated and scan for vulnerabilities