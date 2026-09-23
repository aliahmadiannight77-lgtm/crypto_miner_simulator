# Crypto Miner Simulator

A professional cross-platform educational cryptocurrency mining simulator built with Flutter.

> **Important:** This application is a simulation and educational game. It does **not** perform real cryptocurrency mining, does not connect to cryptocurrency exchanges, and does not create real cryptocurrency transactions. All balances, prices, rewards, mining activity, upgrades, conversions, and assets inside the application are virtual and have no real-world monetary value.

**Languages:** [English](README.md) · [فارسی](README.fa.md) · [العربية](README.ar.md)

---

## Overview

Crypto Miner Simulator is an educational game designed to combine cryptocurrency education with an interactive virtual mining experience.

Players can:

* Run a virtual mining operation
* Collect virtual cryptocurrency rewards
* Upgrade their virtual mining hardware
* Increase virtual mining power
* Convert virtual USDT into other virtual currencies
* Learn fundamental cryptocurrency and blockchain concepts
* Complete missions and achievements
* Earn XP and progress through levels
* Complete educational quizzes
* Receive daily rewards
* Use temporary virtual boosts
* Track mining and gameplay statistics
* Explore cryptocurrency prices using fixed in-game virtual values

The application is designed to work locally without requiring a backend server for its core gameplay.

---

## Core Concept

The main gameplay loop is:

**Mine → Earn → Upgrade → Increase Power → Earn More → Convert → Learn → Complete Missions → Receive Rewards → Continue Mining**

The game combines:

* Simulation
* Education
* Progression
* Virtual economy
* Missions
* Achievements
* Quizzes
* Statistics
* Customization

---

## Features

### Virtual Mining

The application provides a simulated mining system with:

* Virtual mining power
* Mining intervals
* Virtual mining rewards
* Mining history
* Mining statistics
* Manual mining interaction
* Offline/away reward calculation

Offline mining does **not** mean that the application performs real background mining.

Instead, the application stores the relevant local timestamps and calculates the appropriate virtual reward when the user returns.

---

### Virtual Cryptocurrency Economy

The simulator supports multiple virtual cryptocurrencies, including major assets such as:

* Bitcoin
* Ethereum
* TON
* USDT

Additional well-known cryptocurrencies are also supported by the application's virtual currency system.

All prices are predefined virtual values.

They are not live market prices and should not be interpreted as financial data.

---

### Virtual USDT

USDT is used as one of the main virtual currencies in the game.

Players can:

* Mine virtual USDT
* Hold virtual USDT
* Convert virtual USDT into supported virtual currencies
* Track virtual holdings
* View virtual portfolio values

The in-game USDT has **no real monetary value**.

---

### Currency Conversion

The game includes a virtual conversion system.

Users can convert one supported virtual currency into another according to the application's predefined virtual prices and game rules.

Conversions are recorded locally for statistics and history.

There is:

* No real exchange connection
* No real order execution
* No real withdrawal
* No real deposit
* No blockchain transaction

---

### Mining Farm Upgrades

Players can improve their virtual mining equipment through upgrades such as:

* CPU
* GPU
* Cooling
* Storage

Upgrades can increase the virtual mining power and create a progression system.

---

### Boost System

Temporary virtual boosts can increase mining efficiency for a limited period.

Boosts are governed by game rules such as:

* Duration
* Multiplier
* Usage limits
* Maximum active boosts

Boosts are entirely simulated.

---

### Education System

The application is also an educational platform.

Planned educational subjects include:

* Bitcoin
* Ethereum
* Blockchain
* Wallets
* Cryptocurrency Exchanges
* Stablecoins
* USDT
* TON
* Mining
* Hash Rate
* Network Fees
* Public Keys
* Private Keys
* Market Capitalization
* Volatility

Educational content is presented through lessons and quizzes.

---

### Quizzes

Educational quizzes allow users to test their knowledge.

The quiz system supports:

* Multiple-choice questions
* Correct answers
* Explanations
* Passing scores
* Best scores
* XP rewards
* Local progress tracking

---

### Missions

Missions provide structured gameplay objectives.

Examples include:

* Perform a number of mining actions
* Mine a specific amount
* Upgrade the miner
* Complete educational lessons
* Complete quizzes
* Convert virtual currencies
* Maintain gameplay activity

Missions can provide virtual XP and USDT rewards.

---

### Achievements

The achievement system tracks long-term player progress.

Achievements can be based on:

* Mining activity
* Mining amount
* Miner level
* Upgrades
* Education
* Missions
* Conversions
* Other gameplay milestones

---

### XP and Levels

Players earn virtual XP through gameplay and educational activities.

XP contributes to the player's level progression.

The progression system is entirely internal to the game.

---

### Daily Rewards and Streaks

The game includes progression mechanics such as:

* Daily rewards
* Activity streaks
* Best streak tracking
* Reward progression

These systems are designed to encourage consistent learning and gameplay.

---

### Statistics

The application records local gameplay statistics such as:

