require 'rails_helper'

describe MemoMailer, type: :mailer do

  let(:memo) { FactoryBot.create(:memo, title: 'メイラーSpecを書く', description: '送信メール確認')}

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end

  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { MemoMailer.creation_email(memo)}

    it '想定通りのメールが生成されている' do
      #ヘッダ
      expect(mail.subject).to eq('メモ作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['memoapp@example.com'])

      # Text形式本文
      expect(text_body).to match('以下のメモを作成しました')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信メール確認')
      
      # html形式本文
      expect(html_body).to match('以下のメモを作成しました')
      expect(html_body).to match('メイラーSpecを書く')
      expect(html_body).to match('送信メール確認')
    end
  end
end