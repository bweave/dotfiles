# Claude Code Guidelines

- Please think about multiple options for each implementation and ask me which one I would like or if I would like to do something else
- Use Ripgrep (rg) to grep codebases

## Coding Guidelines

- Follow SOLID Object Oriented Programming principles 
- Beautiful is better than ugly.
- Explicit is better than implicit.
- Simple is better than complex.
- Complex is better than complicated.
- Flat is better than nested.
- Sparse is better than dense.
- Readability counts.
- Special cases aren't special enough to break the rules. Although, practicality beats purity.
- Errors should never pass silently, unless explicitly silenced.
- In the face of ambiguity, refuse the temptation to guess.
- If the implementation is hard to explain, it's a bad idea.
- If the implementation is easy to explain, it may be a good idea.
- Naming is hard, so explicit and verbose is preferred
- Repetition is better than the wrong abstraction
- As a rule of thumb, test at a higher level of abstraction, but dive down when needed
- Write enough tests that we can all sleep comfy at night, but 100% test coverage is not the goal
- Always format code
- Always lint and fix errors

## Ruby and Rails

- Do it the Rails Way
- Always choose the most pragmatic, idiomatic Rails implementation
- I always want fixtures to match real-world data, including things that are possible based on the database schema, even if the app wouldn't allow it to happen
- Avoid explicit begin..rescue..end block, if possible
- I prefer test driven development, but it isn't necessary. In the end, always prefer simple, data-in-data-out tests and prefer highly specific assertions like assert_equal
- I prefer Minitest over RSpec, but I will accept RSpec if it is already in the codebase
- When writing tests, prefer to keep all the setup together, then a blank line, then the exercise, then a blank line, then all the assertions. I know this isn't always possible, but we should strive for this whenever we can
- Always add a new line to the end of files and never add trailing whitespace
- Always remove trailing whitespace
- Every file needs to end with a new line character
- Don't try to edit Rails credentials. If credentials need to be changed, pause, and provide specific instructions for the developer to do it
- Never run `rails db:reset` or `rails db:drop` or `rails db:seed` or `rails db:migrate` or `rails db:rollback` or `rails db:setup` or `rails db:environment:set RAILS_ENV=development` without my explicit permission.

## JavaScript and TypeScript

- Always use the simplest and most idiomatic approach
- Always prefer native implementations over libraries
- Always remove trailing whitespace

## React

- Always use functional components and hooks
- Always use JavaScript
- Always use the simplest and most idiomatic approach
- Always prefer native implementations over libraries
- Always remove trailing whitespace

## Screenshots and UI Testing

- Puppeteer is preferred for UI testing
- Screenshots should be taken at 1280x800 resolution

## Git and Github

- Remember that you are writing for humans, not machines. Always bias for clarity, simplicity, and understanding.
- Always include the "why" alongside the "what" in commits and PR descriptions.
- Look for PR templates and use them if available.
- Empathy for our future selves and teammates is key
- Small, iterative commits FTW
- Take the time and care to author commits that tell the story

### Git

Use the GitHub CLI (the gh command) to interact with GitHub. GitHub is where all my projects are hosted.

When creating commits, follow these guidelines:

- Always use conventional commit types: feat, fix, chore, perf, security, deps
- Separate the subject from the body with a blank line
- Use the imperative mood in the subject line
- Stick to a 50-character subject line
- Wrap the longer description to 72 characters
- Use markdown when appropriate

## Github

- Only create draft pull requests
- When creating PRs, check for a template at `.github/pull_request_template.md` and follow its format
- Enhance the description with a summary of the changes
- Notate particular details that may be important for reviewers
- When creating new branches, use the `bw/{feat/fix/chore/perf/security/deps}-<branch-name>` format
- Add the Claude Code signature when creating PR comments on my behalf
