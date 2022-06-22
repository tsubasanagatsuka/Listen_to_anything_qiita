class CreateQiitaApis < ActiveRecord::Migration[6.1]
  def change
    create_table :qiita_apis do |t|

      t.timestamps
    end
  end
end
