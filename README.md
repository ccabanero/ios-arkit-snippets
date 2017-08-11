# ARKit Code Snippets

![logo](ARKit.jpg)

Various adventures using [ARKit](https://developer.apple.com/arkit/) - the Augmented Reality framework for iOS.

### Rotating Earth & Particle System of Stars

* Uses a custom 3D model of Earth created in [Blender](https://www.blender.org) (an open-source 3D modeling suite) using [NASA's Earth at Night imagery](https://www.nasa.gov/topics/earth/earthday/gall_earth_night.html) as a model texture.
* Adds the 3D model of Earth to the AR scene view.
* Rotates the 3D model of the Earth in the AR scene view.
* Adds a particle system to the AR scene view to simulate space.

Documentation of [Design steps are provided here](/doc_design_rotatinearth.md)

Documentation of [Development steps are provided here](/doc_development_rotatingearth.md)

<!-- 

### Touching Virtual Objects in an AR Scene
* Uses touch gesture to interact wiht 3D object.
* When touch intesects 3D object, a particle system is added to the scene.

### Touch Fire

* Gets location of touch gesture.
* Translate the screen space to 'world space'.
* Spawns a fire particle system at the touched location.

### Menu UI of Virtual Objects

* Creates a menu UI on top of the AR scene.
* When user chooses a menu item of a 3D object, it is added to the AR scene origin.

--> 
