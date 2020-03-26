# 关于支付宝客户端签名文件
- 需要将 AliPayDepend目录下 Signer 拖入工程，不要勾选copy
- 在 Build Settings -  Header Search Paths 中添加  "$(PROJECT_DIR)/Pay/AliPayDepend/Signer"
- 包内的是对应旧版支付宝SDK支付宝签名文件，现在应该下载支付宝官方Demo，获取新的签名文件，按新的签名方法进行签名。
