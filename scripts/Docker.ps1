Enable-WindowsOptionalFeature -Online -FeatureName containers -All

RefreshEnv

choco install -y docker-desktop
choco install -y docker-compose
choco install -y vscode-docker
