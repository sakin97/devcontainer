# Devcontainer sandbox

Docker on devcontainer on wsl2

## 起動方法

## windows側の設定

github用のssh鍵を生成
https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key

ssh鍵をssh-agentに登録する
https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent


## wsl2側の設定

windows側で設定したssh鍵によってgithubに疎通できることを確認する

```
ssh -T git@github.com
```

devcontainerを起動するためにdocker engineをインストールする
https://docs.docker.com/engine/install/ubuntu/

Githubからこのリポジトリをcloneする
```
git clone git@github.com:sakin97/devcontainer.git
```

## 起動

devcontainers vscode extensionをインストール
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

wsl2にて
```
code <git clone先>
```

コマンドパレットより `Dev Containers: Reopen in Container` を実行

## このリポジトリの作成手順


