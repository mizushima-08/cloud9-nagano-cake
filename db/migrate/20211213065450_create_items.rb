class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_id
      t.text :introduction
      t.integer :price
    # 商品の有効/無効 TRUE =販売中 FALSE =販売停止中 初期では無効設定
      t.boolean :is_active, default: true, null: false
      t.integer :genre_id
      t.timestamps
    end
  end
end
