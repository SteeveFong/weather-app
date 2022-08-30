# Weather App

## What's implemented

- Forest design
- User geo localization
- Open weather map apis
- Architecture - MVVM
- Unit Testing
- CI / CD build pipeline with Fastlane (CD is not yet implemented)
- Code coverage
- Swiftlint
- Favorite weather locations
- Favorite weather list
- Some extra info about specific location (i.e city name)
- Google Places API
- Offline weather information (except time last updated)

## Notes

Regarding 5 days weather forecast api - https://openweathermap.org/forecast5, I think it would have been better to use https://openweathermap.org/forecast16 because forecast16 api provides daily forecast instead of 3 hour step forecast in forecast5 api. Currently I took the first 3 hour step forcast for each day which is not ideal.

For now I committed my API secret keys for easier build. But, ideally the plist file should be ignored in git and that way API keys stay locally only.

## Future improvements

- Create more custom Errors from WeatherError
- More code coverage
- Add map to visualize weather locations
- Design enhancements
- Fix code coverage report
- Integrate swiftlint to CI / CD pipeline
- Static code analysis
- Show last time updated for offline mode
