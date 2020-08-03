class Category < ApplicationRecord
  has_many :items
  has_ancestry

  def set_items
    if self.root?
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      items = Item.where(category_id: start_id..end_id)
      return items

    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      items = Item.where(category_id: start_id..end_id)
      return items
    else
      return self.items
    end
  end

end
