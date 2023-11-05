# Devcontainer sandbox

Docker on devcontainer on wsl2

## 起動方法

### windows側の設定

github用のssh鍵を生成
https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key

ssh鍵をssh-agentに登録する
https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent

### wsl2側の設定

windows側で設定したssh鍵によってgithubに疎通できることを確認する

```sh
ssh -T git@github.com
```

devcontainerを起動するために[docker engineをインストール](https://docs.docker.com/engine/install/ubuntu/)する

Githubからこのリポジトリをcloneする

```sh
git clone git@github.com:sakin97/devcontainer.git
```

### 起動

[devcontainers vscode extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)をインストール

wsl2にて

```sh
code <git clone先>
```

コマンドパレットより `Dev Containers: Reopen in Container` を実行

## このリポジトリの作成手順

上記wsl2側の設定のdocker engineのインストールまでやる

nestjsのリポジトリ作成

```sh
npm i -g @nestjs/cli
nest new devcontainer
```

コマンドパレットより

- `Dev Containers: Add Dev Container Configuration Files...`  
- `From a predefined container configuration definition...`
- Node.js & TypeScript, 20-bullseye を選択

すると以下のようなファイルが .devcontainer/devcontainer.json として作成される

```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/typescript-node
{
 "name": "Node.js & TypeScript",
 // Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
 "image": "mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye",

 // Features to add to the dev container. More info: https://containers.dev/features.
 // "features": {}

 // Use 'forwardPorts' to make a list of ports inside the container available locally.
 // "forwardPorts": [],

 // Use 'postCreateCommand' to run commands after the container is created.
 // "postCreateCommand": "yarn install",

 // Configure tool-specific properties.
 // "customizations": {},

 // Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
 // "remoteUser": "root"
}
```

この時点でdevcontainerを起動できるようになる。コマンドパレットより `Dev Containers: Reopen in Container` を実行して起動することを確認する。

devcontainerの内部でdockerを利用できるようにする。featuresに[以下を設定](https://containers.dev/features)

```json
{
  ...
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:2": {}
  }
  ...
}
```

コマンドパレットより ` Container` を実行し、devcontainerが立ち上がることを確認する。

この状態でdockerを利用できることを確認する。  
詳細はMakefileを参照

```sh
make docker-build
make docker-run
curl http://localhost:3000 # 200が帰ってくればOK
```

現時点でのdevcontainer imageをghcrにpushする。  
.github/workflows/devcontainer.ymlを参照  
リポジトリ設定の Actions → General のWorkflow permissionsにて `Read and write permissions` を許可してから上記のymlを実行するためgitにpushする  
この設定はセキュリティリスクを伴うため、ymlにて埋込の `secrets.GITHUB_TOKEN` に適切なwrite permissionを与えるほうがよい



