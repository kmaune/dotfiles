# Claude Code Global Context

## Development Focus
Primary focus on **High-Frequency Trading (HFT)** and **ultra-low latency systems** development.

## Programming Languages & Standards
- **C++20/23**: Primary language with modern standards
- **Performance-critical code**: Every microsecond matters
- **Memory management**: Manual optimization preferred over automatic
- **SIMD operations**: AVX2/AVX-512 for computational hotpaths

## Code Quality Standards
- **Zero-cost abstractions**: Template metaprogramming over runtime polymorphism  
- **Cache-friendly design**: Data locality and memory access patterns critical
- **Branchless code**: Avoid conditionals in hot paths
- **Compile-time computation**: `constexpr` and template specialization preferred

## Build System & Tools
- **CMake**: Primary build system
- **Vim**: Preferred editor for development
- **GCC/Clang**: Both supported, aggressive optimization flags
- **Intel VTune/perf**: Profiling and performance analysis

## Testing & Quality Assurance
- **GoogleTest**: Unit testing framework
- **Benchmark libraries**: Performance regression testing
- **Static analysis**: clang-tidy, cppcheck
- **Sanitizers**: AddressSanitizer, ThreadSanitizer for debug builds

## Performance Optimization Priorities
1. **Latency reduction**: Target sub-microsecond execution times
2. **Memory bandwidth**: Minimize cache misses and memory stalls
3. **Branch prediction**: Optimize hot path branching patterns
4. **Lock-free algorithms**: Prefer atomic operations over mutexes
5. **NUMA awareness**: Consider memory locality in multi-socket systems

## Code Review Standards
- **Performance impact analysis**: Every change evaluated for latency implications
- **Assembly review**: Critical paths reviewed at assembly level
- **Memory layout**: Struct packing and alignment verification
- **Compiler output**: Verify optimization effectiveness

## Project Structure Conventions
- `src/`: Source files with performance-critical implementations
- `include/`: Headers with extensive template specializations  
- `benchmarks/`: Microbenchmarks for performance validation
- `tests/`: Unit tests with performance assertions
- `cmake/`: Build configuration and optimization flags

## Runtime Environment
- **Linux**: Target deployment environment
- **Real-time scheduling**: SCHED_FIFO for critical threads
- **CPU isolation**: Dedicated cores for trading logic
- **Memory locking**: mlockall() to prevent page swaps
- **DPDK**: User-space network stack for minimal latency

## Documentation Standards
- **Performance annotations**: Document complexity and expected performance
- **Hot path identification**: Mark critical execution paths
- **Optimization rationale**: Explain non-obvious performance choices
- **Benchmark results**: Include before/after performance data

## Dependencies & Libraries
- **Minimal external dependencies**: Reduce linking and loading overhead
- **Header-only libraries**: Prefer compile-time over runtime dependencies
- **Custom allocators**: Pool allocators for predictable memory patterns
- **Boost**: Limited usage, prefer standard library alternatives

## Debugging & Profiling
- **Debug vs Release**: Significant behavior differences expected
- **Profiling builds**: Special optimization flags for profiling accuracy
- **Hardware counters**: Leverage PMU events for detailed analysis
- **Flame graphs**: Primary visualization for performance bottlenecks

## Security Considerations
- **Time-constant operations**: Prevent timing-based information leakage
- **Input validation**: Critical for market data parsing
- **Memory safety**: Bounds checking in non-performance-critical code
- **Audit trails**: Comprehensive logging for compliance