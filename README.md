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

## APIキーとSOPS
このリポジトリでは`sops-nix`でAPIキーを管理します。以下のファイルが前提です。
- `.sops.yaml`: Age鍵のルール
- `secrets/api-keys.yaml.example`: 入力例
- `secrets/api-keys.yaml`: 暗号化された実ファイル（コミットしない）

### 初回セットアップ
```bash
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
age-keygen -y ~/.config/sops/age/keys.txt

cp secrets/api-keys.yaml.example secrets/api-keys.yaml
sops secrets/api-keys.yaml
```

`.sops.yaml`に公開鍵を追加した後、必要なら再暗号化します。
```bash
sops updatekeys secrets/api-keys.yaml
```

### 必要なキー
`secrets/api-keys.yaml`には次のキーを入れます。
- `opencode_api_key`
- `claude_api_key`

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
