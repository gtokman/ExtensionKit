module.exports = {
  extends: ["@commitlint/config-conventional"],
  parserPreset: {
    parserOpts: {
      issuePrefixes: ["[A-Z]{2,}-"],
    },
  },
  rules: {
    "references-empty": [0, "never"],
    "header-max-length": [0, "always", 90],
    "subject-empty": [0, "never"],
    "type-empty": [2, "never"],
    "footer-leading-blank": [0, "never"],
    "scope-case": [0, "never"],
  },
};