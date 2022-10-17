class Array
    def my_each(&blc)
        i = 0
        until i == self.length
            blc.call(self[i])
            i += 1
        end
        return self
    end
end

# return_value = [1, 2, 3].my_each do |num|
#     puts num
# end.my_each do |num|
#     puts num
# end

class Array
    def my_select(&blc)
        res = []
        self.my_each {|el| res << el if blc.call(el)}
        return res
    end
end

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

class Array
    def my_reject(&blc)
        res = []
        self.my_each {|el| res << el unless blc.call(el)}
        return res
    end
end

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

class Array
    def my_any?(&blc)
        self.my_each {|el| return true if blc.call(el)}
        return false
    end

    def my_all?(&blc)
        self.my_each {|el| return false unless blc.call(el)}
        return true
    end
end

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

class Array
    def my_flatten
        res = []
        self.each do |el|
            if el.kind_of?(Array)
                res += el.my_flatten
            else
                res << el
            end
        end
        return res
    end
end

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

class Array
    def my_zip(*args)
        res = []
        i = 0
        until i == self.length
            subres = []
            subres << self[i]
            args.my_each {|arr| subres << arr[i]}
            res << subres
            i += 1
        end
        return res
    end 
end

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

class Array
    def my_rotate(value=1)
        res = self.clone
        case sign = value > 0
        when true
            value.times {res.push(res.shift)}
        when false
            value = value.abs
            value.times {res.unshift(res.pop)}
        end
        return res
    end
end

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

class Array
    def my_join(sep="")
        res = ""
        i = 0
        until i == self.length-1
            res += self[i].to_s + sep
            i += 1
        end
        res += self[-1]
        return res
    end
end

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

class Array
    def my_reverse
        res = []
        i = -1
        until -1*i > self.length
            res << self[i]
            i -= 1
        end
        return res
    end
end

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

