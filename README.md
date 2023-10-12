# WeatherAlertApp
Single screen iOS weather alerts app using Swift, UIKit.

Assignment task:
- you can obtain the data by performing a GET request to https://api.weather.gov/alerts/active?status=actual&message_type=alert
- more official documentation is available at https://www.weather.gov/documentation/services-web-api#/default/get_alerts_active
- each cell should contain the following details of an alert:
    - event name "event", start date "effective", end date "ends", source "senderName" & duration (start date - end date)
    - a unique random image obtained by a GET to https://picsum.photos/1000
    - each cell must show a different image, but keep showing its original image when you scroll back to it
