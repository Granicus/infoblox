## 2.0.1 - October 5 2016
* Add TTL support to CNAME record

## 2.0.0 - September 2 2016
Make WAPI version 2.0 the default version. 

## 1.0.1 - September 2 2016
A point release containing a bugfix and new field on a recod.

* Don't ask for ipv6addr in the return field for Ptr if the WAPI version is 1.0
* added 'view' attribute to zone_auth setter
* Fix json version for 1.8.7 

## 1.0.0 - August 15 2016
As implied, this release is a breaking change that modifies the default
behavior for SSL options, specifically by removing the "verify: false" behavior
and requireing the user to supply the configuration when creating an 
Infoblox::Connection.

* Add `ttl` support to the `Txt` record
* Remove `verify: false` from default SSL options
