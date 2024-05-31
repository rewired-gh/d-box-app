# D-Box App

D-Box, the successor to C-Box, is a trustworthy vault app utilizing state-of-the-arts algorithms.
Comparing to C-Box, it offers an even better UX experience and better algorithms.

## Download and install

Please download the latest version of the app from GitHub Releases.
Not all supported platforms have its pre-built app.

## Cryptography algorithms

D-Box uses platform-specific true random algorithm and dynamic generated nonces to prevent any replay attack.
It also uses the most robust and time-proven algorithms with parameters with sufficient safety margins to hash password and encrypt data.
Because the app uses platform-specific APIs whenever possible, it runs fast on nearly all devices.

- Password hashing: Argon2id
    - Parallelism: 1
    - Memory: 47104 kBytes
    - Hash length: 32 Bytes
- Symmetric encryption: AES-GCM
    - Length: 256 bits

## Features

- [x] Master password
- [ ] Content encryption
    - [x] Text content
    - [ ] (Planned) Item title
    - [ ] Multimedia
- [x] Lock on request
- [ ] Localization
    - [x] English
    - [ ] (Partial) Simplified Chinese
- [x] Customizable color theme
- [x] Reset password
- [x] Export and import data
- [ ] (Planned) Cloud sync

## Collaboration

Currently I'm too busy so it might be really hard to collaborate with others.
But you're welcome to open new issues and PRs to this project.

