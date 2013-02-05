"use strict"


terms
  map: root

  resource:
    params:
      namespace: ['optional', 'function', 'baton']

  singleton:
    params:
      namespace: ['optional', 'function', 'baton', term: 'resource']
    precedes: ['resource']

  only:
    params:
      resource: ['baton']
    precedes: strict: ['resource']
