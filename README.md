# LuaClasses
## Uses:
class with constructor:
```lua
class "MyClass" (ParentClass)

function MyClass:Init()
 return self.value = math.random()
end

function MyClass:myMethod()
 return self.value
end
```
static class:
```lua
--variant 1
structure "MyClass" (ParentClass)

--variant 2

class ("MyClass", true) (ParentClass)

function MyClass:Init() -- not execute
 return self.value = math.random()
end

function MyClass:myMethod()
 return self.value -- nil
end
```
 (ParentClass) you don't have to write if you don't need it.

Possible so:
 ```lua
 class "MyClass" 
 
 structure "MyClass" 
 
 class ("MyClass", true)
```
Method-function "Init" it is constructor of class.

Method-function "finalize" it is destructor of class.
