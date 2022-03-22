#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

echo 'Running Pre Commit Hooks...👨🏾‍💻\n'

# Lints staged files... checks what you've changed
echo '\n Linting staged files... 🐫'

npx lint-staged

echo '🏗️👷 Styling, testing and building your project before committing'

# Check Prettier standards
yarn check-format ||
(
    echo '🤢🤮 It'\''s weak bro. - Poor style, no finesse. 🤢🤮
            Prettier Check Failed. Run yarn format, add changes and try commit again.';
    false;
)

# Check ESLint Standards
yarn check-lint ||
(
        echo '👋😤 Coding Quality + Standards for where? Try again! 👋😤 
                ESLint Check Failed. Make the required changes listed above, add changes and try to commit again.'
        false; 
)

# Check tsconfig standards
yarn check-types ||
(
    echo '❌🤡 Failed Type check. ❌🤡
            Are you seriously trying to write that? Make the changes required above.'
    false;
)

# If everything passes... Now we can commit
echo '🤔🤔... Ite... Say no more... Code looks good to me... Building... 🤔🤔🤔🤔'

yarn run build ||
(
    echo '❌❌ Better call Bob... Because your build failed ❌❌
            Next build failed: View the errors above to see why.'
    false;
)

# If everything passes... Now we can commit
echo '✅✅ You win this time... I am committing this now. ✅✅'