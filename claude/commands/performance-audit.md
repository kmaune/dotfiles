---
name: performance-audit
description: Comprehensive performance analysis workflow for any codebase
---

Perform a systematic performance audit of the current codebase:

## Phase 1: Baseline Measurement
1. **Identify critical paths** - Find the most performance-sensitive code
2. **Create benchmarks** - If they don't exist, generate comprehensive benchmarks
3. **Establish baselines** - Record current performance metrics
4. **Profile the application** - Use appropriate profiling tools for the language/platform

## Phase 2: Analysis
1. **CPU profiling** - Identify computational bottlenecks
2. **Memory analysis** - Check for allocation patterns and memory leaks
3. **I/O analysis** - Examine file and network operations
4. **Algorithm complexity** - Review algorithmic efficiency
5. **Concurrency analysis** - Identify synchronization bottlenecks

## Phase 3: Optimization Recommendations
1. **Priority ranking** - Order optimizations by expected impact
2. **Implementation effort** - Estimate complexity of each optimization
3. **Risk assessment** - Identify potential side effects
4. **Measurement plan** - How to validate each optimization

## Tools and Techniques by Language

**C++:**
- CPU: perf, VTune, Instruments (macOS)
- Memory: Valgrind, AddressSanitizer, Heaptrack
- Benchmarking: Google Benchmark, Catch2 benchmarks

**Python:**
- CPU: cProfile, py-spy, Austin
- Memory: memory_profiler, pympler, tracemalloc
- Benchmarking: pytest-benchmark, timeit

**General:**
- System monitoring: htop, iostat, netstat
- Application tracing: strace, dtrace
- Database profiling: EXPLAIN ANALYZE, query analyzers

## Report Format
Generate a performance audit report including:

1. **Executive Summary**
   - Overall performance assessment
   - Top 3 optimization opportunities
   - Expected improvement potential

2. **Detailed Findings**
   - Bottleneck analysis with evidence
   - Resource utilization patterns
   - Performance regression risks

3. **Optimization Roadmap**
   - Prioritized list of improvements
   - Implementation timeline estimates
   - Success metrics for each optimization

4. **Benchmarking Strategy**
   - Current benchmark coverage gaps
   - Recommended additional benchmarks
   - Continuous performance monitoring setup

Ask for:
- **Primary use case** - What performance matters most
- **Current pain points** - Known performance issues
- **Performance targets** - Specific goals or SLAs
- **Constraints** - Limitations on changes (API compatibility, etc.)

Then coordinate with appropriate specialist agents (`cpp-performance-expert`, language-specific experts) for detailed analysis.
