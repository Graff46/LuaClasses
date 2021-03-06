local function noop() return end

function createClass(name, static)
  local model = {}
  local interface = {}
  
  interface.Init = noop
  interface.finalize = noop
  
  function _caller(obj, ...)
    for key, value in pairs(interface) do
      model[key] = value
    end
    obj:Init(...)
    --print "_caller"
    return model
  end
  
  function _finaliter(obj, ...)
    return obj:finalize(...)
    --print "_finaliter"
  end
  
  if static then
    setmetatable(model, {__gc = _finaliter})
    _G[name] = model
  else
    setmetatable(interface,
      {
        __call = _caller,
        __gc = _finaliter,
        __newindex = model
      })

    _G[name] = interface
  end
  
  return model, interface
end

function class(className, static)
  local signature, interface = createClass(className, static)

  return function(ParentClass) 
    for key, value in pairs(ParentClass or {}) do
      signature[key] = value
    end
    return interface
  end
end

function structure(className)
  return class(className, true)
end