
Приложение  - "Прогноз погоды".
-
При первом запуске приложения, приходит запрос на разрешение использования геолокации.
На основании геолокации пользователя отправляется запрос на получение прогноза погоды.
Иноформация приходит через API почасовая на ближайшие 24 часа и на ближайшие 7 дней, затем сетится в UICollectionView и UITableView.
В зависимости от того, какая сейчас погода - меняется фоновая картинка MainView на главном экране.
Так же фоновая картинка зависит от условий: день сейчас или ночь.
Благодаря поиску можно найти и выбрать любой город, и получить прогноз погоды для этого города.

Архитектура - VIPER. 
UIKit, NukeExtensions, SnapKit, CoreLocation, SwiftLint.

------------------------------------------------------------------------------------------------------------------------------------------------------

Application - "Forecast weather".
-
When you first launch the application, you will be prompted to allow the use of geolocation.
Based on geolocation, the user sends a request to receive a weather forecast.
The information comes through the API 24/7 and then connects to the UICollectionView and UITableView.
Depending on what the weather is like now, the MainView background image on the main screen changes.
Also, the background image depends on the conditions: it is day or night.
Thanks to the search, you can find and select any city, and get the weather forecast for that city.

Architecture - VIPER. 
UIKit, NukeExtensions, SnapKit, CoreLocation, SwiftLint.

------------------------------------------------------------------------------------------------------------------------------------------------------
<div style="display: flex;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/1.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/2.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/3.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/4.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/5.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/6.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/7.png" width="200" style="margin-right: 10px;">
    <img src="https://github.com/DrozdD-ios-dev/Weather-API/blob/main/Weather/Resousces/AssetsForREADME%20/8.png" width="200">
</div>
