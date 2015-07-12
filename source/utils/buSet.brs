'
' A very simplistic Set implementation. Very hard to implement
' without object hashes. Only works with BrightScript primitives
' @returns {Object} a buSet
' @license MIT
' @functions
' * add
' * remove
' * get
' * contains
' * count
' * equals
' * toString
' * filter
' * each
function buSet(data = [] as Object) as Object

    set = {
        _data : [],

        add: function(element as Object) as Boolean
           if not m.contains(element) then
                m._data.push(element)
                return true
            end if
            return false
        end function,

        remove: function(element as Object) as Boolean
            for i = 0 to m._data.count() - 1 step +1
                if m._data[i] = element then
                    return m._data.delete(i)
                end if
            end for
            return false
        end function,

        contains: function(element as Object) as Boolean
            return buArrayUtils().contains(m._data, element)
        end function,

        get: function(index as Integer) as Object
            if index >= 0 and index < m._data.count() then
               return m._data[index]
            end if
            return Invalid
        end function,

        count: function() as Integer
            return m._data.count()
        end function,

        ' Compares each element of the set with other. Only works with native types
        ' @param {buSet} set - the set to compare against
        ' @returns {Boolean} One level deep equality
        equals: function(set as Object) as Boolean
            return buArrayUtils().equals(m._data, set._data)
        end function

        ' Converts a set to String like "[1,2,3]"
        ' @returns {String} set converted to string
        toString: function() as String
            return buStringUtils().toString(m._data)
        end function,

        ' Applies the given filter function to each element of the set.
        ' @param {Function} func - the filter function to apply. It has to have
        ' the following signature: function(i, el) as Boolean
        ' @returns {buSet} containing the elements filtered
        filter: function(func as Function) as Dynamic
            return buSet(buArrayUtils().filter(m._data, func))
        end function

        ' Applies the given function to each element of the set.
        ' @param {Function} func - the function to apply. It has to have
        ' the following signature: function(i, el) as Dynamic
        ' @returns {buSet} containing the elements with the function applied
        each: function(func as Function) as Object
            res = buSet()
            for i = 0 to m._data.count() - 1 step +1
                el = m._data[i]
                res.add(func(i, el))
            end for

            return res
        end function
    }

    for each el in data
        set.add(el)
    end for

    return set
end function
