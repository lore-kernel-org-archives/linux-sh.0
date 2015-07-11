From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 11 Jul 2015 07:46:21 +0000
Subject: [PATCH v2 0/5] enable I2C on Renesas EMEV2 and KZM9D board
Message-Id: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Ian Molton <ian.molton@codethink.co.uk>

So, I picked up the old series from Ian and reworked it significantly. While
his series was already an improvement from the driver found in the BSP, it was
still not ready for upstream. It should be now :) My idea was to start simple
and improve incrementally, so e.g. clock handling was broken, so clocks are
always on for starters. Major changes include:

* clock handling simplified and adapted to current EMEV clock handling
* switch from wait_event to completion mechanism. The old one was basically
  some kind of completion with custom code around wait_events
* dropped using signals; they always cause trouble with I2C
* simplified the bus free logic. If it turns out to be too simple, we'd need
  to switch to the bus_recovery infrastructure probably. But we'd need a test
  case for that
* error handling improved to match subsystem standards
* removed some BSP angst code
* lots of refactoring to make code simpler, more readable...
* bugfixes

I also added all the glue code to add clocks, disable reset etc which was
missing before. I'd prefer to take the first three patches via i2c myself,
and the latter two via Simon's tree.

Since V1, there are minor updates fixing issues found in reviews. Thanks!

A branch for testing can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/emma-i2c

Please test, comment...

Thanks!

   Wolfram

Wolfram Sang (5):
  clk: shmobile: emev2: deassert reset for IIC0/1
  i2c: emev2: add binding documentation
  i2c: emev2: add driver
  ARM: shmobile: emev2: add IIC cores to dtsi
  ARM: shmobile: emev2: kzm9d: enable IIC busses

 .../devicetree/bindings/i2c/i2c-emev2.txt          |  22 ++
 arch/arm/boot/dts/emev2-kzm9d.dts                  |   8 +
 arch/arm/boot/dts/emev2.dtsi                       |  48 +++
 drivers/clk/shmobile/clk-emev2.c                   |   6 +
 drivers/i2c/busses/Kconfig                         |   7 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-emev2.c                     | 333 +++++++++++++++++++++
 7 files changed, 425 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-emev2.txt
 create mode 100644 drivers/i2c/busses/i2c-emev2.c

-- 
2.1.4

