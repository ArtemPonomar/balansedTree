class Leaf
  attr_accessor :value, :left, :right, :parent

  def initialize(value)
    @value = value
  end
end

class Tree
  @root = nil

  def add(value)
    if @root == nil
      @root = Leaf.new(value)
    else
      recursive_add(value, @root, nil)
    end
  end

  def delete(value)
    to_delete = find_leaf_with_value(value, @root)
    return if to_delete == nil
    if to_delete.right == nil && to_delete.left == nil
      delete_childless_leaf(to_delete)
    elsif to_delete.right != nil
      successor = to_delete.right
      until successor.left == nil && successor.right == nil
        if successor.left != nil
          successor = successor.left
        else
          successor = successor.right
        end
      end
      to_delete.value = successor.value
      delete_childless_leaf(successor)
    end
  end

  private

  def recursive_add(value, currentLeaf, fatherLeaf)
    if currentLeaf == nil
      currentLeaf = Leaf.new(value)
      currentLeaf.parent = fatherLeaf
    end
    if value >= currentLeaf.value
      recursive_add(value, currentLeaf.right, currentLeaf)
    else
      recursive_add(value, currentLeaf.left, currentLeaf)
    end
  end

  def find_leaf_with_value(value, current)
    return nil if current == nil
    if (current.value == value)
      return current
    elsif value >= current.value
      return find_leaf_with_value(value, current.right)
    else
      return find_leaf_with_value(value, current.left)
    end
  end

  def delete_childless_leaf(to_delete)
    to_delete.parent.left = nil if to_delete.parent.value > to_delete.value
    to_delete.parent.right = nil if to_delete.parent.value <= to_delete.value
  end
end