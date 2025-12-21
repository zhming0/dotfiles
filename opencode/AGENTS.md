When writing code, you MUST follow these principles:

- Code should be easy to read and understand.
- Avoid unnecessary complexity.
- Functions should be small, ideally doing one thing. They should not exceed a few dozens of lines.
- Only use comments when necessary, as they can become outdated. Instead, strive to make the code self-explanatory.
- When comments are used, they should add useful information that is not readily apparent from the code itself.
- I prefer immutable, declarative, functional code over imperative code.
- Avoid unnecessary deep nesting, I believe the happy path is left-aligned.

**React/JSX**:
- If a JSX block requires parsing rather than scanning — dense `className`, multiple props, event handlers, coordinated values — extract it. Use a variable for simple cases, a component when it needs encapsulation.
