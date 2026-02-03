# nixos-config

NixOS向けのflake構成リポジトリです。現在の対象ホストはCitrusのみです。

## 前提
- Nix (flakes有効)
- NixOSホストを扱う場合は`nixos-rebuild`が使える環境

## 使い始め
```bash
git clone https://github.com/lupo409/nixos-config.git
cd nixos-config
```

## NixOSビルド (Citrus)
### ハードウェア設定生成
```bash
sudo nixos-generate-config --show-hardware-config > hosts/citrus/hardware-configuration.nix
```

### 適用
```bash
sudo nixos-rebuild switch --flake .#Citrus
```

### Secure Boot (初回のみ)
```bash
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft
sudo sbctl verify
```

## メンテナンス
```bash
nix fmt
nix flake check
```

## CI
push時に`nix flake check`がGitHub Actionsで自動実行されます。
