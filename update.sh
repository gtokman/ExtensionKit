swift build
sourcedocs generate --all-modules
npm run release
git commit --amend --no-edit
git push origin main --follow-tags