# Validate/Test Against a Redis-backed Ruby Application

This is a simple application to validate and/or test your automation, your deploy process, whatever against a Ruby application backed by a [Redis](http://redis.io) datastore.

## Dependencies

| You Need | at least version... | for  |
| :------- | ------------------- | ---  |
| Ruby     | `2.3.1`             | application runtime |
| RubyGems | whatever ships with the above ruby version | installing/using gems | dependency access |
| Bundler  | `1.12.5`            | making gems under `vendor/cache` available to the app |
| Redis (server) | `3.2.0` (lower may work but didn't test w/ anything else) | storing data |

## Telling the app how to get to redis

Specify the environment variable `REDIS_URL` to tell the application where redis is located. This string should follow the format:

```
redis://<HOST>:<PORT>/<DB_NUMBER>
```

Where:

| Parameter | Means | Example |
| :-------- | :---- | :-----  |
| `<HOST>`  | Hostname or IP address where redis lives | `myredis.internal` or `10.1.1.14` |
| `<PORT>` | Numeric port where redis is bound on that host | `31337` |
| `<DB_NUMBER>` | Numeric DB number (pseudo-namespace) to use | `15` |

> What's the default redis port?

`6379`

> If I run it on default, do I need to specify the port?

*Technically no*, but let's not tempt fate; **specify it anyway**. Why leave anythign to chance when you don't have to?

> What's this DB_NUMBER business?

Redis supports this pseudo-namespace thing where each Redis installation on a given host has up to 16 (by default) separate databases; each can have a separate set of keys and values. By default, if you don't select one explicitly, it'll be set to `0` (zero) so I strongly suggest you set this parameter in `REDIS_URI`. If you want to know more about these databases, [the comments on the redis.io docs for SELECT](http://redis.io/commands/select) are actually quite enlightening.

> If I don't specify a DB_NUMBER, what happens?

God kills a kitten. Just kidding. (...or am I? *MUAHAHAHAHAHHAAHA!*)

Er, uhh, *Ahem*. Yes, the DB_NUMBER. Failure to specify this parameter (an integer between values of `0` and `15` by default, configurable in your Redis configuration) will default to the DB number/namespace of `zero (0)`. So if you have tests you run later, for example, that manipulate/purge/delete keys, and you fail to specify the number here, your real data will get messed up with your test data and may as well have just been [piped to /dev/null](http://mongodb.com).

> What about user/password?

Even though a simple authentication feature is supported with newer versions of Redis, this application **does not** support it or utilize it explicitly. 

> What's a sane default here?

```
redis://localhost:6379/1
```

> What about master/replica or redis cluster setups?

Not supported by this app right now. You *could* fudge it by sticking [haproxy](http://www.haproxy.org) on `localhost:6379` and blindly shuttling traffic between it and wherever the real redis installation lives, but that's honestly a hack, and frankly a rather ugly one.

