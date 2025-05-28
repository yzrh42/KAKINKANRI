class OmniauthCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :line
  def line
    # OmniAuthからの認証情報を取得
    auth = request.env['omniauth.auth']

    # 取得した認証情報に基づいてユーザーを検索または作成
    @user = User.from_omniauth(auth)

    if @user.persisted?
      # ユーザーが永続化（保存）されていればログイン成功
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: 'LINE') if is_navigational_format?
    else
      # ユーザーの保存に失敗した場合（例: バリデーションエラーなど）
      # セッションに認証情報を一時的に保存し、新規登録画面などにリダイレクト
      session['devise.line_data'] = auth.except('extra') # 'extra' は大きい場合があるので除外
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join(', ')
    end
  end

  def failure
    # 認証失敗時の処理
    redirect_to root_path, alert: 'LINEログインに失敗しました。'
  end
end