* Total mining actions
* Total mined amount
* Total mining time
* Mining power
* Number of conversions
* Upgrade costs
* Number of upgrades
* Completed lessons
* Completed quizzes
* Completed missions
* Unlocked achievements
* Claimed rewards
* Used boosts
* Highest miner level
* Highest mining power
* Longest streak

---

## Themes

The application is designed with multiple visual themes.

Current theme architecture includes:

* Light
* Dark
* Neon
* Premium

The default visual direction uses a clean white and light-blue interface.

---

## Localization

The application supports:

* فارسی
* English
* العربية

The localization architecture also supports right-to-left interfaces for Persian and Arabic.

---

## Cross-Platform

The project is designed as a shared Flutter application targeting:

* Android
* iOS
* Windows

The goal is to maintain a common codebase while respecting platform-specific requirements where necessary.

---

## Data Storage

The core application is designed around local storage.

The project currently uses local persistence for:

* Settings
* Game state
* Balances
* Holdings
* Mining history
* Progress
* Missions
* Achievements
* Education progress
* Rewards
* Statistics

The architecture is designed to support schema versioning and future migrations.

---

## Architecture

The project follows a layered architecture separating:

```text
Presentation
    ↓
Domain
    ↓
Data
    ↓
Local Storage
```

### Core

Contains shared application infrastructure:

* Constants
* Exceptions
* Error handling
* Localization
* Themes
* Utilities

### Data

Contains:

* Models
* Local storage
* Repositories
* Seed data

### Domain

Contains game rules and engines such as:

* Mining
* Offline mining
* Currency conversion
* Upgrades
* Boosts
* XP
* Levels
* Missions
* Achievements
* Rewards
* Statistics
* Streaks

### Features

Contains user-facing application features such as:

* Home
* Mining
* Currencies
* Boosts
* Education
* Missions
* Achievements
* Rewards
* Statistics
* Settings
* Onboarding

---

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── localization/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── local/
│   ├── models/
│   ├── repositories/
│   └── seed/
│
├── domain/
│   ├── achievement_engine.dart
│   ├── boost_engine.dart
│   ├── conversion_engine.dart
│   ├── currency_engine.dart
│   ├── game_engine.dart
│   ├── level_engine.dart
│   ├── mining_engine.dart
│   ├── mission_engine.dart
│   ├── offline_mining_engine.dart
│   ├── reward_engine.dart
│   ├── statistics_engine.dart
│   ├── streak_engine.dart
│   ├── upgrade_engine.dart
│   └── xp_engine.dart
│
├── features/
│   ├── achievements/
│   ├── boost/
│   ├── currencies/
│   ├── education/
│   ├── home/
│   ├── miner/
│   ├── missions/
│   ├── onboarding/
│   ├── rewards/
│   ├── settings/
│   ├── shell/
│   └── statistics/
│
└── widgets/
```

---

## Technology Stack

The project is built with:

* Flutter
* Dart
* Material 3
* Provider
* Shared Preferences
* FL Chart
* Intl
* Path Provider
* UUID
* Collection

The exact package versions are defined in `pubspec.yaml`.

---

## Privacy and Security

The application is designed with local-first principles.

The project does not require users to provide:

* Private keys
* Wallet seed phrases
* Exchange credentials
* Banking information
* Real cryptocurrency wallet credentials

The simulator should never request a user's real private key or recovery phrase.

---

## Real Cryptocurrency Disclaimer

This application is **not** a cryptocurrency wallet, exchange, mining pool, investment platform, or financial service.

It does not:

* Mine Bitcoin or another cryptocurrency
* Connect to blockchain networks for mining
* Submit real mining jobs
* Execute exchange orders
* Transfer cryptocurrency
* Process withdrawals
* Process deposits
* Generate real cryptocurrency
* Guarantee financial returns

All values shown by the application are part of a virtual game economy.

---

## Development Status

The project is under active development.

The architecture is being built incrementally with a focus on:

* Maintainability
* Type safety
* Validation
* Local persistence
* Separation of concerns
* Testability
* Cross-platform compatibility
* Clear game rules

Features may evolve as development continues.

---

## Getting Started

### Requirements

Install:

* Flutter SDK
* Dart SDK included with Flutter
* Git
* A supported development environment

Then verify Flutter:

```bash
flutter --version
```

Install project dependencies:

```bash
flutter pub get
```

Analyze the project:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Run the application:

```bash
flutter run
```

---

## Repository

The source code is maintained on GitHub.

Repository:

https://github.com/aliahmadiannight77-lgtm/crypto_miner_simulator

---

## License

This project is currently not published under an open-source license.

Unless a license file is added to the repository, the source code remains subject to the applicable copyright laws.

---

## Disclaimer

Crypto Miner Simulator is an educational simulation.

Cryptocurrency names, symbols and concepts are used for educational and gameplay purposes.

Nothing inside the application should be considered financial, investment, trading, mining, tax or legal advice.

**All in-game currencies, prices, balances and rewards are virtual.**
