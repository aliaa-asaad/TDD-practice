/* packages:

build runner:
- i need it with mokito to generate the mocks
- i put it in dev_dependencies because i need it only in the development phase

mockito:
- i need it to generate the mocks

 */
/* 
use this command:flutter pub run  build_runner build --delete-conflicting-outputs
to build mokito class for any class in GenerateMoks list aith the same methods in any class of them
and delete any duplicated testing class using build_runner package */

/*  to make the objects of the classes and inject it to the other classes as a parameter
 we use "get_it" package as a service locator and it helps in "dependency injection pattern" but in this project we didn't use it*/