# autosms_client

Para configurar el servidor al que apuntará la aplicación, se deberá de dirigir al [fichero del servicio http](https://github.com/anescdev/autosms_client/blob/master/lib/services/http_services.dart#L23) y cambiar la url de baseURL por el host y el puerto que se haya elegido.
Una vez hecho esto se deberá compilar la aplicación usando
```Bash
flutter build apk --release
```
Importante obviamente tener instalado el Flutter SDK
