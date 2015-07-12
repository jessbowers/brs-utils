'
' A roArray implementation with more functionality. Basically is a wrapper around
' a normal roArray and buArrayUtils. For example, instead of doing:
'   arr = [1,2,3,4]
'   buArrayUtils().toString(arr)
' You would do:
'   arr = buList([1,2,3,4])
'   arr.toString()
' @returns {Object} a buList
' @license MIT
'
function buList(data = [] as Object) as Object

    return {
        _data : data,

        push: function(element as Object) as Object
            m._data.push(element)
            return m
        end function,

        peek: function() as Dynamic
            return m._data.peek()
        end function,

        pop: function() as Dynamic
            return m._data.pop()
        end function,

        shift: function() as Dynamic
            return m._data.shift()
        end function,

        unshift: function(value as Dynamic) as Void
            m._data.unshift(value)
        end function,

        delete: function(index as Integer) as Boolean
            return m._data.delete(index)
        end function,

        count: function() as Integer
            return m._data.count()
        end function,

        clear: function() as Object
            m._data.clear()
            return m
        end function,

        append: function(array as Object) as Object
            m._data.append(array)
            return m
        end function,

        add: function(element as Object) as Object
            m._data.push(element)
            return m
        end function,

        remove: function(element as Object) as Boolean
            for i = 0 to m._data.count() - 1 step +1
                if m._data[i] = element then
                    return m._data.delete(i)
                end if
            end for
            return false
        end function,

        get: function(index as Integer) as Object
            if index >= 0 and index < m._data.count() then
               return m._data[index]
            end if
            return Invalid
        end function,

        contains: function(element as Object) as Boolean
            return buArrayUtils().contains(m._data, element)
        end function,

        ' Compares each element of the list with other. Only works with native types
        ' @param {buList} list - the list to compare against
        ' @returns {Boolean} One level deep equality
        equals: function(list as Object) as Boolean
            return buArrayUtils().equals(m._data, list._data)
        end function

        toString: function() as String
            return buStringUtils().toString(m._data)
        end function,

        isEmpty: function() as Boolean
            return buArrayUtils().isEmpty(m._data)
        end function,

        indexOf: function(element as Dynamic) as Integer
            return buArrayUtils().indexOf(m._data, element)
        end function,

        replace: function(index as Integer, element as Dynamic) as Dynamic
            return buArrayUtils().replace(m._data, index, element)
        end function,

        subList: function(startIndex as Integer, endIndex as Integer) as Dynamic
            return buList(buArrayUtils().subArray(m._data, startIndex, endIndex))
        end function,

        ' Applies the given filter function to each element of the list.
        ' @param {Function} func - the filter function to apply. It has to have
        ' the following signature: function(i, el) as Boolean
        ' @returns {buList} containing the elements filtered
        filter: function(func as Function) as Dynamic
            return buList(buArrayUtils().filter(m._data, func))
        end function

        ' Applies the given function to each element of the list.
        ' @param {Function} func - the function to apply. It has to have
        ' the following signature: function(i, el) as Dynamic
        ' @returns {buList} containing the elements with the function applied
        each: function(func as Function) as Object
            res = buList()
            for i = 0 to m._data.count() - 1 step +1
                el = m._data[i]
                res.add(func(i, el))
            end for

            return res
        end function
    }
end function
