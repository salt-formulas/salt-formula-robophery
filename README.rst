
=================
RoboPhery formula
=================

Python library for interfacing low level hardware sensors and actuators with MQTT bindings.


Sample pillars
==============

RoboPhery service with MQTT backend

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        module_default:
          input_backends:
          - messages
          output_backends:
          - messages
        backend:
          messages:
            engine: mqtt
            host: 127.0.0.1
            port: 1100

RoboPhery service with StatsD backend

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        module_default:
          output_backends:
          - metrics
        backend:
          metrics:
            engine: statsd
            host: 127.0.0.1
            port: 1100

RoboPhery service with filesystem backend

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        module_default:
          output_backends:
          - files
        backend:
          files:
            engine: filesystem
            path: /log

GPIO relay module

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        gpio_enabled: True
        module:
          light01:
            engine: gpio.relay
            port: 22

I2C HTU21 module

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        gpio_enabled: True
        module:
          livingroom01-env:
            engine: i2c.htu21
            bus: 1
            read_interval: 2000

BLE Parrot Flower Power module

.. code-block:: yaml

    robophery:
      server:
        enabled: true
        ble_enabled: True
        module:
          livingroom01-flower:
            engine: ble.flower_power
            addr: 00:11:22:33:44:55:66
            read_interval: 2000

Real-world robophery setup on raspberry pi, controlling relay module and
reading data from DHT22

.. code-block:: yaml

    robophery:
      server:
        name: ${linux:system:name}
        service: robophery
        dir:
          base: /opt/robophery
        log_level: debug
        log_handlers:
          - console
          - syslog
        read_interval: 10000
        publish_interval: 30000
        platform: raspberrypi
        communication:
          default_mqtt:
            host: mqtthost
            port: 1883
            class: robophery.comm.linux.mqtt.PahoMqttComm
        gpio_enabled: true
        interface:
          local_gpio:
            engine: gpio
            class: robophery.platform.rpi.gpio.RaspberryPiGpioInterface
        module:
          relay_in1:
            data:
              pin: 11
              iface: local_gpio
            invert_logic: true
            class: robophery.module.gpio.relay.RelayModule
          dht22:
            data:
              pin: 7
            class: robophery.module.gpio.dht22.Dht22Module

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
