# Anypic

Share your favorite moments.

## TestFlight Deployment Script

1. Copy PrivateTemplate.xcconfig into Private.xcconfig, and add your private TestFlight API key to this file.

2. Select Edit Scheme from the Scheme Drop Down menu in Xcode.

3. Choose the Archive step. Make sure it is pointing to the Ad Hoc Build Configuration.

4. Clicking on the arrow next to the Archive Step, select Post-actions and click on the + button to add a new Run Script.

5. Copy the contents of bin/adhocpostaction-testflight-upload.sh into this Run Script

6. Choose your Anypic target in "Provide build settings from", then hit OK

7. Choose iOS Device from the Scheme Drop Down Menu, then hit Build and Archive.

8. You will see a confirmation dialog asking if this build should be uploaded to TestFlight. Input any release notes, then sit back. The AnypicDev team will receive an email automatically.

You may tweak the above script to email different TestFlight Distribution Lists, or even to ask for confirmation for each step. Your TestFlight dashboard will launch after a successful upload, allowing you to manually authorize more testers for this build if necessary.
