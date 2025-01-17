# Delta Chat iOS Changelog

## v1.22.1

* fix: always reconnect if account creation was cancelled
* update translations


## v1.22.0

* added: connectivity view shows quota information, if supported by the provider
* fix account migration, updates are displayed instantly now
* fix forwarding mails containing only quotes
* fix ordering of some system messages
* fix handling of gmail labels
* fix connectivity display for outgoing messages
* fix acceping mailing lists
* fix drafts popping up as message bubbles
* fix connectivity info updates
* update translations and provider database


## v1.21.1 Testflight
2021-08

* fix: avoid possible data loss when the app was not closed gracefully before;
  this bug was introduced in 1.21.0 and not released outside testing groups -
  thanks to all testers!


## 1.21.0 Testflight
2021-07

* added: multi-account functionality: add and switch accounts from the settings
* added: every new "contact request" is shown as a separate chat now,
  you can block or accept or archive or pin them
  (old contact requests are available in "Archived Chats")
* added: the title bar shows if the app is not connected
* added: a tap in the title bar shows connectivity details (also available in settings)
* added: allow defining a video chat instance (eg. any jitsi instance)
* added: send video chat invites
* added: receive video chat invites as such
* added: offer a button for quick scrolling down in a chat
* deactivate and reactivate your own QR codes by just scanning them
* quotes can now refer messages from other chats
* do not show signature in "Saved Messages"
* revert sharing webp files as stickers
* fix date labels stuck in the seventies sometimes
* fix "show in chat"
* fix sharing issues
* fix: crash in gallery
* fix message input bar and share layout for iPad
* fix: keep keyboard open after cancelling drafts and quotes 
* fix displaying of small images
* fix more scrolling issues


## 1.20.5
2021-06

* show status/footer messages in contact profiles
* show stickers as such
* send memojis as stickers
* open chat at the first unread message
* fix downscaling images
* fix outgoing messages popping up in "Saved messages" for some providers
* fix: do not allow deleting contacts with ongoing chats
* fix: ignore drafts folder when scanning
* fix: scan folders also when inbox is not watched
* fix scrolling issues
* fix: not not stack chats on tapping notifications
* fix: show warning if camera access is denied
* fix: do not hide keyboard after sending a message
* fix: hide keyboard when tapping on a search result
* improve error handling and logging
* update translations, local help and provider database


## 1.20.4
2021-05

* fix: remove notifications if the corresponding chat is archived
* fix: less 0xdead10cc exceptions, mark background threads as such
* update translations


## 1.20.3
2021-05

* fix "show in chat" function in profile's gallery and document views
* fix: less 0xdead10cc exceptions in background
* update dependecies
* update translations


## 1.20.2
2021-05

* show total playback time of audio files before starting playback
* show location icon beside messages containing locations
* improve layout of delivery information inside bubbles
* fix: do not start location manager when location streaming is disabled
* fix: do not send read receipts when the screen is off
* fix: delete notifications if the corresponding chat is deleted
* fix: target backround issues
* fix crash when receiving some special messages                                
* fix downloading some messages multiple times                                  
* fix formatting of read receipt texts  
* update translations


## 1.20.0
2021-05

* opening the contact request chat marks all contact requests as noticed
  and removes the sticky hint from the chatlist
* if "Show classic mails" is enabled,
  the contact request hint in the corresponding chat
* speed up global search
* improve display of small images
* fix: filter contact list for adding members to verified groups
* fix: re-add headlines for every day
* fix: register for notifications also after qr-code account scanning
* fix a rare crash on chat deletion
* fix: update chat on forwarding to saved-messages
* fix: make links and default user actions work in contact requests
* add Chinese, French, Indonesian, Polish and Ukrainian local help, update other translations


## 1.19.1 Testflight
2021-04

* speed improvements
* fix a rare crash in chatlist


## 1.19.0 Testflight
2021-04

* show answers to generic support-addresses as info@company.com in context
* allow different sender for answers to support-addresses as info@company.com
* show multiple notifications
* group notifications by chats
* speed up chatlist update and global search
* improve detection of quotes
* improve background fetching
* ignore classical mails from spam-folder
* make log accessible on configure at "Log in to your Server / Advanced"
* fix showing configure errors
* add Czech translation, update other translations


