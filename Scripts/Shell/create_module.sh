#!/bin/bash

# 메뉴 옵션
options=("FeatureModule" "CommonModule" "MicroFeatureModule")

# 터미널 설정 저장
stty_orig=$(stty -g)

# 방향키 기반 선택 메뉴 함수
select_with_arrows() {
    local prompt="$1"
    shift
    local items=("$@")
    local selected_index=0
    local key
    local rest

    while true; do
        clear >&2
        echo "$prompt" >&2
        for i in "${!items[@]}"; do
            if [[ $i -eq $selected_index ]]; then
                echo -e "  > \033[32m${items[$i]}\033[0m" >&2
            else
                echo "    ${items[$i]}" >&2
            fi
        done

        read -rsn1 key
        if [[ $key == $'\x1b' ]]; then
            read -rsn2 rest
            key+=$rest
            if [[ $key == $'\x1b[A' ]]; then
                ((selected_index--))
                if ((selected_index < 0)); then selected_index=$((${#items[@]} - 1)); fi
            elif [[ $key == $'\x1b[B' ]]; then
                ((selected_index++))
                if ((selected_index >= ${#items[@]})); then selected_index=0; fi
            fi
        elif [[ $key == "" ]]; then
            echo "${items[$selected_index]}"
            return 0
        fi
    done
}

# 방향키 처리
selected_option=$(select_with_arrows "📦 생성할 모듈 타입을 선택하세요 (↑↓ 방향키로 선택, Enter로 확정):" "${options[@]}")

# 모듈 이름 입력
read -p "📝 생성할 모듈 이름을 입력하세요: " name
if [[ -z "$name" ]]; then
    echo "❌ 이름은 비워둘 수 없습니다."
    stty "$stty_orig"
    exit 1
fi

if [[ "$selected_option" == "MicroFeatureModule" && ! "$name" =~ ^[A-Z][A-Za-z0-9_]*$ ]]; then
    echo "❌ MicroFeature 이름은 Swift enum case로 사용할 수 있게 대문자로 시작해야 합니다. 예: Home"
    stty "$stty_orig"
    exit 1
fi

has_demo="false"
layer=""
if [[ "$selected_option" == "MicroFeatureModule" ]]; then
    layer_options=("Features" "Domain" "Data")
    layer=$(select_with_arrows "📂 MicroFeature layer를 선택하세요 (↑↓ 방향키로 선택, Enter로 확정):" "${layer_options[@]}")
    
    while true; do
        read -p "🧪 Demo target도 생성할까요? (y/n): " answer
        case "$answer" in
            [Yy]*)
                has_demo="true"
                break
                ;;
            [Nn]*)
                has_demo="false"
                break
                ;;
            *)
                echo "y 또는 n으로 입력해주세요."
                ;;
        esac
    done
fi

# scaffold 실행
echo "📁 [Tuist] ( $selected_option ) 모듈 '( $name )' 생성 중..."

if [[ "$selected_option" == "MicroFeatureModule" ]]; then
    scaffold_args=("$selected_option" "--name" "$name" "--layer" "$layer" "--has-demo" "$has_demo")
else
    scaffold_args=("$selected_option" "--name" "$name")
fi

if ! tuist scaffold "${scaffold_args[@]}"; then
	echo "❌ 템플릿 \"$selected_option\"이 없거나 문제가 발생했습니다."
    stty "$stty_orig"
	exit 1
fi

if [[ "$selected_option" == "MicroFeatureModule" ]]; then
    module_file="Tuist/ProjectDescriptionHelpers/Module/Module.swift"
    module_path="Projects/$layer/$name"
    
    if ! grep -Eq "^[[:space:]]*case[[:space:]].*\\b$name\\b" "$module_file"; then
        tmp_file=$(mktemp)
        awk -v case_name="$name" '
            /public enum MicroFeatureModule/ && /\{/ && !inserted {
                print
                print "    case " case_name
                inserted = 1
                next
            }
            { print }
        ' "$module_file" > "$tmp_file" && mv "$tmp_file" "$module_file"
        echo "✅ MicroFeatureModule enum에 case $name 추가 완료"
    fi
    
    if ! grep -Fq "case .$name:" "$module_file"; then
        tmp_file=$(mktemp)
        awk -v case_name="$name" -v module_path="$module_path" '
            /^[[:space:]]*var path: String \{/ {
                print
                in_path = 1
                next
            }
            in_path && /^[[:space:]]*\}/ && !inserted {
                print "        case ." case_name ": \"" module_path "\""
                inserted = 1
                in_path = 0
                print
                next
            }
            { print }
        ' "$module_file" > "$tmp_file" && mv "$tmp_file" "$module_file"
        echo "✅ MicroFeatureModule path에 $module_path 추가 완료"
    fi
    
    if [[ "$has_demo" == "false" ]]; then
        rm -rf "$module_path/Demo"
    fi
fi

# 터미널 설정 복원
stty "$stty_orig"
