#!/bin/bash

echo "パスワードマネージャーへようこそ!"
echo "サービス名を入力してください:"
read service
echo "ユーザー名を入力してくだし:"
read user
echo "パスワードを入力してください:"
read password
echo "$service:$user:$password" >> pass.md
echo -e "Thank you\033[31m! \033[m"
