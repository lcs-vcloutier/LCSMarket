#  Implementing User Authentication and Cloud Data Storage

This project provides a starting point for apps that need to know who a user is and that need to save or download information from a web server.

## Overview

This project hides the complexity of handling user sign-in with multiple services.

`WelcomeView` is loaded when the application opens.

When the user has not authenticated sign-in buttons will be shown for Apple and Google authentication services.

Once the user has been authenticated `AuthenticatedView` will be shown.

Note that on `AuthenticatedView` you can assume that the user has been logged in. Be sure that you only load views, or provide navigation to views, that should be seen by an authenticated user.

Once logged in, the user's email address and name can be accessed through an instance of the `SharedAuthentication` type.

```
// Show user's name
Text(sharedAuthenticationStore.userName)
	.font(.title)

// Show user's email
Text(sharedAuthenticationStore.userEmail)
```

[View in Source](x-source-tag://accessing_user_details)

## User Authentication

A *sign-in provider* is a third-party service that allows users to authenticate to your application using an existing account they have created.

In this project, user authentication and sign-in is provided through Apple and Google frameworks.

### Configure Sign-In with Apple

To configure Sign-In with Apple, perform the following steps in Xcode:

1. On the Signing & Capabilities pane, [set the bundle ID][3] to a unique identifier (you must change the bundle ID to proceed).

2. On line 20 of the `Constants.swift` file, set the bundle ID to the unique identifier you used in the prior step.

[View in Source](x-source-tag://apple_bundle_identifer)

3. [Add your Apple ID account][4] and [assign the target to a team][5] so Xcode can enable the Sign in with Apple capability with your provisioning profile.

### Configure Sign-In with Google

1. Create an OAuth client ID. Do so by [visiting this page][8], logging in with your Google account, and then scrolling down and clicking the blue **Create an OAuth client ID** button. Follow the steps as prompted there and be sure to select appropriate, user-friendly names for the *Project* and *Product* names – these names will be seen by users when they use Google Sign-In from your app. When asked for your bundle ID, provide whatever you chose in step 1 of the *Configure Sign-In with Apple* section of this document. At the end of creating the OAuth client ID, you’ll be prompted to download a credentials file. Do that, and then add the credentials file to this Xcode project using drag and drop.

2. On line 13 of the `Constants.swift` file, set the client ID to the value assigned to you by Google. You can obtain this from the credentials file you just added to your project. Select the `credentials.plist` file. Copy the value for the CLIENT_ID key.

[View in Source](x-source-tag://google_client_id)

3. Open `credentials.plist` again. Locate the REVERSED_CLIENT_ID key. Copy the associated value. Now select the blue Xcode project file in the top left corner of the Project Navigator (⌘0). Follow [these four steps][9] and paste the reversed client ID in the URL Schemes field. This is necessary to allow the Google Sign-In process to redirect the user back to your app once sign-in is complete.

### Testing Sign-In with Apple

1. From the scheme pop-up menu, choose a run destination [that you are signed into with an Apple ID][10] and that [uses Two-Factor Authentication][6]. For example, an iPhone, connected to your computer, and [made ready for development][7]. 
2. In the toolbar, click Run, or choose Product > Run (⌘R). 

### Testing Sign-In with Google

 - Important: When using a Mac with Apple Silicon (M1 chip and later) you will need to [open Xcode using Rosetta][21] in order to compile this project. This is required because the Sign-In with Google framework still contains some Intel-specific code. To open Xcode with Rosetta, you can enable the necessary setting using the Get Info inspector: select Xcode in the Finder, then from the toolbar, choose File > Get Info (⌘I).

1. Google Sign-In can now be tested using the iOS simulator – choose an appropriate run destination. Since a custom URL scheme has been defined, a paid Apple developer account, or developer privileges within an organizational Apple Developer program, are required to deploy to an actual device.
2. In the toolbar, click Run, or choose Product > Run (⌘R). 

## Cloud Data Storage

Frameworks like *CloudKit* and *Firebase* provide significant functionality at the expense of complexity and time required for setup.

An alternative is the third-party [Sheety service][1]. Using nothing more than the standard `URLSession` class, and JSON encoding or decoding, you can both send data to and receive data from a Google Sheet of your own design.

### Configuring Sheety

When using the [Sheety][1] service, you must log in with a Google account.

Consider [creating and using a new Google account][11] that is separate from any existing Google account you may be using – when you connect Sheety, in order to do its job, the service requires permission to read the contents of any spreadsheet stored in your Google Drive.

Once you have logged in to Sheety, [create a new project][13].

You will need a spreadsheet to use. You may make a copy [of this exemplar][12], and modify it to suit your needs.

### Using Sheety

Each spreadsheet shared through Sheety is accessed via an endpoint.

The [exemplar][12] has [this endpoint][14].

View a [summary of the relationship between the spreadsheet and Swift data types][15].

To use Sheety in your own project, follow these steps.

1. Begin by defining a structure that matches the columns of the spreadsheet for a single row:

[View in Source](x-source-tag://spreadsheet_row_structure)

2. Then define a structure that maps to the entire spreadsheet:

[View in Source](x-source-tag://entire_spreadsheet_structure)

3. Be sure to update the endpoint in that structure to match the endpoint from your Sheety project:

[View in Source](x-source-tag://update_endpoint)

4. A class that is responsible for downloading rows from the spreadsheet is required:

[View in Source](x-source-tag://load_rows_from_spreadsheet)

5. Create a structure that represents a new row in the spreadsheet. This is used to send data to the endpoint:

[View in Source](x-source-tag://add_row_to_spreadsheet)

6. Finally, be sure that you [enable the ability to add rows to a spreadsheet through Sheety][16].

## Limitations

I am a [secondary school teacher][20] of Computer Science and Mathematics in Ontario, Canada.

This project was created as a starting point for use in projects authored by my own students.

I am no expert when it comes to authentication services or even programming with SwiftUI, which remains a very young framework.

Any errors contained within this project are my own. I welcome feedback, but please note that this project is provided without any guarantee of fitness for any particular purpose. See LICENSE.txt for further details.

*– Russell Gordon, April 2021*


## Acknowledgements

Some instructions within this document were adapted from the [Juice sample app][2] provided by Apple.

I first read about how to use Sign In with Apple from [this article by Tommy Prezioso][18].

Google Sign-In is currently built for UIKit, not SwiftUI. To understand how I could integrate Google's framework into an app, like this one, that uses the SwiftUI App Life Cycle, I consulted [this article by Peter Friese][17].

To initially learn how to use Google Sign-In as part of a SwiftUI project, I referred to [this article by Andrew Min][19].



[1]:https://sheety.co
[2]:https://developer.apple.com/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple
[3]:https://help.apple.com/xcode/mac/current/#/deve21d0239c
[4]:https://help.apple.com/xcode/mac/current/#/devaf282080a
[5]:https://help.apple.com/xcode/mac/current/#/dev23aab79b4
[6]:https://support.apple.com/en-us/HT204915
[7]:https://www.russellgordon.ca/tutorials/adding-a-physical-device-as-a-run-destination/
[8]:https://developers.google.com/identity/sign-in/ios/start-integrating
[9]:https://www.russellgordon.ca/AuthServicesExample/url-type.png
[10]:https://support.apple.com/en-us/HT204053
[11]:https://accounts.google.com/SignUp?hl=en
[12]:https://docs.google.com/spreadsheets/d/1RfBwIAdBu7DOSMsOwYJOvcC5o3i7E1z6mBV2ZkEfAjQ/edit?usp=sharing
[13]:https://dashboard.sheety.co/new
[14]:https://api.sheety.co/92d7eb80d996eaeb34616393ebc6ddcf/visitors/rows
[15]:https://www.russellgordon.ca/AuthServicesExample/sheety_summary.png
[16]:https://www.russellgordon.ca/AuthServicesExample/enable_add_row.png
[17]:https://medium.com/firebase-developers/firebase-and-the-new-swiftui-2-application-life-cycle-e568c9f744e9
[18]:https://swifttom.com/2020/09/28/how-to-add-sign-in-with-apple-to-a-swiftui-project/
[19]:https://medium.com/dev-genius/google-sign-in-with-swiftui-63f8e1deeae6
[20]:https://www.russellgordon.ca/about/
[21]:https://www.russellgordon.ca/AuthServicesExample/m1-use-rosetta.png
