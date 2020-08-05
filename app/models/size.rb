class Size < ActiveHash::Base
  self.data = [
      {id: 1, name: 'SSサイズ'}, {id: 2, name: 'Sサイズ'}, {id: 3, name: 'Mサイズ'},
      {id: 4, name: 'Lサイズ'}, {id: 5, name: '2Lサイズ'}, {id: 6, name: '3Lサイズ'},
      {id: 7, name: '別途記載'}, {id: 8, name: 'その他'}
    ]
end
