_ = require 'lodash'
chai = require 'chai'
expect = chai.expect
debug = require('debug')('test')

morf = require '..'
describe 'toObject;', ()->
  it 'geiven field name ends with "_datetime", then convert Date Type', (it_done)->
    obj = morf.toObject
      'recv_time': '12:12:13'
      'event_datetime': '2017-12-05T05:11:40.071Z'

    debug 'obj=', obj
    expect(obj.event_datetime).to.be.a 'date'

    it_done()

  it 'geiven array, then...', (it_done)->
    obj = morf.toObject
      opts: ['BT', 'WIFI']
      flags: [
        name: 'BT'
        'event_datetime': '2017-12-05T05:11:40.071Z'
      ,
        name: 'WIFI'
        'event_datetime': '2017-12-05T05:11:40.071Z'
      ]
      'title': 'test'

    debug 'obj=', obj
    expect(obj.flags[0].event_datetime).to.be.a 'date'

    it_done()

describe 'toJSON;', ()->
  it 'date type has toJSON  ,then convert Date Type', (it_done)->
    obj = morf.toJSON
      'recv_time': '12:12:13'
      'event_datetime': new Date '2017-12-05T05:11:40.071Z'

    debug 'obj=', obj
    expect(obj.event_datetime).eql '2017-12-05T05:11:40.071Z'

    it_done()


  it 'with morfer  ,then convert value', (it_done)->
    morf.toJSON.morfer.push [
      (v,k)->
        debug v, k, 'has _time?', _.endsWith k, '_time'
        _.endsWith k, '_time'
      (v,k)-> _.replace v, /:/gi, ''
    ]
    obj = morf.toJSON
      'recv_time': '12:12:13'
      'event_datetime': new Date '2017-12-05T05:11:40.071Z'

    debug 'obj=', obj
    expect(obj.recv_time).eql '121213'

    it_done()

  #
  # it 'geiven array, then...', (it_done)->
  #   obj = morf.toObject
  #     opts: ['BT', 'WIFI']
  #     flags: [
  #       name: 'BT'
  #       'event_datetime': '2017-12-05T05:11:40.071Z'
  #     ,
  #       name: 'WIFI'
  #       'event_datetime': '2017-12-05T05:11:40.071Z'
  #     ]
  #     'title': 'test'
  #
  #   debug 'obj=', obj
  #   expect(obj.flags[0].event_datetime).to.be.a 'date'
  #
  #   it_done()
