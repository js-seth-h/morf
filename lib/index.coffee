_ = require 'lodash'

createMorf = ()->
  morfing = (input)->
    _morf = (input, prepath, is_array)->
      mapper = _.mapValues
      mapper = _.map if is_array
      return mapper input, (v, k)->
        for [cond, convert] in morfing.morfer
          if cond v, k, prepath
            return convert v, k, prepath
        if _.isPlainObject v
          return _morf v, _.concat(prepath, k), false
        if _.isArray v
          return _morf v, _.concat(prepath, k), true
        return v
    return _morf input, [], _.isArray input
  morfing.morfer = []
  return morfing

toJSON = createMorf()
toJSON.morfer.push [
  (v,k)-> v.toJSON?
  (v,k)-> v.toJSON()
]

toObject = createMorf()
toObject.morfer.push [
  (v,k,prepath)->
    _.endsWith k, '_datetime'
  (v,k)-> new Date v
]


module.exports = exports =
  create: createMorf
  toJSON: toJSON
  toObject: toObject
