# D-Box App

D-Box, the successor to C-Box, is a reliable vault application that leverages state-of-the-art algorithms.
Compared to C-Box, D-Box offers an enhanced user experience and improved algorithms.

## Download and Install

To download the latest version of the app, please visit the GitHub Releases.
Note that not all supported platforms have a pre-built app available.

## Cryptographic Algorithms

D-Box employs platform-specific true random algorithms and dynamically generated nonces to prevent replay attacks.
It also utilizes the most robust and time-tested algorithms with parameters ensuring sufficient safety margins for hashing passwords and encrypting data.
By using platform-specific APIs whenever possible, D-Box achieves optimal performance on nearly all devices.

- **Password Hashing:** Argon2id
  - Parallelism: 1
  - Memory: 47104 kBytes
  - Hash length: 32 Bytes
- **Symmetric Encryption:** AES-GCM
  - Key length: 256 bits

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

Currently, I am quite busy, which might make collaboration difficult.
However, you are welcome to open new issues and pull requests (PRs) for this project.

