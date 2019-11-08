class MemoMailer < ApplicationMailer
  default from: 'memoapp@example.com'

  def creation_email(memo)
    @memo = memo
    mail(
      subject: 'メモ作成完了メール',
      to: 'user@example.com',
      from: 'memoapp@example.com',
    )
  end
end
