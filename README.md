# Council app #
(Searching for a better name)

The goal of this application is to improve how we do group decision making in our communities.
Instead of just digitizing current voting practices and moving them online, without much added value,
this project aims to explore and improve technologies we use for decision making. Some current ideas:
* support for communities which meet offline, but want to use online tools to augment their decision making
* tools for better facilitation of discussions
* score voting for better multiple-choices decision making
* dynamic statistical quorum
* vote delegation
* visual feedback on decision making process and progress

The project is in very early stages. Any feedback is welcome.

## Development ##

The application uses [Meteor](https://www.meteor.com/) web framework. Install it:

```bash
curl https://install.meteor.com/ | sh
```

Clone the repository:

```bash
git clone --recursive https://github.com/mitar/council-app.git
```

Run it:

```bash
meteor
```

And open [http://localhost:3000/](http://localhost:3000/).

Currently you will have to manually create accounts using `meteor shell`:

```javascript
var userId = Package['accounts-base'].Accounts.createUser({username: 'admin', password: 'password'});
Package['alanning:roles'].Roles.addUsersToRoles(userId, ['admin', 'moderator', 'manager', 'member']);
```

## Related projects ##

* https://www.loomio.org/
* http://democracyos.org/ 