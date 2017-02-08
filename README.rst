
=================
RoboPhery formula
=================

Python library for interfacing low level hardware sensors and actuators with MQTT bindings.

Sample pillars
==============

Single robophery service

.. code-block:: yaml

    robophery:
      service:
        enabled: true
        platform: rpi/bbb/micro
        debug: False
        output_interval: 60
        output_backends:
        - messages
        - metrics
        - files
        output:
          messages:
            engine: mqtt
            host: 127.0.0.1
            port: 1100
          metrics:
            engine: statsd
            host: 127.0.0.1
            port: 1100
          files:
            path: /log
        module:
          light01:
            engine: gpio.relay
            port: 22
          livingroom01-env:
            engine: i2c.htu21
            bus: 1
            read_interval: 1


Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-robophery/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-robophery

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
