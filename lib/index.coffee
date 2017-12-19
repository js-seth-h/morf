_ = require 'lodash'

module.exports = exports =
  toJSON: (obj)->
    _toJSON = (json)->
      return _.map json, (v, k)->
        # Cond-Convert를 사용
        for cond, convert in evaluaters
          if cond k,v
            return convert k, v
        if v.toJSON?
          return v.toJSON()
        if _.isPlainObject v
          return _toJSON v
        return v 
    return _toJSON json


  toQueryString: (obj)->

  toObject: (json)->
    _toObject = (json)->
      for own k, v of json
        if _.endsWith k, '_datetime'
          obj[k] = new Date v
        else if _.isPlainObject v
          _toObject v
    return _toObject json