## 1.17.1 Testflight
2021-03

* new mailinglist and better bot support
* more reliable notifications about every 20 minutes, typically faster
* tapping notification opens the corresponding chat
* more information and images shown in notifications
* add option to view original-/html-mails
* check all imap folders for new messages from time to time
* allow dialing on tapping a phone number
* use more colors for user avatars
* improve e-mail compatibility
* improve animations and scrolling
* improve compatibility with Outlook.com
  and other providers changing message headers
* scale avatars based on media_quality, fix avatar rotation
* export backups as .tar files
* enable strict TLS for known providers by default
* improve and harden secure join
* show warning for unsupported audio formats
* fix send button state after video draft has been added
* fix background crash
* fix read receipts
* fix decoding of attachment filenames
* fix: exclude muted chats from notified-list
* fix: do not return quoted messages from the trash chat
* much more bug fixes
* add Khmer, Persian, Arabic, Kurdish, Sardinian translations, update other translations
* add Czech local help, update other local help


## 1.16.0
2021-02

* new staging area: images and other files
  can be reviewed and sent together with a description now
* show in chat: go to the the corresponding message
  directly from images or documents in the gallery
* new, redesigned context menus in chat, gallery and document view -
  long-tap a message to feel the difference
* multi-select in chat: long-tap a message and select more messages
  for deletion or forwarding
* improve several accessibility items and texts
* improve keyboard layouts
* fix: profile images can now always be cropped after selection
* fix: hints in empty chats are no longer truncated
* fix swipe-to-reply icon for iOS 11 and 12
* more bug fixes
* update translations and local help


## 1.14.4
2020-12

* fix scrolling bug on ios 14.2
* update translations


## 1.14.3
2020-11

* fix bug that could lead to empty messages being sent
* update translations


## 1.14.2
2020-11

* fix issues when combining bubbles of the same sender
* update translations


## 1.14.1
2020-11

* new swipe-to-reply option
* show impact of the "Delete messages from server" option more clearly
* fix: do not fetch from INBOX if "Watch Inbox folder" is disabled
  and do not fetch messages arriving before re-enabling
* fix: do not use STARTTLS when PLAIN connection is requested
  and do not allow downgrade if STARTTLS is not available
* fix: make "nothing found" hints always visible
* fix: update selected avatars immediately
* update translations


## 1.14.0
2020-11

* disappearing messages: select for any chat the lifetime of the messages
* scroll chat to search result
* fast scrolling through all chat-messages by long tapping the scrollbar
* show quotes in messages as such
* add known contacts from the IMAP-server to the local addressbook on configure
* enable encryption in groups if preferred by the majority of recipients
  (previously, encryption was only enabled if everyone preferred it)
* speed up configuration
* try multiple servers from autoconfig
* check system clock and app date for common issues
* improve multi-device notification handling
* improve detection and handling of video and audio messages
* hide unused functions in "Saved messages" and "Device chat" profiles
* bypass some limits for maximum number of recipients
* add option to show encryption info for a contact
* fix launch if there is an ongoing process
* fix errors that are not shown during configuring
* fix mistakenly unarchived chats
* fix: tons of improvements affecting sending and receiving messages, see
  https://github.com/deltachat/deltachat-core-rust/blob/master/CHANGELOG.md
* update provider database and dependencies
* add Slovak translation, update other translations


## 1.12.3
2020-08

* allow importing backups in the upcoming .tar format
* remove X-Mailer debug header
* try various server domains on configuration
* improve guessing message types from extension
* improve member selection in verified groups
* fix threading in interaction with non-delta-clients
* fix showing unprotected subjects in encrypted messages
* more fixes, update provider database and dependencies


## 1.12.2
2020-08

* add last chats to share suggestions
* fix improvements for sending larger mails
* fix a crash related to muted chats
* fix incorrect dimensions sometimes reported for images
* improve linebreak-handling in HTML mails
* improve footer detection in plain text email
* fix deletion of multiple messages
* more bug fixes


## 1.12.0
2020-07

