swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios15.0-simulator"
sourcedocs generate --all-modules
git add . && git commit -m "chore: update docs"
npm run release
git push origin main --follow-tags
bundle exec fastlane release
