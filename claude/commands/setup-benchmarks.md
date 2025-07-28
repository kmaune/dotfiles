---
name: setup-benchmarks
description: Add comprehensive benchmarking framework to any existing project
---

Add a complete benchmarking framework to the current project:

## Framework Selection by Language

**C++:**
- **Google Benchmark** - Industry standard for C++ microbenchmarks
- **Catch2** - If already using Catch2 for testing
- **Custom timing** - For ultra-low latency requirements

**Python:**
- **pytest-benchmark** - Integrated with pytest testing
- **timeit** - For simple function benchmarks
- **memory_profiler** - For memory usage benchmarks

**JavaScript/TypeScript:**
- **Benchmark.js** - Standard for JavaScript benchmarking
- **Jest** - If using Jest for testing

## Setup Requirements

1. **Benchmark Directory Structure**
benchmarks/
├── CMakeLists.txt          # Build configuration (C++)
├── conftest.py             # Pytest configuration (Python)
├── basic_benchmarks.*      # Example benchmarks
├── regression_tests.*      # Performance regression detection
└── results/                # Benchmark output storage

2. **Build Integration**
- Add benchmark targets to build system
- Configure with optimization flags
- Integrate with CI/CD pipeline
- Set up automated regression detection

3. **Benchmark Categories**
- **Microbenchmarks** - Individual function performance
- **Component benchmarks** - Module-level performance
- **Integration benchmarks** - End-to-end scenarios
- **Stress tests** - Performance under load

## Standard Benchmarks to Create

1. **Core Functions** - Most frequently called functions
2. **Data Structures** - Container operations and access patterns
3. **Algorithms** - Computational bottlenecks
4. **I/O Operations** - File and network operations
5. **Memory Operations** - Allocation patterns and data copying

## Configuration and Best Practices

1. **Environment Control**
- CPU frequency scaling configuration
- Background process minimization
- Consistent system state for reproducible results

2. **Statistical Rigor**
- Multiple iterations with statistical analysis
- Warmup periods for JIT compilation
- Outlier detection and handling

3. **Result Storage and Analysis**
- Structured result output (JSON, CSV)
- Historical tracking for regression detection
- Visualization and reporting tools

4. **Continuous Integration**
- Automated benchmark execution
- Performance regression alerts
- Historical performance tracking

## Deliverables

Generate the following files:
1. **Benchmark framework setup** - Build configuration and dependencies
2. **Example benchmarks** - Template benchmarks for common patterns
3. **Regression detection** - Scripts to detect performance degradation
4. **Documentation** - How to write, run, and interpret benchmarks
5. **CI integration** - Automated benchmark execution configuration

Ask for:
- **Performance-critical areas** - What to benchmark first
- **Performance targets** - Expected performance ranges
- **Regression tolerance** - Acceptable performance variation
- **Execution frequency** - How often to run benchmarks (CI, nightly, etc.)

Then create a comprehensive benchmarking setup tailored to the project's needs.
