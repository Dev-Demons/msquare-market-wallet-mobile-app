import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          "username": "성명",
          "Fee": "요금",
          'in_progress': "진행 중",
          "completed": "완전한",
          "fingerprint_popup": "지문 인증을 활성화하려면 비밀번호를 입력하세요.",
          "copy_address": "주소 복사",
          'hello': '안녕하세요',
          'welcome_back': '다시 오신 것을 환영합니다',
          'trading': '거래',
          'p2p_trading': 'P2P 거래',
          'bank_transfer_paypal_and_more': '은행 송금, 페이팔 등',
          'coin_price': '코인 가격',
          'wallet': '지갑',
          'my_wallet': '내 지갑',
          'total_value': '총 가치',
          'available_balances': '사용 가능한 잔액',
          'deposit': '보증금',
          'withdraw': '철회하다',
          'transfer': '옮기다',
          'history': '역사',
          'sign_in_with_facebook': '페이스북으로 로그인',
          'sign_in_with_google': '구글로 로그인',
          'sign_in_with_apple': '사과로 로그인',
          'welcome': '어서 오십시오',
          'user_name': '사용자 이름',
          'settings': '설정',
          'app_language': '앱 언어',
          'privacy_settings': '개인 정보 설정',
          'fingerprint_authentication': '지문 인증',
          'fingerprint_text':
              '비밀번호 대신 지문을 사용하여 결제를 처리하세요. 암호 옵션은 계속 사용할 수 있습니다.',
          'other': '다른',
          'privacy_policy': '개인 정보 정책',
          'terms_and_conditions': '이용약관',
          'contact_us': '문의하기',
          'logout': '로그 아웃',
          'name': '이름',
          'email': '이메일',
          'account': '계정',
          'user_details': '사용자 세부정보',
          'scan_qr_code': 'QR 코드 스캔',
          'Total_balance_in ': '총 잔액',
          'Tokens': '토큰',
          'My_Assets': '내 자산',
          'Enter_the_amount_to_swap': '교환할 금액을 입력하세요.',
          "attempts_remaining": "남은 시도 횟수",
          "Price": "가격",
          "Amount": "양",
          "buy_products": "제품 구매",
          "token_transfer": "토큰 전송",
          "secure_layer": "보안 계층",
          "discounted_products": "할인 제품",
          "boarding_screen_tagline_1": "지원되는 매장에서 제품을 구매하고 MSQ 지갑으로 결제하세요.",
          "boarding_screen_tagline_2":
              "모든 디지털 자산을 간단하고 쉽게 처리합니다. 저장, 전송 및 거래까지 가능합니다.",
          "boarding_screen_tagline_3": "MFA 인증 시스템을 통해 거래 및 자산 관리를 계속 제어하십시오.",
          "boarding_screen_tagline_4": "적립된 포인트는 가맹점에서 캐쉬백으로 사용 가능",
          "transaction_history": "거래 내역",
          "history_list_empty": "기록 목록이 비어 있습니다!",
          "create_id": "유저 아이디 생성",
          "enter_user_id": "지갑의 유저 아이디를 입력하십시오",
          "user_id": "유저 아이디",
          "characters": "등장인물",
          "first_must_be_lower": "첫 번째 문자는 소문자여야 합니다",
          "create_pass": "비밀번호 생성",
          "pls_create_pass": "상표에 대한 암호를 생성하십시오",
          "pass": "암호",
          "confirm_pass": "비밀번호 확인",
          "must_include_upper_lower": "대문자와 소문자를 포함해야 함",
          "must_include_special": "특수 문자와 숫자를 포함해야 함",
          "accept_pass_agreement": "비밀번호 분실 동의에 동의합니다",
          "next": "다음",
          "pass_not_match": "암호가 일치하지 않습니다",
          "want_to_logout": "로그아웃하시겠습니까",
          "logout_msg": "돌아가면 현재 사용자가 로그아웃됩니다.",
          "back_to_home_page": "홈페이지로 돌아 가기",
          "error_404": "페이지를 찾을 수 없음",
          "error_500": "내부 서버 오류",
          "error_502": "잘못된 게이트웨이",
          "p2p_listings": "P2P 목록",
          "Buying": "사다",
          "Selling": "팔다",
          "Token": "토큰",
          "create_p2p_ad": "P2P 광고 만들기",
          "listing_type": "리스팅 유형",
          "create": "창조하다",
          "p2p_trade": "P2P 거래",
          "you_sure": "확실해?",
          "really_sure": "거래를 계속 진행하시겠습니까?",
          "close": "닫다",
          "i_sure": "응 확신 해",
          "wallet_request": "월렛 요청",
          "request_for_address_and_balance": "주소 및 잔액을 요청했습니다",
          "requested_by": "에 의해 요청",
          "platform": "플랫폼",
          "refuse": "거절하다",
          "accept": "수락",
          "invalid_token_type": "잘못된 토큰 유형",
          "max": "최대",
          "reset": "리셋",
          "unlock_wallet": "사용자의 신원을 확인",
          "scan_finger_to_connect": "지문을 스캔하여 거래를 확인하세요.",
          "amount_swapped": "스왑된 금액",
          "scan_finger": "계속하려면 손가락을 스캔하세요.",
          "use_password": "비밀번호 사용",
          "pass_verify": "비밀번호 유효성 검사",
          "enter_pass": "본인 확인을 위한 비밀번호 입력",
          "wrong_password": "잘못된 비밀번호를 입력하셨습니다",
          "p2p_listings_empty": "P2P 목록이 비어있습니다",
          "cancel": "취소",
          "Buy": "구입하다",
          "Sell": "팔다",
          "no_permission": "권한 없음",
          "transaction_detail": "거래 세부 정보",
          "proceed_transaction": "이 트랜잭션을 계속하시겠습니까?",
          "wallet_address": "지갑 주소",
          "transaction_done": "이미 거래 완료. 다른 QR 코드를 사용하십시오.",
          "incorrect_password": "잘못된 비밀번호",
          "amount_not_swapped": "지갑에 MATIC 이 충분하지 않습니다",
          "transaction_unsuccessful": "거래가 성공하지 못했습니다",
          "fingerprint_failed": "지문 인증 실패",
          "sign_in_with": "로 로그인하다",
          "announcement": "발표",
          "nothing_to_show": "표시할 항목 없음",
          "to": "에게",
          "from": "~에서",
          "out": "밖으로",
          "in": "안에",
          "wallet_termination": "MSQAURE 지갑 종료",
          "please_enter_valid_amount": "유효한 금액을 입력하세요",
          "you_have_created_an_ad": "광고를 만들었습니다.",
          "you_can_have_a_look_at_your_ad’s_on_your_listings_page":
              "목록 페이지에서 광고를 볼 수 있습니다.",
          "take_me_to_listings": "목록으로 이동",
          "cancel_ad_creating": "광고 작성을 취소하시겠습니까?",
          "if_you_choose_to_cancel": "취소를 선택하면 입력한 세부 정보가 손실됩니다.",
          "yes": "예",
          "no": "아니요",
          "your_order_has_been_placed": "주문이 접수되었습니다",
          "order_completed": "주문완료",
          "order_cannot_be_deleted": "주문을 삭제할 수 없음",
          "order_successfully_deleted": "주문이 성공적으로 삭제됨",
          "wallet_termination_screen": "지갑 종료",
          "proceed_wallet_termination": "지갑 해지 진행을 위해 아래 비밀번호 입력",
          "ok": "좋아요",
          "invalid_password": "유효하지 않은 비밀번호",
          "wallet_termination_failed": "MSQ 지갑 종료 실패",
          "wallet_successfully_terminated": "MSQ 지갑이 성공적으로 종료되었습니다.",
          "or": "또는",
          "swap": "스왑",
          "exit_app": "앱 종료",
          "exit_app_msg": "응용 프로그램을 종료하시겠습니까?",
          "home": "집",
          "transaction_request": "트랜잭션 요청",
          "transaction_confirmed": "거래 확인",
          "transaction_confirm_msg": "귀하의 거래가 성공적으로 승인되었습니다",
          "back_to_home": "홈으로 돌아가기",
          "request_confirmation": "등록이 완료되었습니다",
          "request_confirmation_msg": "지갑 주소가 생성되었습니다.",
          "transaction_failed": "거래 실패",
          "create_pass_agreement_title": "비밀번호 분실에 대한 책임은 이용자에게 있음",
          "create_pass_agreement_label_1":
              "MSQUARE MARKET은 블록체인 기술을 기반으로 한 탈중앙화 지갑으로 사용자의 비밀번호를 저장하지 않습니다.",
          "create_pass_agreement_label_2":
              "비밀번호 관리의 책임은 이용자에게 있으며, 비밀번호 분실 시 복구가 불가능하며, MSQUARE WALLET의 모든 디지털 자산에 대한 접근이 불가능합니다.",
          "create_pass_agreement_label_3":
              "참고: MSQUARE는 비밀번호 분실 시 도움을 드릴 수 없습니다. 잠시 시간을 내어 메모장에 비밀번호를 저장해 두십시오.",
          "wallet_id_copied": "지갑 주소가 클립보드에 복사되었습니다.",
          "total_amount": "총액",
          "contact_us_title": "어떻게 도와 드릴까요?",
          "contact_us_msg": "질문 및 문제가 있는 경우 당사에 문의하십시오.",
          "error": "오류",
          "message": "메시지",
          "send": "보내다",
          "contact_us_error_1": "연락해 주셔서 감사합니다",
          "contact_us_error_2": "귀하의 응답을 받을 수 없습니다. 다시 시도하십시오",
          "contact_us_error_3": "오류 값이 비어 있습니다.",
          "contact_us_error_4": "이메일 값이 비어 있습니다.",
          "contact_us_error_5": "메시지 값이 비어 있습니다.",
          "contact_us_error_6": "이메일이 잘못되었습니다! 다시 시도하십시오",
          "null_value": "값은 비워둘 수 없습니다.",
          "not_enough_balance": "불충분한 자금",
          "pass_limit_reached": "비밀번호 시도 횟수 한도에 도달했습니다. 5분 후에 다시 시도하십시오.",
          "try_again_msg_1": "다시 시도하십시오 안에",
          "try_again_msg_2": "의사록",
          "username_copied": "사용자 이름이 클립보드에 복사됨",
          "p2p_trading_msg": "디지털 자산 거래",
          "resolve_errors": "오류를 수정하십시오",
          "not_enough_p2up": "P2UP가 충분하지 않음",
          "not_enough_msq": "MSQ가 충분하지 않음",
          "order_not_placed": "귀하의 주문을 할 수 없습니다. 다시 시도해 주세요",
          "change_password": "비밀번호 변경",
          "confirm_change_password_1": "msquare 지갑 계정의 비밀번호를 변경하려면 신원을 확인하십시오.",
          "confirm_change_password_2": "로그인 후 거래에 사용하는 비밀번호를 변경할 수 있습니다.",
          "current_password": "현재 비밀번호",
          "new_password": "새 비밀번호",
          "confirm_new_password": "새 암호를 확인합니다",
          "np_cp_not_match": "새 비밀번호와 비밀번호 확인이 일치하지 않습니다.",
          "update_password": "비밀번호 업데이트",
          "pass_change_success": "비밀번호가 성공적으로 변경됨",
          "pass_change_fail": "비밀번호가 변경되지 않음",
          "billing": "청구",
          "payment_method": "지불 방법",
          "update_billing_details": "청구 세부 정보 및 주소 업데이트",
          "add_payment_method": "새 결제 수단 추가",
          "email_address": "이메일 주소",
          "invoices_to_this_mail": "인보이스는 이 이메일로 발송됩니다.",
          "card_company": "카드사",
          "select_your_card": "당신의 카드를 선택하세요",
          "login_id": "로그인 ID",
          "enter_login_id": "로그인 아이디를 입력하세요",
          "card_password": "카드 비밀번호",
          "enter_card_password": "카드 비밀번호 입력",
          "add_card": "카드 추가하기",
          "card_not_added": "카드가 추가되지 않음",
          "card_added": "카드가 추가되었습니다",
          "no_internet_connection": "인터넷에 연결되지 않음",
          "retry": "재시도",
          "swap_token": "스왑 토큰",
          "topup_credit": "충전/크레딧",
          "internet_restored": "인터넷 복원"
        },
        'ja_JP': {
          "username": "성명",
          "Fee": "費用",
          'in_progress': "進行中",
          "completed": "完了",
          'fingerprint_popup': "パスワードを入力して指紋認証を有効にします",
          "copy_address": "アドレスをコピー",
          'hello': 'こんにちは',
          'welcome_back': 'お帰りなさい！',
          'trading': '取引',
          'p2p_trading': 'P2P取引',
          'bank_transfer_paypal_and_more': '銀行振込、PayPal など',
          'coin_price': 'コイン価格',
          'wallet': '財布',
          'my_wallet': '私の財布',
          'total_value': '総価値',
          'available_balances': '利用可能残高',
          'deposit': 'デポジット',
          'withdraw': '撤退',
          'transfer': '移行',
          'history': '歴史',
          'sign_in_with_facebook': 'フェイスブックでサインイン',
          'sign_in_with_google': 'グーグル でログイン',
          'sign_in_with_apple': 'アップルでサインイン',
          'welcome': 'いらっしゃいませ',
          'user_name': 'ユーザー名',
          'settings': '設定',
          'app_language': 'アプリの言語',
          'privacy_settings': 'プライバシー設定',
          'fingerprint_authentication': '指紋認証',
          'fingerprint_text':
              'パスワードの代わりに指紋を使用して支払いを処理します。パスワードオプションは引き続き利用できます。',
          'other': '他の',
          'privacy_policy': 'プライバシーポリシー',
          'terms_and_conditions': '規約と条件',
          'contact_us': 'お問い合わせ',
          'logout': 'ログアウト',
          'name': '名前',
          'email': 'Eメール',
          'account': 'アカウント',
          'user_details': 'ユーザーの詳細',
          'scan_qr_code': 'Scan QR Code',
          'Total_balance_in ': '合計残高',
          'Tokens': 'トークン',
          'My_Assets': '私の資産',
          "attempts_remaining": "残りの試行回数",
          "Price": "価格",
          "Amount": "額",
          "buy_products": "製品を購入する",
          "token_transfer": "トークン転送",
          "secure_layer": "セキュア層",
          "discounted_products": "割引商品",
          "boarding_screen_tagline_1": "サポートされているストアから製品を購入し、MSQ ウォレットで支払います",
          "boarding_screen_tagline_2":
              "すべてのデジタル資産をシンプルかつ簡単に処理します。 ストア、転送、さらにはトレード。",
          "boarding_screen_tagline_3": "当社の MFA 認証システムにより、取引と資産管理を管理できます",
          "boarding_screen_tagline_4": "ポイントをためて、提携店でキャッシュバック",
          "transaction_history": "トランザクション履歴",
          "history_list_empty": "履歴リストが空です!",
          "create_id": "ユーザーIDの作成",
          "enter_user_id": "ウォレットのユーザー ID を入力してください",
          "user_id": "ユーザーID",
          "characters": "キャラクター",
          "first_must_be_lower": "最初の文字は小文字にする必要があります",
          "create_pass": "パスワードの作成",
          "pls_create_pass": "商標のパスワードを作成してください",
          "pass": "パスワード",
          "confirm_pass": "パスワードの確認",
          "must_include_upper_lower": "大文字と小文字を含める必要があります",
          "must_include_special": "特殊文字と数字を含める必要があります",
          "accept_pass_agreement": "パスワード紛失同意書に同意します",
          "next": "次",
          "pass_not_match": "パスワードが合わない",
          "want_to_logout": "ログアウトしますか？",
          "logout_msg": "戻ると、現在のユーザーがログアウトされます",
          "error_404": "ページが見つかりません",
          "error_500": "内部サーバーエラー",
          "error_502": "悪いゲートウェイ",
          "p2p_listings": "P2P リスティング",
          "Buying": "買う",
          "Selling": "売る",
          "Token": "トークン",
          "create_p2p_ad": "P2P 広告の作成",
          "listing_type": "出品タイプ",
          "create": "作成",
          "p2p_trade": "P2P取引",
          "you_sure": "本気ですか？",
          "really_sure": "トランザクションを続行してもよろしいですか",
          "close": "クローズ",
          "i_sure": "はい私は確信しています",
          "wallet_request": "ウォレット要求",
          "request_for_address_and_balance": "アドレスと残高をリクエストしました",
          "requested_by": "に要求された",
          "platform": "乗り場",
          "refuse": "拒否します",
          "accept": "受け入れる",
          "invalid_token_type": "無効なトークン タイプ",
          "max": "マックス",
          "reset": "リセット",
          "unlock_wallet": "本人確認",
          "scan_finger_to_connect": "指紋をスキャンしてトランザクションを確認します",
          "amount_swapped": "スワップされた金額",
          "scan_finger": "続行するには指をスキャンしてください",
          "use_password": "パスワードを使用",
          "pass_verify": "パスワード認証",
          "enter_pass": "パスワードを入力して ID を確認します",
          "wrong_password": "入力したパスワードが間違っています",
          "p2p_listings_empty": "P2P リスティングは空です",
          "cancel": "取消",
          "Buy": "買う",
          "Sell": "売る",
          "no_permission": "許可がない",
          "transaction_detail": "取引明細",
          "proceed_transaction": "この取引を続行しますか?",
          "wallet_address": "ウォレットの住所",
          "transaction_done": "取引はすでに完了しています。 別のQRコードをご利用ください。",
          "incorrect_password": "パスワードが正しくありません",
          "amount_not_swapped": "お財布にMATICが足りない",
          "transaction_unsuccessful": "トランザクションが失敗しました",
          "fingerprint_failed": "指紋認証に失敗しました",
          "sign_in_with": "でサインイン",
          "announcement": "発表",
          "nothing_to_show": "表示するものがありません",
          "to": "に",
          "from": "から",
          "out": "アウト",
          "in": "の",
          "wallet_termination": "MSQAURE ウォレットの終了",
          "please_enter_valid_amount": "有効な金額を入力してください",
          "you_have_created_an_ad": "広告を作成しました",
          "you_can_have_a_look_at_your_ad’s_on_your_listings_page":
              "リスティングページで広告を確認できます",
          "take_me_to_listings": "リストに移動",
          "cancel_ad_creating": "広告の作成をキャンセルしますか?",
          "if_you_choose_to_cancel": "キャンセルを選択すると、入力した詳細は失われます",
          "yes": "はい",
          "no": "番号",
          "your_order_has_been_placed": "ご注文が確定しました",
          "order_completed": "注文完了",
          "order_cannot_be_deleted": "注文を削除できません",
          "order_successfully_deleted": "注文が正常に削除されました",
          "wallet_termination_screen": "ウォレットの終了",
          "proceed_wallet_termination": "ウォレットの終了を続行するには、以下にパスワードを入力してください",
          "ok": "わかった",
          "invalid_password": "無効なパスワード",
          "wallet_termination_failed": "MSQ ウォレットの終了に失敗しましたMSQ ウォレットの終了に失敗しました",
          "wallet_successfully_terminated": "MSQ ウォレットが正常に終了しました",
          "or": "または",
          "swap": "スワップ",
          "exit_app": "アプリを終了",
          "exit_app_msg": "アプリを終了しますか?",
          "home": "家",
          "transaction_request": "取引依頼",
          "transaction_confirmed": "取引確認済み",
          "transaction_confirm_msg": "あなたの取引は正常に承認されました",
          "back_to_home": "ホームに戻る",
          "request_confirmation": "登録が完了しました",
          "request_confirmation_msg": "ウォレット アドレスが作成されました",
          "transaction_failed": "取引に失敗しました",
          "create_pass_agreement_title": "パスワード紛失の責任はユーザーにあります",
          "create_pass_agreement_label_1":
              "MSQUARE MARKET は、ブロックチェーン技術に基づく分散型ウォレットであり、ユーザーのパスワードを保存しません。",
          "create_pass_agreement_label_2":
              "パスワードの管理はユーザーの責任であり、パスワードを紛失した場合は復元できず、MSQUARE WALLET 内のすべてのデジタル資産にアクセスできなくなります。",
          "create_pass_agreement_label_3":
              "注: MSQUARE では、パスワードを紛失した場合に対応することはできません。 しばらくお待ちください。パスワードをメモ帳に保存してください。",
          "wallet_id_copied": "ウォレット アドレスがクリップボードにコピーされました",
          "total_amount": "合計金額",
          "contact_us_title": "どのようにお手伝いできますか?",
          "contact_us_msg": "ご不明な点や問題がございましたら、お気軽にお問い合わせください。",
          "error": "エラー",
          "message": "メッセージ",
          "send": "送信",
          "contact_us_error_1": "ご連絡いただきありがとうございます",
          "contact_us_error_2": "応答を取得できません。 もう一度やり直してください",
          "contact_us_error_3": "エラー値が空です",
          "contact_us_error_4": "メールの値が空です",
          "contact_us_error_5": "メッセージ値が空です",
          "contact_us_error_6": "無効なメールです! もう一度やり直してください",
          "null_value": "値を空にすることはできません",
          "not_enough_balance": "残高不足",
          "pass_limit_reached": "パスワード試行回数の上限に達しました。 5 分後にもう一度お試しください",
          "try_again_msg_1": "後に再試行",
          "try_again_msg_2": "分",
          "username_copied": "ユーザー名をクリップボードにコピーしました",
          "p2p_trading_msg": "デジタル資産を取引する",
          "resolve_errors": "エラーを修正してください",
          "not_enough_p2up": "ウォレットに十分な P2UP がありません",
          "not_enough_msq": "ウォレットに十分な MSQ がありません",
          "order_not_placed": "ご注文を承ることができませんでした。 再試行してください",
          "change_password": "パスワードを変更する",
          "confirm_change_password_1":
              "msquare ウォレット アカウントのパスワードを変更するには、本人確認を行ってください",
          "confirm_change_password_2": "ログイン後、取引に使用するパスワードを変更できます。",
          "current_password": "現在のパスワード",
          "new_password": "新しいパスワード",
          "confirm_new_password": "新しいパスワードを確認",
          "np_cp_not_match": "新しいパスワードと確認用パスワードが一致しません",
          "update_password": "パスワードを更新する",
          "pass_change_success": "パスワードは正常に変更されました",
          "pass_change_fail": "パスワードは変更されていません",
          "billing": "料金請求",
          "payment_method": "支払方法",
          "update_billing_details": "請求先の詳細と住所を更新する",
          "add_payment_method": "新しい支払い方法を追加",
          "email_address": "電子メールアドレス",
          "invoices_to_this_mail": "このメールアドレスに請求書が送信されます",
          "card_company": "カード会社",
          "select_your_card": "あなたのカードを選択してください",
          "login_id": "ログインID",
          "enter_login_id": "ログインIDを入力してください",
          "card_password": "カードパスワード",
          "enter_card_password": "カードパスワードを入力",
          "add_card": "カードを追加",
          "card_not_added": "カードが追加されませんでした",
          "card_added": "追加されたカード",
          "no_internet_connection": "インターネット接続なし",
          "retry": "再試行",
          "swap_token": "スワップトークン",
          "topup_credit": "トップアップ/クレジット",
          "internet_restored": "インターネットが回復しました"
        },
        'zh_CH': {
          "Fee": "费用",
          "Amount": "数量",
          "Price": "价格",
          "attempts_remaining": "其余的尝试",
          'in_progress': "进行中",
          "completed": "完全的",
          'fingerprint_popup': '输入密码以启用指纹认证',
          'copy_address': "复制地址",
          'disconnect': "断开",
          'hello': '你好',
          'welcome_back': '欢迎回来！',
          'trading': '贸易',
          'p2p_trading': 'P2P 贸易',
          'bank_transfer_paypal_and_more': '银行转账、Paypal 等',
          'coin_price': '硬币价格',
          'wallet': '钱包',
          'my_wallet': '我的钱包',
          'total_value': '总价值',
          'available_balances': '可用余额',
          'deposit': '订金',
          'withdraw': '提取',
          'transfer': '转移',
          'history': '历史',
          'sign_in_with_facebook': '用脸书登录',
          'sign_in_with_google': '用谷歌登录',
          'sign_in_with_apple': '用苹果登录',
          'welcome': '欢迎',
          'user_name': '用户名',
          'settings': '设置',
          'app_language': '应用语言',
          'privacy_settings': '隐私设置',
          'fingerprint_authentication': '指纹认证',
          'fingerprint_text': '使用您的指纹而不是密码来处理付款。密码选项仍然可用。',
          'other': '其他',
          'privacy_policy': '隐私政策',
          'terms_and_conditions': '条款和条件',
          'contact_us': '联系我们',
          'logout': '登出',
          'name': '姓名',
          'email': '电子邮件',
          'account': '帐户',
          'user_details': '用户详情',
          'scan_qr_code': 'Scan QR Code',
          'Total_balance_in ': '总余额',
          'Tokens': '代币',
          'My_Assets': '我的资产',
          "buy_products": "采购产品",
          "token_transfer": "代币转账",
          "secure_layer": "安全层",
          "discounted_products": "打折产品",
          "boarding_screen_tagline_1": "从我们支持的商店购买任何产品并使用您的 MSQ 钱包付款",
          "boarding_screen_tagline_2": "轻松处理您所有的数字资产。 储存、转移甚至交易。",
          "boarding_screen_tagline_3": "通过我们的 MFA 授权系统，您可以控制您的交易和资产管理",
          "boarding_screen_tagline_4": "赚取积分并将其用作我们附属商店的现金返还",
          "transaction_history": "交易历史",
          "history_list_empty": "您的历史列表为空！",
          "create_id": "创建用户 身份",
          "enter_user_id": "为您的钱包输入用户 身份",
          "user_id": "用户身份",
          "characters": "字符",
          "first_must_be_lower": "第一个字符必须小写",
          "create_pass": "创建密码",
          "pls_create_pass": "请创建商标密码",
          "pass": "口令",
          "confirm_pass": "确认密码",
          "must_include_upper_lower": "必须包含大写和小写字母",
          "must_include_special": "必须包含特殊字符和数字",
          "accept_pass_agreement": "我接受密码丢失协议",
          "next": "下一个",
          "pass_not_match": "密码不符",
          "want_to_logout": "是否要注销",
          "logout_msg": "返回将注销当前用户",
          "back_to_home_page": "回到主页",
          "error_404": "网页未找到",
          "error_500": "内部服务器错误",
          "error_502": "坏网关",
          "p2p_listings": "P2P 房源",
          "Buying": "购买",
          "Selling": "卖",
          "Token": "令牌",
          "create_p2p_ad": "创建 P2P 广告",
          "listing_type": "列表类型",
          "create": "创造",
          "p2p_trade": "P2P 交易",
          "you_sure": "你确定吗？",
          "really_sure": "您确定要继续进行交易吗",
          "close": "关",
          "i_sure": "是的，我确定",
          "wallet_request": "钱包请求",
          "request_for_address_and_balance": "要求提供地址和余额",
          "requested_by": "请求人",
          "platform": "平台",
          "refuse": "拒绝",
          "accept": "接受",
          "invalid_token_type": "无效的令牌类型",
          "max": "马克斯",
          "reset": "重置",
          "unlock_wallet": "确认你的身份",
          "scan_finger_to_connect": "扫描您的指纹以确认交易",
          "amount_swapped": "金额转换",
          "scan_finger": "扫描手指继续",
          "use_password": "使用密码",
          "pass_verify": "密码校验",
          "enter_pass": "输入密码确认身份",
          "wrong_password": "您输入的密码错误",
          "p2p_listings_empty": "P2P 列表为空",
          "cancel": "取消",
          "Buy": "购买",
          "Sell": "卖",
          "no_permission": "无权限",
          "transaction_detail": "交易详情",
          "proceed_transaction": "您要继续进行此交易吗？",
          "wallet_address": "钱包地址",
          "transaction_done": "交易已经完成。 请使用另一个二维码。",
          "incorrect_password": "不正确的密码",
          "amount_not_swapped": "您的钱包中没有足够的 MATIC",
          "transaction_unsuccessful": "交易不成功",
          "fingerprint_failed": "指纹认证失败",
          "sign_in_with": "登陆使用",
          "announcement": "公告",
          "nothing_to_show": "没有什么可展示的",
          "to": "至",
          "from": "从",
          "out": "出去",
          "in": "在",
          "wallet_termination": "MSQAURE 钱包终止",
          "please_enter_valid_amount": "请输入有效金额",
          "you_have_created_an_ad": "您制作了一个广告",
          "you_can_have_a_look_at_your_ad’s_on_your_listings_page":
              "您可以在列表页面上查看您的广告",
          "take_me_to_listings": "带我去清单",
          "cancel_ad_creating": "取消广告创建？",
          "if_you_choose_to_cancel": "如果您选择取消，您输入的详细信息将会丢失？",
          "yes": "是的",
          "no": "不",
          "your_order_has_been_placed": "您的订单已下达",
          "order_completed": "订单完成",
          "order_cannot_be_deleted": "订单无法删除",
          "order_successfully_deleted": "订单已成功删除",
          "wallet_termination_screen": "钱包终止",
          "proceed_wallet_termination": "为了继续终止钱包，请在下面输入密码",
          "ok": "好的",
          "invalid_password": "无效的密码",
          "wallet_termination_failed": "MSQ 钱包终止失败",
          "wallet_successfully_terminated": "MSQ 钱包成功终止MSQ 钱包成功终止",
          "or": "或",
          "swap": "掉换",
          "exit_app": "退出应用程序",
          "exit_app_msg": "你想退出应用程序吗？",
          "home": "家",
          "transaction_request": "交易请求",
          "transaction_confirmed": "交易确认",
          "transaction_confirm_msg": "您的交易已成功接受",
          "back_to_home": "返回首页",
          "request_confirmation": "注册完成",
          "request_confirmation_msg": "钱包地址已创建",
          "transaction_failed": "交易失败",
          "create_pass_agreement_title": "用户对密码丢失负责",
          "create_pass_agreement_label_1":
              "MSQUARE MARKET是一款基于区块链技术的去中心化钱包，不存储用户密码。",
          "create_pass_agreement_label_2":
              "用户自行负责密码管理，密码一旦丢失将无法找回，MSQUARE WALLET内所有数字资产将无法访问。",
          "create_pass_agreement_label_3":
              "注意：MSQUARE 无法帮助您解决密码丢失的问题。 请花点时间将密码保存在您的记事本上。",
          "wallet_id_copied": "钱包地址已被复制到剪贴板",
          "total_amount": "总金额",
          "contact_us_title": "我们该怎样帮助你？",
          "contact_us_msg": "如果您有任何疑问和问题，请与我们联系。",
          "error": "误差",
          "message": "讯息",
          "send": "发送",
          "contact_us_error_1": "感谢您联系我们",
          "contact_us_error_2": "无法得到您的回应。 请重试",
          "contact_us_error_3": "错误值为空",
          "contact_us_error_4": "邮箱值为空",
          "contact_us_error_5": "消息值为空",
          "contact_us_error_6": "电子邮件无效！ 请重试",
          "null_value": "值不能为空",
          "not_enough_balance": "不充足的资金",
          "pass_limit_reached": "已达到密码尝试次数上限。 5 分钟后重试",
          "try_again_msg_1": "再试一次 中",
          "try_again_msg_2": "分钟数",
          "username_copied": "用户名已复制到剪贴板",
          "p2p_trading_msg": "交易您的数字资产",
          "resolve_errors": "请修正错误",
          "not_enough_p2up": "您钱包中的 P2UP 不足",
          "not_enough_msq": "您钱包中的 MSQ 不足",
          "order_not_placed": "您的订单无法下达。 请再试一遍",
          "change_password": "更改密码",
          "confirm_change_password_1": "确认身份修改msquare钱包账户密码",
          "confirm_change_password_2": "在您登录后，您可以更改您用于交易的密码。",
          "current_password": "当前密码",
          "new_password": "新密码",
          "confirm_new_password": "确认新密码",
          "np_cp_not_match": "新密码和确认密码不匹配",
          "update_password": "更新密码",
          "pass_change_success": "密码更换成功",
          "pass_change_fail": "密码未更改",
          "billing": "计费",
          "payment_method": "付款方式",
          "update_billing_details": "更新您的帐单详细信息和地址",
          "add_payment_method": "添加新的付款方式",
          "email_address": "电子邮件地址",
          "invoices_to_this_mail": "发票将发送到此电子邮件",
          "card_company": "卡片公司",
          "select_your_card": "选择您的卡",
          "login_id": "登录ID",
          "enter_login_id": "输入您的登录 ID",
          "card_password": "信用卡密码",
          "enter_card_password": "输入银行卡密码",
          "add_card": "添加卡片",
          "card_not_added": "卡未添加",
          "card_added": "已添加卡片",
          "no_internet_connection": "没有网络连接",
          "retry": "重试",
          "swap_token": "交换令牌",
          "topup_credit": "充值/信用",
          "internet_restored": "互联网回来了"
        },
        'en_US': {
          "Fee": "Fee",
          "Amount": "Amount",
          "attempts_remaining": "attempts remaining",
          'in_progress': "In Progress",
          "completed": "Completed",
          'fingerprint_popup':
              "Enter Password to enable fingerprint authentication",
          'copy_address': "Copy Address",
          'disconnect': "Disconnect",
          'hello': 'Hello',
          'welcome_back': 'Welcome Back!',
          'trading': 'Trading',
          'p2p_trading': 'P2P Trading',
          'bank_transfer_paypal_and_more': 'Bank Transfer, Paypal and more',
          'coin_price': 'Coin Price',
          'wallet': 'Wallet',
          'my_wallet': 'My Wallet',
          'total_value': 'Total Value',
          'available_balances': 'Available Balance',
          'deposit': 'Deposit',
          'withdraw': 'Withdraw',
          'transfer': 'Transfer',
          'history': 'History',
          'sign_in_with_facebook': 'Sign in with Facebook',
          'sign_in_with_google': 'Sign in with Google',
          'sign_in_with_apple': 'Sign in with Apple',
          'welcome': 'Welcome',
          'user_name': 'Username',
          'settings': 'Settings',
          'app_language': 'My Language',
          'privacy_settings': 'Privacy Settings',
          'fingerprint_authentication': 'Fingerprint Authentication',
          'fingerprint_text':
              'Use your fingerprint to process payments instead of password. Password option will still be available.',
          'other': 'Other',
          'privacy_policy': 'Privacy Policy',
          'terms_and_conditions': 'Terms & Conditions',
          'contact_us': 'Contact Us',
          'logout': 'Logout',
          'name': 'Name',
          'email': 'Email',
          'account': 'Account',
          'user_details': 'User Details',
          'scan_qr_code': 'Scan QR Code',
          'My_Assets': 'My Assets',
          'Total_balance_in ': 'Total balance in',
          'Tokens': 'Tokens',
          "Price": "Price",
          "buy_products": "Buy Products",
          "token_transfer": "Token Transfer",
          "secure_layer": "Secure Layer",
          "discounted_products": "Discounted Products",
          "boarding_screen_tagline_1":
              "Buy any product from our supported stores and Pay with your MSQ Wallet",
          "boarding_screen_tagline_2":
              "Handle all your digital assets simple & easy. Store, Transfer & even Trade.",
          "boarding_screen_tagline_3":
              "With our MFA Auth System stay in control of your transactions and assets management",
          "boarding_screen_tagline_4":
              "Earn points and use them as cashbacks at  our affiliated stores",
          "transaction_history": "Transaction History",
          "history_list_empty": "Your History List is Empty!",
          "create_id": "Create User ID",
          "enter_user_id": "Enter user id for your wallet",
          "user_id": "User ID",
          "characters": "Characters",
          "first_must_be_lower": "First Character must be lowercase",
          "create_pass": "Create Password",
          "pls_create_pass": "Please Create Password for trademark.",
          "pass": "Password",
          "confirm_pass": "Confirm Password",
          "must_include_upper_lower":
              "Must include uppercase & lowercase letters",
          "must_include_special": "Must include special character & number",
          "accept_pass_agreement": "I accept Password loss agreement",
          "next": "Next",
          "pass_not_match": "Password does not match",
          "want_to_logout": "Do you want to logout",
          "logout_msg": "Going back will logout current",
          "back_to_home_page": "Back to Home Page",
          "error_404": "Page Not Found",
          "error_500": "Internal Server Error",
          "error_502": "Bad Gateway",
          "p2p_listings": "P2P Listings",
          "Buy": "Buy",
          "Sell": "Sell",
          "Token": "Token",
          "create_p2p_ad": "Create P2P Ad",
          "listing_type": "Listing Type",
          "create": "Create",
          "p2p_trade": "P2P Trade",
          "you_sure": "Are you sure?",
          "really_sure":
              "Are you sure you want to proceed with the transaction",
          "close": "Close",
          "i_sure": "Yes, I am sure",
          "wallet_request": "Wallet Request",
          "request_for_address_and_balance":
              "has requested for address & balance",
          "requested_by": "Requested by",
          "platform": "Platform",
          "refuse": "Refuse",
          "accept": "Accept",
          "invalid_token_type": "Invalid Token Type",
          "max": "Max",
          "reset": "Reset",
          "unlock_wallet": "Confirm your identity",
          "scan_finger_to_connect":
              "Scan your fingerprint to confirm transaction",
          "amount_swapped": "Amount Swapped",
          "scan_finger": "Scan finger to continue",
          "use_password": "Use Password",
          "pass_verify": "Password Verification",
          "enter_pass": "Enter Password to Confirm Identity",
          "wrong_password": "You have entered wrong password",
          "p2p_listings_empty": "P2P Listings are empty",
          "cancel": "Cancel",
          "no_permission": "No Permission",
          "transaction_detail": "Transaction Detail",
          "proceed_transaction":
              "Do you want to proceed with this transaction?",
          "wallet_address": "Wallet Address",
          "transaction_done":
              "Transaction already done. Kindly use another QR code.",
          "incorrect_password": "Incorrect Password",
          "amount_not_swapped": "You do not have enough MATIC in your wallet",
          "transaction_unsuccessful": "Transaction Not Successful",
          "fingerprint_failed": "Fingerprint Authentication Failed",
          "sign_in_with": "Sign in with",
          "announcement": "Announcement",
          "nothing_to_show": "Nothing to show",
          "to": "To",
          "from": "From",
          "out": "Out",
          "in": "In",
          "wallet_termination": "MSQAURE Wallet Termination",
          "please_enter_valid_amount": "Please enter valid amount",
          "you_have_created_an_ad": "You have created an ad",
          "you_can_have_a_look_at_your_ad’s_on_your_listings_page":
              "You can have a look at your ad’s on your listings page",
          "take_me_to_listings": "TAKE ME TO LISTINGS",
          "cancel_ad_creating": "Cancel Ad Creating?",
          "if_you_choose_to_cancel":
              "If you choose to cancel, the details you’ve entered will be lost",
          "yes": "Yes",
          "no": "No",
          "your_order_has_been_placed": "Your order has been placed",
          "order_completed": "Order Completed",
          "order_cannot_be_deleted": "Order Cannot be Deleted",
          "order_successfully_deleted": "Order Successfully Deleted",
          "wallet_termination_screen": "Wallet Termination",
          "proceed_wallet_termination":
              "In order to proceed with wallet termination, Enter the password below",
          "ok": "OK",
          "invalid_password": "Invalid Password",
          "wallet_termination_failed": "MSQ Wallet Termination Failed",
          "wallet_successfully_terminated":
              "MSQ Wallet Successfully terminated",
          "or": "OR",
          "swap": "Swap",
          "exit_app": "Exit App",
          "exit_app_msg": "Do you want to exi the app?",
          "home": "Home",
          "transaction_request": "Transaction Request",
          "transaction_confirmed": "Transaction Confirmed",
          "transaction_confirm_msg":
              "Your transaction is successfully accepted",
          "back_to_home": "Back to home",
          "request_confirmation": "Registration Complete",
          "request_confirmation_msg": "Wallet address has been created",
          "transaction_failed": "Transaction Failed",
          "create_pass_agreement_title":
              "User is responsible for password loss",
          "create_pass_agreement_label_1":
              "MSQUARE MARKET is a decentralized wallet based on blockchain technology and does not store users password.",
          "create_pass_agreement_label_2":
              "User is responsible for passwords management, passwords cannot be recovered in case of loss, and all digital assets in MSQUARE WALLET will not be available to access.",
          "create_pass_agreement_label_3":
              "Note: MSQUARE cannot help with the loss of password. Please take a moment and save the password on your notepad.",
          "wallet_id_copied": "Wallet Address has been copied to clipboard",
          "total_amount": "Total Amount",
          "contact_us_title": "How can we help you?",
          "contact_us_msg":
              "If you have any queries and problems, please get in touch with us.",
          "error": "error",
          "message": "message",
          "send": "Send",
          "contact_us_error_1": "Thank you for reaching us out",
          "contact_us_error_2": "Unable to get your response. Try again",
          "contact_us_error_3": "Error value is empty",
          "contact_us_error_4": "Email value is empty",
          "contact_us_error_5": "Message value is empty",
          "contact_us_error_6": "Invalid Email! Try again",
          "null_value": "The value can not be empty",
          "not_enough_balance": "Insufficient funds",
          "pass_limit_reached":
              "Password attempts limit reached. Try again after 5 minutes",
          "try_again_msg_1": "Try again after",
          "try_again_msg_2": "minute(s)",
          "username_copied": "User Name has been copied to clipboard",
          "p2p_trading_msg": "Trade your digital assets",
          "resolve_errors": "Resolve the errors",
          "not_enough_p2up": "Not enough P2UP in the wallet",
          "not_enough_msq": "Not enough MSQ in the wallet",
          "order_not_placed": "Your order cannot be placed. Please try again",
          "change_password": "Change Password",
          "confirm_change_password_1":
              "Confirm your identity to change the password of msquare wallet account",
          "confirm_change_password_2":
              "After you log in, you can change the password that you use for your transactions.",
          "current_password": "Current Password",
          "new_password": "New Password",
          "confirm_new_password": "Confirm New Password",
          "np_cp_not_match": "New Password and Confirm Password Does Not Match",
          "update_password": "Update Password",
          "pass_change_success": "Password Changed Successfully",
          "pass_change_fail": "Password Not Changed",
          "billing": "Billing",
          "payment_method": "Payment Method",
          "update_billing_details": "Update your billing details and address",
          "add_payment_method": "Add New Payment Method",
          "email_address": "Email Address",
          "invoices_to_this_mail": "Invoices will be sent to this email",
          "card_company": "Card Company",
          "select_your_card": "Select Your Card",
          "login_id": "Login ID",
          "enter_login_id": "Enter Your Login ID",
          "card_password": "Card Password",
          "enter_card_password": "Enter Card Password",
          "add_card": "Add Card",
          "card_not_added": "Card Not Added",
          "card_added": "Card Added",
          "no_internet_connection": "No Internet Connection",
          "retry": "Retry",
          "swap_token": "Swap Token",
          "topup_credit": "Topup/ Credit",
          "internet_restored": "Internet Restored"
        },
      };
}
