## 1.0.0 - 8/15/2016
As implied, this release is a breaking change that modifies the default
behavior for SSL options, specifically by removing the "verify: false" behavior
and requireing the user to supply the configuration when creating an 
Infoblox::Connection.

* Add `ttl` support to the `Txt` record
* Remove `verify: false` from default SSL options
