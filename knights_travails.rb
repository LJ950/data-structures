class Knight
	attr_accessor :location, :parent, :child
	def initialize (location, parent=nil, child=[])
		@location = location
		@child = child
		@parent = parent
	end
end

class KnightMoves
	def initialize(start, finish)
		@start = start
		@finish = finish
		@root = Knight.new(@start)
		build_tree
	end

	def possible_moves(knight=@root,visited)
		knights = []
		count = 0
		current_square = knight.location
		h = current_square[0]
		v = current_square[1]
		moves = [h+1,v+2],[h+2,v+1],[h+2,v-1],[h+1,v-2],[h-1,v-2],
		[h-2,v-1],[h-2,v+1],[h-1,v+2]

		moves.each do |loc|
			unless loc[0] < 0 || loc[1] < 0 || loc[0] > 7 || loc[1] > 7 || visited.include?(loc)
				knight.child[count] = Knight.new(loc,knight)
				unless knight.child[count].location == knight.location
					knights << knight.child[count]
					count += 1
				end
			end
		end
		knights
	end

	def build_tree(knight=@root, visited=[@start],queue=[])
		children = possible_moves(knight,visited)
		found = false		
		children.each do |knight|
			if knight.location == @finish
				found = true
				break
			end
			visited	<< knight.location
			queue << knight
		end

		return if found == true
		build_tree(queue.shift,visited,queue)
	end

	def search
		queue = [@root]
		results = []
		i = 0
		while i < queue.size
			queue.each { |knight|	results << knight } if queue[i].location == @finish
			queue[i].child.each { |child| queue << child }
			i += 1
		end

		results.each { |knight|	return knight if knight.location == @finish }
	end

	def build_path(current_knight=search, path=[])
		return path.reverse!.unshift(@start) if current_knight.location == @start
		path << current_knight.location
		current_knight = current_knight.parent
		build_path(current_knight,path)
	end
end

def knight_moves(start,finish)
	knight = KnightMoves.new(start,finish).build_path
	puts "You made it in #{knight.size-1} moves! Here's your path:"
	knight.each { |k| p k }
end

knight_moves([3,3],[4,3])