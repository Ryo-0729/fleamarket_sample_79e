class ShippingMethod < ActiveHash::Base
  self.data = [
      {id: 1, name: 'ゆうゆうメルカリ便'}, {id: 2, name: 'ヤマト運輸'}, {id: 3, name: '日本郵便'},
      {id: 4, name: '佐川急便'}, {id: 5, name: 'その他（別途記載）'}
  ]
end
