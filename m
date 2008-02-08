From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Fri, 08 Feb 2008 23:53:26 +0000
Subject: How can I test a joystick type device?
Message-Id: <1202514806.6237.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As below shows I think I have successfully ported the 2.4 Dreamcast
controller driver to 2.6 - but how can I test it? Is there a device I
should be looking for in /dev that I could just cat?

Sorry for the stupid question, but I'm at a loss on this one. :)


-bash-3.1# tree
.
|-- devices
|   |-- 0:00.1 -> ../../../devices/maple/0:00.1
|   `-- 1:00.40 -> ../../../devices/maple/1:00.40
|-- drivers
|   |-- Dreamcast_controller
|   |   |-- 0:00.1 -> ../../../../devices/maple/0:00.1
|   |   |-- bind
|   |   |-- uevent
|   |   `-- unbind
|   |-- Dreamcast_keyboard
|   |   |-- 1:00.40 -> ../../../../devices/maple/1:00.40
|   |   |-- bind
|   |   |-- uevent
|   |   `-- unbind
|   `-- maple_dummy_driver
|       |-- bind
|       |-- uevent
|       `-- unbind
|-- drivers_autoprobe
|-- drivers_probe
`-- uevent


