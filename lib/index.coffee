_ = require 'lodash'



toJSON = (obj)->
  _toJSON = (obj, prepath, is_array)->
    mapper = _.mapValues
    mapper = _.map if is_array
    return mapper obj, (v, k)->
      for [cond, convert] in toJSON.morfer
        if cond v, k, prepath
          return convert v, k, prepath
      if _.isPlainObject v
        return _toJSON v, _.concat(prepath, k), false
      if _.isArray v
        return _toJSON v, _.concat(prepath, k), true
      return v
  return _toJSON obj, [], _.isArray obj

toJSON.morfer = []
toJSON.morfer.push [
  (v,k)-> v.toJSON?
  (v,k)-> v.toJSON()
]

toObject = (json)->
  _toObject = (json, prepath, is_array)->
    mapper = _.mapValues
    mapper = _.map if is_array
    return mapper json, (v, k)->
      for [cond, convert] in toObject.morfer
        if cond v, k, prepath
          return convert v, k, prepath
      if _.isPlainObject v
        return _toObject v, _.concat(prepath, k), false
      if _.isArray v
        return _toObject v, _.concat(prepath, k), true
      return v
  return _toObject json, [], _.isArray json

toObject.morfer = []
toObject.morfer.push [
  (v,k,prepath)->
    _.endsWith k, '_datetime'
  (v,k)-> new Date v
]


module.exports = exports =
  toJSON: toJSON
  toObject: toObject
