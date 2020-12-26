# X1 Core Wallet

The X1 Core Wallet is a full node staking wallet user interface application built with Electron and Angular. It depends on [X1 Blockcore](https://github.com/x1crypto/x1-blockcore), the X1 full blockchain node, which is included as a git submudule to allow for the creation of one complete package.

# Building and running the X1 Core Wallet

## Install NodeJS

Download and install the latest Long Term Support (LTS) version of NodeJS at: https://nodejs.org/. 

## Getting Started

Clone this repository locally:

``` bash
git clone https://github.com/x1crypto/x1-core-wallet.git
git submodule update --init --recursive
```

Navigate to the src folder in a terminal:
``` bash
cd ./x1-core-wallet/src
```

## Install dependencies with npm:

From within the src directory run:

``` bash
npm install
```

## Run the UI in development mode

#### Terminal Window 1
``` bash
cd ./x1-core-wallet/x1-blockcore/src/X1/X1Daemon
dotnet run
```

#### Terminal Window 2
Use `npm run mainnet` to start the UI in mainnet mode or `npm run testnet` to start the UI in testnet mode.  
This will compile the Angular code and spawn the Electron process.

## Build the UI for production

|Command|Description|
|--|--|
|`npm run build:prod`| Compiles the application for production. Output files can be found in the dist folder |
|`npm run package:linux`| Builds your application and creates an app consumable on linux system |
|`npm run package:linuxarm`| Builds your application and creates an app consumable on linux-arm system (i.e., Raspberry Pi) |
|`npm run package:windows`| On a Windows OS, builds your application and creates an app consumable in windows 32/64 bit systems |
|`npm run package:mac`|  On a MAC OS, builds your application and generates a `.app` file of your application that can be run on Mac |

**The application is optimized. Only the files of /dist folder are included in the executable. Distributable packages can be found in the Scripts/Packager/ folder**