class DPProblems
  attr_accessor :fib_cache, :cache
  def initialize
    @fib_cache = { 1 => 1, 2 => 1 }
    @cache = Hash.new { |hash, key| hash[key] = {} }
  end

  def fibonacci(n)
    result = fib_maker(n)
    @fib_cache = { 1 => 1, 2 => 1 }
    result
  end

  def fib_maker(n)
    return @fib_cache[n] if @fib_cache[n]
    next_sequence = fib_maker(n - 1) + fib_maker(n - 2)
    @fib_cache[n] = next_sequence
  end

  def make_change(amt, coins, memoization = { 0 => 0 })
    return memoization[amt] if memoization[amt]
    return Float::NAN if amt < coins[0]

    min_change = amt
    valid_change = false
    index = 0
    while index < coins.length && coins[index] <= amt
      num_change = 1 + make_change(amt - coins[index], coins, memoization)
      if num_change.is_a?(Integer)
        valid_change = true
        min_change = num_change if num_change < min_change
      end
      index += 1
    end

    memoization[amt] = valid_change ? min_change : Float::NAN
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    solution_table = knapsack_maker(weights, values, capacity)
    solution_table[capacity][weights.length - 1]
  end

  def knapsack_maker(weights, values, capacity)
    result = []
    (0..capacity).each do |i|
      result[i] = []
      (0..weights.length - 1).each do |j|
        if i == 0
          result[i][j] = 0
        elsif j == 0
          result[i][j] = weights[0] > i ? 0 : values[0]
        else
          option1 = result[i][j - 1]
          option2 = i < weights[j] ? 0 : result[i - weights[j]][j - 1] + values[j]
          max = [option1, option2].max
          result[i][j] = max
        end
      end
    end

    result
  end

  def stair_climb(n)
    possibilities = [[[]], [[1]], [[1, 1], [2]]]

    return possibilities[n] if n < 3

    (3..n).each do |i|
      paths = []
      (1..3).each do |first_step|
        possibilities[i - first_step].each do |way|
          new_way = [first_step]
          way.each do |step|
            new_way << step
          end
          paths << new_way
        end
      end
      possibilities << paths
    end

    possibilities.last
  end

  def str_distance(str1, str2)
    ans = str_distance_maker(str1, str2)
    @cache = Hash.new { |hash, key| hash[key] = {} }
    ans
  end

  def str_distance_maker(str1, str2)
    return @cache[str1][str2] if @cache[str1][str2]
    if str1 == str2
      @cache[str1][str2] = 0
      return 0
    end

    if str1.nil?
      return str2.length
    elsif str2.nil?
      return str1.length
    end

    len1 = str1.length
    len2 = str2.length
    if str1[0] == str2[0]
      dist = str_distance_maker(str1[1..len1], str2[1..len2])
      @cache[str1][str2] = dist
      return dist
    else
      poss1 = 1 + str_distance_maker(str1[1..len1], str2[1..len2])
      poss2 = 1 + str_distance_maker(str1, str2[1..len2])
      poss3 = 1 + str_distance_maker(str1[1..len1], str2)
      dist = [poss1, poss2, poss3].min
      @cache[str1][str2] = dist
      dist
    end
  end

  def maze_escape(maze, start)
    ans = maze_escape_maker(maze, start)
    @cache = Hash.new { |hash, key| hash[key] = {} }
    ans
  end

  def maze_escape_maker(maze, start)
    return @cache[start[0]][start[1]] if @cache[start[0]][start[1]]
    if (start[0] == 0 || start[1] == 0) || (start[0] == maze.length - 1 || start[1] == maze[0].length - 1)
      @cache[start[0]][start[1]] = 1
      return 1
    end

    y = start[0]
    x = start[1]
    adjacent = [[y + 1, x], [y - 1, x], [y, x + 1], [y, x - 1]]
    possible_moves = []
    adjacent.each do |y, x|
      if maze[y][x] == ' '
        possible_moves << [y, x]
      end
    end

    optimal_path = maze.length * maze[0].length
    way_found = false
    possible_moves.each do |move|
      temp = make_temp_maze(maze, start)
      ## recursive call to finish the possibilities
      possible_path = maze_escape_maker(temp, move)
      if possible_path.is_a?(Fixnum) && possible_path < optimal_path
        way_found = true
        optimal_path = possible_path
      end
    end

    ## record possible solution
    if way_found
      @cache[start[0]][start[1]] = optimal_path + 1
      return optimal_path + 1
    else
      @cache[start[0]][start[1]] = Float::NAN
      return Float::NAN
    end
  end

  def make_temp_maze(maze, filled_pos)
    temp = []
    maze.each_with_index do |row, i|
      temp << []
      maze[i].each do |el|
        temp[i] << el
      end
    end

    temp[filled_pos[0]][filled_pos[1]] = 'x'
    temp
  end
end
