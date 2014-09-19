Sample Code 1
======

* Flyweight design pattern was used to skinny the controller
* Intermedate class was used to bridge between model and controller (bridge pattern)
* controller is clean no, there no business logic in controller
* controller is sharing the instance to view in truelly MVC style
* view get the enhance object  after it's passed through the flyweight/bridge/delagate design pattern processing.
* By applying flyweight design pattern it's only load the code when request cames to server. All the business proccessing is divided into N'tier pipeline layers
* hot standby security design pattern is implemented so that admin can
  easily disable/enable any beta module to specific person or group
