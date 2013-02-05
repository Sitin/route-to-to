"use strict"

{Router} = require './lib'
{map, read, write, only, resource, except, as, to, namespace, singleton} = new Router

map "user/:id", to "users#show"

match "customer/:id", to "customer#show"

map "posts", as resource # from 'conroller namespace X'

map "pages", as read only resource ->
  map "comments", as resource except "delete"

map "admin", to namespace ->
  map "/", to "admin#index"
  map "users", as resource
  map "app", as singleton resorce

map "cabinet", to "cabinet#index", ->
  map "pages", as resource