From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Feb 2015 14:47:49 +0000
Subject: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hey guys,

I needed a watchdog for my lager board to deploy some long-term tests. Also, a
working reboot command is so convenient :) I saw the DA9063 work from Geert
which seems to suffer from an unsolved mystery still. So, I took the liberty to
hack a driver for the RCLK watchdog. It works fine for me on my Lager board. I
will add support for the other RCar SoC in the next round, they are all the
same (according to docs, at least). Then, I'll also add binding documentation.
This is a "release early" series, so you can already comment if you wish. For
that reason, the watchdog list is not yet on CC. So, test if you like and
comment.

Happy hacking,

   Wolfram


Wolfram Sang (5):
  ARM: shmobile: r8a7790: add mstp4 and rwdt clock
  ARM: shmobile: r8a7790: add node for rwdt
  ARM: shmobile: r8a7790: lager: enable rwdt
  ARM: shmobile: r8a7790: let rst module allow watchdog resets if
    desired
  watchdog: sh_mobile: add driver

 arch/arm/boot/dts/r8a7790-lager.dts       |   4 +
 arch/arm/boot/dts/r8a7790.dtsi            |  17 +++
 arch/arm/mach-shmobile/setup-rcar-gen2.c  |  16 ++-
 drivers/watchdog/Kconfig                  |   8 ++
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/sh_mobile_wdt.c          | 182 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |   3 +
 7 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/watchdog/sh_mobile_wdt.c

-- 
2.1.4

