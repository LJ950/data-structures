require './binary_tree.rb'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts tree.root.value
puts tree.root.right_child.value
puts tree.root.right_child.left_child.value
puts tree.root.right_child.left_child.right_child.value