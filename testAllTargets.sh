xcodebuild test -workspace Domoticz.xcworkspace -scheme 'DomoticzSwift'
if [ $? -ne 0 ]
then
  echo "Test FAILED"
  exit 1
fi
xcodebuild test ARCHS=x86_64 only_active_arch=yes -workspace Domoticz.xcworkspace -scheme 'DomoticzIOS' -destination "platform=iOS Simulator,name=iPhone 12 mini"
if [ $? -ne 0 ]
then
  echo "Test FAILED"
  exit 1
fi
xcodebuild test -workspace Domoticz.xcworkspace -scheme 'DomoticzWatchTests' -destination "platform=iOS Simulator,name=iPhone 12 mini"
if [ $? -ne 0 ]
then
  echo "Test FAILED"
  exit 1
fi
xcodebuild test -workspace Domoticz.xcworkspace -scheme 'DomoticzMac'
if [ $? -ne 0 ]
then
  echo "Test FAILED"
  exit 1
fi
xcodebuild test -workspace Domoticz.xcworkspace -scheme 'DomoticzTV' -destination "platform=tvOS Simulator,name=Apple TV"
