class Game < ApplicationRecord
    belongs_to :user
    has_many :gachas
    has_many :charges
    has_many :stones

    validates :name, presence: true

    before_destroy :check_associated_records

    GAMES = {
        'アルファベット' => ['eFootball 2024', 'LINE:ディズニーツムツム', 'ONE PIECE バウンティラッシュ', 'Pokémon GO', 'Fate/Grand Order'],
        'あ行' => ['アークナイツ', 'アイドリッシュセブン', 'アイドルマスター シンデレラガールズ', 'あんさんぶるスターズ!!Music', 'ウマ娘 プリティーダービー'],
        'か行' => ['キノコ伝説：勇者と魔法のランプ', 'グランブルーファンタジー', '原神', '荒野行動'],
        'さ行' => ['呪術廻戦 ファントムパレード', '勝利の女神:NIKKE', '聖闘士星矢レジェンドオブジャスティス'],
        'た行' => ['ドラゴンクエストウォーク', 'ドラゴンボールZ ドッカンバトル'],
        'は行' => ['パズル&サバイバル', 'パズル&ドラゴンズ', 'ブルーアーカイブ', 'プロジェクトセカイカラフルステージ!feat.初音ミク', 'プロ野球スピリッツA', 'ヘブンバーンズレッド', '崩壊：スターレイル'],
        'ま行' => ['モンスターストライク', 'モンスターハンターNow'],
        'ら行' => ['ロイヤルマッチ']
    }.freeze


    private

    def check_associated_records
        if gachas.exists? || charges.exists? || stones.exists?
            errors.add(:base, '関連するデータが存在するため削除できません')
            throw(:abort)
        end
    end
end
