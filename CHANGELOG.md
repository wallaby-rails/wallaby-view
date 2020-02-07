# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [TODO]

Continously to work on the rendering performance.

## [Unreleased]

## [0.1.0] - 2020-02-07

First version of `Wallaby::View` extracted from `Wallaby` gem:

### Added

- Method `_prefixes` can be easily extended using a block passing to `super`.

### Changed

- Allow searching template/partial using theme name and action name.

### Removed

- Removed Cell related function (since Cell rendering is no faster than general template/partial).
