# fenix_flutter

Proyecto que se conecta a una API para poder manejar dispositivos

## Para empezar

Antes de ejecutar la aplicacion tienes que cambiar las rutas de la clase device_service.dart
Ejemplo:
"http://192.168.0.9:8080/devices" => "http://tu.ip:8080/devices"

## Funcionamiento

La aplicación se puede ejecutar tanto en movil como en web, 
una vez autentificado con las credenciales usuario = prueba@prueba.com contraseña = usuario
accederas a la lista de dispositivos, en ella tendras un componente personalizado por cada 
dispositivo existente y un botón flotante que te permitirá añadir más dispositivos.
El componente será un botón el cual te mostrará los detalles del dispositivo al pulsarlo y 
una opción para actualizar los datos, el componente tendrá a la derecha el icono de una papelera 
que permitirá eliminar ese dispositivo