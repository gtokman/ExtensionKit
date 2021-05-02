swift build
sourcedocs generate --all-modules
git add . && git commit -m "chore: update docs"
npm run release
git push origin main --follow-tags
bundle exec fastlane release