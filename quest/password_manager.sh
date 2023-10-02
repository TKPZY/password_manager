#!/bin/bash

while true; do
    echo "パスワードマネージャーへようこそ!"

    echo "GPGキーで設定したメールアドレスを入力してください。"
　　read gpg_mail
    gpg_mail="${gpg_mail:?GPGキーで設定したメールアドレスを入力してください。}"
    
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
    read choices

    case $choices in
	"Add Password")
	    read -p "サービス名を入力してください:" service
	    service="${service?サービス名を入力してください。}"
	    read -p "ユーザー名を入力してください:" user
	    user="${user?ユーザー名を入力してください。}"
	    read -s -p "パスワードを入力してください:" password
	    password="${password?パスワードを入力してください。}"
	    gpg -d password.gpg > password.md 2> /dev/null
	    echo "$service:$user:$password" >> password.md
	    gpg -r "gpg_mail" -e -o password.gpg password.md
	    echo "パスワードの追加は成功しました。"
	    ;;
	"Get Password")
	    read -p "サービス名を入力してください:" service
	    gpg -d password.gpg > password.md 2> /dev/null
	    password=$(grep "$service:" password.md | cut -d: -f3)
	    if [ -z "$password" ]; then
		echo "そのサービスは登録されていません。"
	    else
		echo "サービス名:$service"
		echo "ユーザー名:$(grep "$service:" password.md | cut -d: -f2)"
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

