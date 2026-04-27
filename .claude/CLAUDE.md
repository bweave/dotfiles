# Claude Code Guidelines

## Shell Tooling

- FILES: `fd` | TEXT: `rg` | CODE STRUCTURE: `ast-grep` | SELECTION: `fzf` | JSON: `jq` | YAML/XML: `yq`

## Code Principles

- SOLID OOP. Explicit > implicit. Simple > complex. Readability counts.
- Repetition is better than the wrong abstraction
- Naming is hard — explicit and verbose preferred
- Test at higher abstraction, dive when needed. 100% coverage is not the goal.
- Always format code, always lint and fix errors
- Every file ends with a newline, no trailing whitespace

## Design & Refactoring

Write code in the tradition of Sandi Metz, Martin Fowler, and Kent Beck.

**SOLID, applied concretely:**
- SRP: a class has one reason to change. If you describe it with "and", split it.
- OCP: add behavior by adding code, not by editing conditionals. Reach for polymorphism before a new `case` branch.
- LSP: subclasses honor the parent's contract — no surprise `raise NotImplementedError`, no narrowing of accepted inputs.
- ISP: many small, role-based interfaces over one fat one. Duck-type on what's used, not what's inherited.
- DIP: depend on abstractions (a method name, a role), not concretions. Inject collaborators; don't `new` them inside.

**Metz heuristics:**
- Methods ≤ 5 lines. Classes ≤ 100 lines. Four parameters max; prefer a parameter object beyond two.
- Every method does one thing at one level of abstraction.
- Prefer composition over inheritance. Inheritance only for true is-a with shared behavior.
- TRUE: Transparent, Reasonable, Usable, Exemplary.

**Refactoring discipline (Fowler):**
- Refactoring changes *how* code works, never *what* it does. Behavior is preserved; tests stay green the entire time.
- Never mix a refactor and a behavior change in the same commit. Separate them — even if it means two commits seconds apart.
- "Make the change easy (warning: this may be hard), then make the easy change." — Kent Beck. If the next step feels hard, stop and refactor until it's easy, then do it.
- Small steps. Run tests after each one. Revert, don't debug, if something goes red unexpectedly.
- Name the smell before the fix: long method, feature envy, primitive obsession, shotgun surgery, etc. The name picks the refactor.

**Flocking Rules (for extracting abstractions from duplication):**
1. Select the things that are most alike.
2. Find the smallest difference between them.
3. Make the simplest change that will remove that difference.
Change one thing at a time. Only abstract after the duplication has spoken — do not guess the abstraction up front. Repetition is cheaper than the wrong abstraction.

**TDD rhythm (Beck):**
- Red, green, refactor — in that order, every time.
- Write the test that fails for the reason you expect. Make it pass with the most embarrassing code that works. *Then* refactor.
- "Fake it till you make it" and "triangulate" are legitimate — generality is earned by a second test, not imagined.

## Ruby and Rails

- Do it the Rails Way — pragmatic, idiomatic implementations
- Fixtures match real-world data, including edge cases the schema allows even if the app wouldn't
- Avoid explicit `begin..rescue..end` when possible
- Minitest over RSpec (accept RSpec if already in codebase)
- Prefer `assert_equal` and data-in-data-out tests
- Test structure: setup, blank line, exercise, blank line, assertions
- Never edit Rails credentials — pause and provide instructions for the developer
- Never run `rails db:reset/drop/seed/migrate/rollback/setup` without explicit permission

## JavaScript, TypeScript, and React

- Simplest, most idiomatic approach. Native implementations over libraries.
- React: functional components and hooks, JavaScript (not TypeScript)

## UI Testing

- Puppeteer preferred, screenshots at 1280x800

## Git

Use `gh` CLI for all GitHub interactions.

**Commits:**
- Conventional types: feat, fix, chore, perf, security, deps
- Imperative mood, 50-char subject, 72-char wrap body
- Separate subject from body with blank line
- Write for humans — clarity, empathy, the "why" alongside the "what"
- Small, iterative commits that tell the story

**Pull Requests:**
- Draft PRs only
- Use `.github/pull_request_template.md` if available
- Branch naming: `bw/{type}-<branch-name>`
- Include summary and reviewer-relevant details
- Add Claude Code signature on PR comments
- **Post-PR monitoring (required):** After creating or pushing to a PR, automatically poll for CI status and review comments until all checks complete. If CI fails, diagnose and fix. If review comments exist, evaluate each suggestion, implement valid ones, push fixes, and reply on the PR. Do not wait to be asked.
