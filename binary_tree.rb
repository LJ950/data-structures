class Node
	attr_accessor :value, :parent_node, :left_child, :right_child
	def initialize(value=nil, parent_node=nil, left_child=nil, right_child=nil)
			@value = value
			@parent_node = parent_node
			@left_child = left_child
			@right_child = right_child
	end
end

class Tree
	attr_accessor :root
	def initialize(data)
		@root = Node.new(data.shift)
		build_tree(data)
	end

	def build_tree(data)
		data.each do |val|
			insert(val)
		end
	end

	def insert(val, current_node=@root)
		if val <= current_node.value
			if current_node.left_child != nil
				current_node = current_node.left_child
			else
				return current_node.left_child = Node.new(val, current_node)
			end
		end
		if val > current_node.value
			if current_node.right_child != nil
				current_node = current_node.right_child
			else
				return current_node.right_child = Node.new(val, current_node)
			end
		end
		insert(val, current_node)
	end

	def breadth_first_search(val)
		queue = [@root]
		i = 0
		while i < queue.size
			return queue[i].value if queue[i].value == val
			queue << queue[i].left_child unless queue[i].left_child == nil
			queue << queue[i].right_child unless queue[i].right_child == nil
			i += 1
		end
		puts "#{val} not found."
	end

	def depth_first_search(val)
		stack = [@root]
		while stack.size != 0
			current_node = stack.pop
			return current_node if current_node.value == val
			stack << current_node.right_child unless current_node.right_child == nil
			stack << current_node.left_child unless current_node.left_child == nil
		end
		puts "#{val} not found."
	end

	def dfs_rec(val,current_node=@root)
		return nil if current_node.nil?
		return current_node if current_node.value == val

		left_search = dfs_rec(val, current_node.left_child)
		return left_search unless left_search.nil?
		right_search = dfs_rec(val, current_node.right_child)
		return right_search unless right_search.nil?
	end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

puts tree.dfs_rec(67)