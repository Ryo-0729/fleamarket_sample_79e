class Category < ApplicationRecord
  has_many :items
  has_ancestry

  def set_items
    if root?
      start_id = self.root_id
      end_id = self.descendants.last.id
      items = Item.where(category_id: start_id..end_id)
      return items

    elsif children?
      start_id = self.id
      end_id = self.children.last.id
      items = Item.where(category_id: start_id..end_id)
      return items
      
    else
      return self.items
    end
  end
  
end