* use native camera, improve video recording
* streamline profile views and show the number of items
* option to enlarge profile image
* show a device message when the password was changed on the server
* show experimental disappearing-messags state in chat's title bar
* improve sending large messages and GIF messages
* improve receiving messages
* improve error handling when there is no network
* allow avatar deletion in profile and in groups
* fix gallery dark-mode
* fix login issue on ios 11
* more bug fixes


## 1.10.1
2020-07

* new launchscreen
* improve overall stability
* improve message processing
* disappearing messags added as an experimental feature


## 1.10.0
2020-06

* with this version, Delta Chat enters a whole new level of speed,
  messages will be downloaded and sent way faster -
  technically, this was introduced by using so called "async-processing"
* share images and other content from other apps to Delta Chat
* show animated GIF directly in chat
* reworked gallery and document view
* select outgoing media quality
* mute chats
* if a message cannot be delivered to a recipient
  and the server replies with an error report message,
  the error is shown beside the message itself in more cases
* default to "Strict TLS" for some known providers
* improve reconnection handling
* improve interaction with conventional email programs
  by showing better subjects
* improve adding group members
* fix landscape appearance
* fix issues with database locking
* fix importing addresses
* fix memory leaks
* more bug fixes


## v1.8.1
2020-05

* add option for automatic deletion of messages after a given timespan;
  messages can be deleted from device and/or server
* switch to ecc keys; ecc keys are much smaller and faster
  and safe traffic and time this way
* new welcome screen
* add an option to create an account by scanning a qr code, of course,
  this has to be supported by the used provider
* rework qr-code scanning: there is now one view with two tabs
* improve interaction with traditional mail clients
* improve avatar handling on ipad
* debug and log moved to "Settings / Advanced / View log"
* bug fixes
* add Indonesian translation, update other translations


## v1.3.0
2020-03-26

* add global search for chats, contacts, messages - just swipe down in the chatlist
* show padlock beside encrypted messages
* tweak checkmarks for "delivered" and "read by recipient"
* add option "Settings / Advanced / On-demand location streaming" -
  once enabled, you can share your location with all group members by
  taping on the "Attach" icon in a group
* add gallery-options to chat-profiles
* on forwarding, "Saved messages" will be always shown at the top of the list
* streamline confirmation dialogs on chat creation and on forwarding to "Saved messages"
* faster contact-suggestions, improved search for contacts
* improve interoperability eg. with Cyrus server
* fix group creation if group was created by non-delta clients
* fix showing replies from non-delta clients
* fix crash when using empty groups
* several other fixes
* update translations and help


## v1.2.1
2020-03-04

* on log in, for known providers, detailed information are shown if needed;
* in these cases, also the log in is faster
  as needed settings are available in-app
* save traffic: messages are downloaded only if really needed,
* chats can now be pinned so that they stay sticky atop of the chat list
* integrate the help to the app
  so that it is also available when the device is offline
* a 'setup contact' qr scan is now instant and works even when offline -
  the verification is done in background
* unified 'send message' option in all user profiles
* rework user and group profiles
* add options to manage keys at "Settings/Autocrypt/Advanced"
* fix updating names from incoming mails
* fix encryption to Ed25519 keys that will be used in one of the next releases
* several bug fixes, eg. on sending and receiving messages, see
  https://github.com/deltachat/deltachat-core-rust/blob/master/CHANGELOG.md#1250
  for details on that
* add Croatian and Esperanto translations, update other translations

The changes have been done by Alexander Krotov, Allan Nordhøy, Ampli-fier,
Angelo Fuchs, Andrei Guliaikin, Asiel Díaz Benítez, Besnik, Björn Petersen,
ButterflyOfFire, Calbasi, cloudieg, Dmitry Bogatov, dorheim, Emil Lefherz,
Enrico B., Ferhad Necef, Florian Bruhin, Floris Bruynooghe, Friedel Ziegelmayer,
Heimen Stoffels, Hocuri, Holger Krekel, Jikstra, Lin Miaoski, Moo, nayooti,
Nico de Haen, Ole Carlsen, Osoitz, Ozancan Karataş, Pablo, Paula Petersen,
Pedro Portela, polo lancien, Racer1, Simon Laux, solokot, Waldemar Stoczkowski,
Xosé M. Lamas, Zkdc


## v1.1.1
2020-02-02

* fix string shown on requesting permissions


