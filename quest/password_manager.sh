#!/bin/bash

while true; do
    echo "パスワードマネージャーへようこそ!"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    read choices
    read gpg
    case $choices in
	"Add Password")
	    read -p "サービス名を入力してください:" service
	    service="${service:?サービス名を入力してください。}"
	    read -p "ユーザー名を入力してください:" user
	    user="${user:?ユーザー名を入力してください。}"
	    read -s -p "パスワードを入力してください:" password
	    password="${password:?パスワードを入力してください。}"
	    password.md 2> /dev/null
	    echo "$service:$user:$password" >> passwords.md
	    echo "パスワードの追加は成功しました。"
	    ;;
	"Get Password")
	    read -p "サービス名を入力してください:" service
	    password=$(grep "$service:" passwords.md | cut -d: -f3)
	    if [ -z "$password" ]; then
		echo "そのサービスは登録されていません。"
	    else
		echo "サービス名:$service"
		echo "ユーザー名:$(grep "$service:" passwords.md | cut -d: -f2)"
		echo "パスワード:$password"
	    fi
	    ;;
	"Exit")
	    echo -e "Thank you\033[31m! \033[m"
	    exit
	    ;;
	*)
	    echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
	    ;;
    esac
done

    rm passwords.md
