#!/bin/bash

echo "パスワードマネージャーへようこそ!"
echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
read choices

case $choices in
    "Add Password")
	read -p "サービス名を入力してください:" service
	read -p "ユーザー名を入力してください:" user
	read -p -s "パスワードを入力してください:" password
	echo "$service:$user:$password" >> passwords.md
	echo "パスワードの追加は成功しました。"
	;;
    "Get Password")
	read -p "サービス名を入力してください:" service
	password=$(grep "$service:" passwords.md | cut -d: -f3)
	if [ -z "$password"]; then
	    echo "そのサービスは登録されていません。"
	else
	    echo "サービス名:$service"
	    echo "ユーザー名:$(grep "$service:" passwords.md | cut -d: -f2)"
	    echo "パスワード:$password"
	fi
	;;
    "Exit")
	echo "Thank you\033[31m! \033[m"
	;;
    *)
	echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
	;;
esac