## v1.1.0
2020-01-29

* add a document picker to allow sending files
* show video thumbnails
* support memoji and other images pasted from the clipboard
* improve image quality
* reduce traffic by combining read receipts and some other tweaks
* fix deleting messages from server
* add Korean, Serbian, Tamil, Telugu, Svedish and Bokmål translations
* several bug fixes


## v1.0.2
2020-01-09

* fix crashes on iPad


## v1.0.1
2020-01-07

* handle various qr-code formats
* allow creation of verified groups
* improve wordings on requesting permissions
* bug fixes


## v1.0.0
2019-12-23

Finally, after months of coding and fixing bugs, here it is:
Delta Chat for iOS 1.0 :)

* support for user avatars: select your profile image
  at "settings / my profile info"
  and it will be sent out to people you write to
* previously selected avatars will not be used automatically,
  you have to select a new avatar
* introduce a new "Device Chat" that informs the user about app changes
  and, in the future, problems on the device
* rename the "Me"-chat to "Saved messages",
  add a fresh icon and make it visible by default
* update translations
* bug fixes

The changes of this verison and the last beta versions have been done by
Alexander Krotov, Allan Nordhøy, Ampli-fier, Andrei Guliaikin,
Asiel Díaz Benítez, Besnik, Björn Petersen, ButterflyOfFire, Calbasi, cyBerta,
Daniel Boehrsi, Dmitry Bogatov, dorheim, Emil Lefherz, Enrico B., Ferhad Necef,
Florian Bruhin, Floris Bruynooghe, Friedel Ziegelmayer, Heimen Stoffels, Hocuri,
Holger Krekel, Jikstra, Lars-Magnus Skog, Lin Miaoski, Moo, Nico de Haen,
Ole Carlsen, Osoitz, Ozancan Karataş, Pablo, Pedro Portela, polo lancien,
Racer1, Simon Laux, solokot, Waldemar Stoczkowski, Xosé M. Lamas, Zkdc


## v0.960.0
2019-11-24

* allow picking a profile-image for yourself;
  the image will be sent to recipients in one of the next updates:
* streamline group-profile and advanced-loging-settings
* show 'Automatic' for unset advanced-login-settings
* show used settings below advanced-login-setting
* add global option to disable notifications
* update translations
* various bug fixes


## v0.950.0
2019-11-05

* move folder settings to account settings
* improve scanning of qr-codes
* update translations
* various bug fixes


## v0.940.2
2019-10-31

* add "dark mode" for all views
* if a message contains an email, this can be used to start a chat directly
* add "delete mails from server" options
  to "your profile info / password and account"
* add option to delete a single message
* if "show classic emails" is set to "all",
  emails pop up as contact requests directly in the chatlist
* update translations
* various bug fixes


## v0.930.0
2019-10-22

* add "send copy to self" switch
* play voice messages and other audio
* show descriptions for images, video and other files
* show correct delivery states
* show forwarded messages as such
* improve group editing
* show number of unread messages
* update translations
* various bug fixes


## v0.920.0
2019-10-10

* show text sent together with images or files
* improve onboarding error messages
* various bug fixes


## v0.910.0
2019-10-07

* after months of hard work, this release is finally
  based on the new rust-core that brings improved security and speed,
  solves build-problems and also makes future developments much easier.
  there is much more to tell on that than fitting reasonably in a changelog :)
* start writing a changelog
* hide bottom-bar in subsequent views
* fix a bug that makes port and other advaced settings unchangeable after login
* disable dark-mode in the chat view for now
* update translations

The changes have been done Alexander Krotov, Andrei Guliaikin,
Asiel Díaz Benítez, Besnik, Björn Petersen, Calbasi, cyBerta, Dmitry Bogatov,
dorheim, Enrico B., Ferhad Necef, Florian Bruhin, Floris Bruynooghe,
Friedel Ziegelmayer, Heimen Stoffels, Hocuri, Holger Krekel, Jikstra,
Jonas Reinsch, Lars-Magnus Skog, Lin Miaoski, Moo, nayooti, Ole Carlsen,
Osoitz, Ozancan Karataş, Pedro Portela, polo lancien, Racer1, Simon Laux,
solokot, Waldemar Stoczkowski, Zkdc  
