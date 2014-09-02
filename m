From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 18:02:38 +0000
Subject: [PATCH 0/3] WIP: i2c slave support
Message-Id: <1409680961-12632-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I am currently working on the long standing issue of slave support for the I2C
framework. Here is a very rough first draft, so you can see what path I chose.
Three big things are still missing: documentation, a driver supporting the
hooks created here, and testing. So, this is more a draft how the interface
could look like and will soon get the details when I implement the support for
the i2c-rcar driver. If you want to comment, that is appreciated. However,
please focus on high-level comments, not implementation details. There is a lot
of sloppiness in the details, I do know. If they are still present in the first
real patches, then you can complain ;)

Since docs are still missing, here is a rough description: A software slave
driver is a standard I2C driver which will be matched against a standard I2C
client. The exception is that it requests a slave instance from its adapter via
i2c_slave_request() in probe. It provides a callback which will be invoked in
case events happen for this slave.

And again: This is a draft, up to now compile tested only.

Wolfram Sang (3):
  WIP: i2c core changes for slave support
  WIP: sketch of an slave-eeprom simulator
  WIP: adapt dts for i2c slave use

 arch/arm/boot/dts/r8a7790-lager.dts |  15 ++--
 drivers/i2c/i2c-core.c              |  42 +++++++++++
 drivers/i2c/i2c-slave-eeprom.c      | 140 ++++++++++++++++++++++++++++++++++++
 include/linux/i2c-slave.h           |  28 ++++++++
 include/linux/i2c.h                 |   5 ++
 5 files changed, 225 insertions(+), 5 deletions(-)
 create mode 100644 drivers/i2c/i2c-slave-eeprom.c
 create mode 100644 include/linux/i2c-slave.h

-- 
2.0.0

