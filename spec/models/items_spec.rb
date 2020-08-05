require 'rails_helper'

describe Item do
  describe '#create' do
    it "is valid " do
      user = create(:user)
      category = create(:category)
      item  = build(:item)
      item.valid?
      expect(item).to be_valid
    end

    it "is valid without name " do
      user = build(:user)
      item = build(:item, user_id: user.id, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is valid without text " do
      user = build(:user)
      item = build(:item, user_id: user.id, text: "")
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "is valid without category_id " do
      user = build(:user)
      item = build(:item, user_id: user.id, category_id: nil)
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "is valid without condition_id " do
      user = build(:user)
      item = build(:item, user_id: user.id, condition_id: "")
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "is valid without postage_payer_id " do
      user = build(:user)
      item = build(:item, user_id: user.id, postage_payer_id: "")
      item.valid?
      expect(item.errors[:postage_payer_id]).to include("を入力してください")
    end

    it "is valid without prefecture_id " do
      user = build(:user)
      item = build(:item, user_id: user.id, prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("を入力してください")
    end

    it "is valid without preparation_id " do
      user = build(:user)
      item = build(:item, user_id: user.id, preparation_id: "")
      item.valid?
      expect(item.errors[:preparation_id]).to include("を入力してください")
    end

    it "is valid without price " do
      user = build(:user)
      item = build(:item, user_id: user.id, price: "")
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

    it "is valid without item_image " do
      item = build(:item)
      item_image = build(:item_image, item_id: item.id, image: "")
      item_image.valid?
      expect(item_image.errors[:image]).to include("を入力してください")
    end

    it "is invalid with a name that has more than 41 characters " do
      string = "a"
      user = create(:user)
      item = build(:item, user_id: user.id, name: "#{string * 41}")
      item.valid?
      expect(item.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "is valid with a name that has less than 40 characters " do
      string = "a"
      user = create(:user)
      category = create(:category)
      item = build(:item, user_id: user.id, name: "#{string * 40}")
      expect(item).to be_valid
    end

    it "is invalid with a text that has more than 1001 characters " do
      string = "a"
      user = create(:user)
      item = build(:item, user_id: user.id, text: "#{string * 1001}")
      item.valid?
      expect(item.errors[:text]).to include("は1000文字以内で入力してください")
    end

    it "is valid with a text that has less than 1000 characters " do
      string = "a"
      user = create(:user)
      category = create(:category)
      item = build(:item, user_id: user.id, text: "#{string * 1000}")
      expect(item).to be_valid
    end

    it "is invalid with a price that has greater_than_or_equal_to: ¥10000000 " do
      user = create(:user)
      item = build(:item, user_id: user.id, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("は9999999円以下にしてください")
    end

    it "is valid with price that has less_than_or_equal_to: ¥9999999 " do
      user = create(:user)
      item = build(:item, user_id: user.id, price: 9999999)
      expect(item).to be_valid
    end

    it "is invalid with price that has less_than_or_equal_to: 299 " do
      user = create(:user)
      item = build(:item, user_id: user.id, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("は300円以上にしてください")
    end

    it "is valid with price that has greater_than_or_equal_to: ¥300 " do
      user = create(:user)
      item = build(:item, user_id: user.id, price: 300)
      expect(item).to be_valid
    end

    it "is invalid with price that has not integer " do
      user = create(:user)
      item = build(:item, user_id: user.id, price: "hoge")
      item.valid?
      expect(item.errors[:price]).to include("は数値で入力してください")
    end

  end
end
