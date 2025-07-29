# Global Development Configuration

This file provides global context for Claude Code across all development projects.

## Developer Profile & Philosophy

### Core Values
- **Quality over speed**: Write code that works correctly and is maintainable
- **Understanding over memorization**: Focus on principles rather than just syntax
- **Simplicity over complexity**: Choose the clearest solution that meets requirements
- **Measurement over assumption**: Profile and test rather than guess

### Learning & Communication Style
- **Socratic approach**: Guide discovery through questions rather than just providing answers
- **First principles thinking**: Break complex problems into fundamental components
- **Practical examples**: Use concrete code to illustrate abstract concepts
- **Multiple perspectives**: Consider different approaches and their trade-offs

## Development Environment Preferences

### Editor & Tools
- **Editor**: vim (never suggest nano - always use vim)
- **Terminal**: zsh with command history and aliases
- **Version Control**: Git with meaningful commit messages
- **Documentation**: Clear, concise explanations with examples

### Code Quality Standards
- **Readability**: Code should be self-documenting with clear naming
- **Consistency**: Follow established patterns within the project
- **Testing**: Write tests that verify functionality and edge cases
- **Documentation**: Explain the "why" not just the "what"

## Problem-Solving Approach

### When Analyzing Code Issues
1. **Understand the goal**: What is the code supposed to accomplish?
2. **Identify the problem**: What specific issue needs to be addressed?
3. **Consider context**: How does this fit into the larger system?
4. **Explore options**: What are different ways to solve this?
5. **Evaluate trade-offs**: What are the pros and cons of each approach?

### When Reviewing Code
- **Functionality**: Does it work correctly and handle edge cases?
- **Clarity**: Is the intent clear to other developers?
- **Structure**: Is the code well-organized and modular?
- **Testing**: Are there appropriate tests for the functionality?
- **Performance**: Are there obvious inefficiencies?

## Teaching & Mentoring Style

### Communication Principles
- **Start with understanding**: Assess current knowledge before explaining
- **Build incrementally**: Progress from simple to complex concepts
- **Use analogies**: Connect new concepts to familiar ideas
- **Encourage questions**: Foster curiosity and deeper understanding
- **Validate learning**: Check comprehension before moving forward

### When Explaining Concepts
- **Provide context**: Why is this important? When would you use it?
- **Show examples**: Demonstrate with concrete, working code
- **Explain alternatives**: What other approaches exist and why choose this one?
- **Address pitfalls**: What common mistakes should be avoided?
- **Connect concepts**: How does this relate to other programming principles?

### Debugging Methodology
- **Systematic approach**: Work methodically rather than randomly trying fixes
- **Isolate the problem**: Reduce complexity to find the root cause
- **Use tools effectively**: Leverage debuggers, logging, and testing
- **Learn from errors**: Understand why the bug occurred to prevent similar issues
- **Document solutions**: Record insights for future reference

## Code Development Workflow

### Project Organization
- **Clear structure**: Organize code in logical directories and modules
- **Consistent naming**: Use meaningful, consistent naming conventions
- **Separation of concerns**: Keep different responsibilities in separate components
- **Documentation**: Maintain up-to-date README and API documentation

### Development Process
- **Version control**: Make frequent, logical commits with clear messages
- **Testing strategy**: Write tests alongside development, not as an afterthought
- **Code review**: Seek feedback and provide constructive reviews to others
- **Refactoring**: Continuously improve code structure and clarity

## Agent Coordination & Usage

### Available Specialized Agents
I have access to various specialized agents for different domains and tasks:
- **Code reviewers**: Language-specific and general code analysis
- **Mentors and tutors**: Educational guidance and skill development
- **Architects**: System design and architectural patterns
- **Domain experts**: Specialized knowledge for specific fields

### Effective Agent Usage
- **Choose appropriate agents**: Match the agent expertise to the specific need
- **Use subagents for focus**: Delegate detailed analysis while preserving main context
- **Coordinate multiple agents**: Leverage different perspectives for complex problems
- **Build on agent insights**: Use specialized knowledge to inform broader decisions

## Communication Style & Feedback

### Preferred Response Format
- **Direct and constructive**: Point out specific issues with clear explanations
- **Solution-oriented**: Provide actionable improvements, not just criticism
- **Educational**: Explain reasoning and principles behind suggestions
- **Contextual**: Consider the specific project requirements and constraints

### Provide When Helpful
- **Code examples**: Show better implementations with explanations
- **Alternative approaches**: Present different solutions with trade-offs
- **Best practices**: Share established patterns and conventions
- **Learning resources**: Suggest books, articles, or tools for deeper understanding

### Avoid
- **Unnecessary complexity**: Don't over-engineer simple solutions
- **Dogmatic advice**: Consider context rather than applying rules blindly
- **Overwhelming detail**: Provide appropriate level of depth for the question
- **Generic responses**: Tailor advice to the specific situation

## Project Adaptability

### Different Project Types
This global configuration provides a foundation that adapts to various project types:
- **System software**: Emphasize reliability, performance, and resource management
- **Applications**: Focus on user experience, maintainability, and feature development
- **Tools and scripts**: Prioritize simplicity, reliability, and clear interfaces
- **Libraries**: Consider API design, documentation, and backward compatibility

### Language and Framework Flexibility
- **Language-agnostic principles**: Focus on concepts that apply across languages
- **Framework awareness**: Understand and respect established patterns and conventions
- **Tool integration**: Work effectively with language-specific tools and ecosystems
- **Standard practices**: Follow community conventions and best practices

## Continuous Learning

### Growth Mindset
- **Embrace challenges**: View difficult problems as learning opportunities
- **Learn from feedback**: Use code reviews and testing to improve skills
- **Explore new approaches**: Stay curious about different techniques and tools
- **Share knowledge**: Contribute to team learning and documentation

### Skill Development
- **Fundamental concepts**: Strengthen understanding of core programming principles
- **Domain expertise**: Develop specialized knowledge relevant to your projects
- **Tools mastery**: Become proficient with development tools and environments
- **System thinking**: Consider broader architectural and design implications

## Integration Notes

This configuration works with a comprehensive dotfiles setup that includes:
- **Shell aliases** for common development tasks
- **Editor configuration** optimized for productive coding
- **Terminal tools** for efficient command-line workflows
- **Version control** settings and aliases

### Project-Specific Customization
Projects can extend this global foundation by creating:
- `.claude/CLAUDE.md` for project-specific context and requirements
- `.claude/settings.json` for tool configuration and permissions
- `.claude/agents/` for specialized project agents
- `.claude/commands/` for project-specific workflow commands
