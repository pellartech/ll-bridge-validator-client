# Bridge Validator Setup
This guide will walk you through setting up bridge validator.

## Prerequisites
- Ubuntu Server 20.04 or later
- Ethereum RPC fullnode
- Lightlink RPC fullnode

## Installation
1. **Provide environment variables:**
  export SYSTEM_SECRET_KEY=${your application secret key}
  export CHAINS_ETHEREUM_RPC_URL=${your ethereum rpc}
  export CHAINS_LIGHTLINK_RPC_URL=${your lightlink rpc}

2. **Install Modules and Application:**
  Run the following commands in your terminal:

  ```
  chmod +x ubuntu/start.sh
  ./ubuntu/start.sh
  ```

3. **Stop Application:**
  Run the following commands in your terminal:

  ```
  chmod +x ubuntu/stop.sh
  ./ubuntu/stop.sh
  ```

4. **Remove Application:**
  Run the following commands in your terminal:

  ```
  chmod +x ubuntu/down.sh
  ./ubuntu/down.sh
  ```