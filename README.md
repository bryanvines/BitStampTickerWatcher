BitStampTickerWatcher
=====================

A small app which monitors the current Bitcoin valuation from BitStamp (https://www.bitstamp.net)

The application is functional, and checks BitStamp's API every two seconds for updates.

On the to-do list:
  - Use SCNetworkReacability to determine whether a connection is available.
  - Add preference to allow user to change BitStamp's ticker URL, in case BitStamp ever moves the service.
  - Add preference to allow user to change update interval. This value should not be less than 1 second to avoid running afoul of BitStamp's request limit. 
