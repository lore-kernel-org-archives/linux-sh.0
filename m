From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 12 Oct 2015 06:54:31 +0000
Subject: [RFC v2 0/5] RCLK watchdog driver
Message-Id: <1444632876-2672-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Okay, here is my recent version of the RCLK watchdog driver. It still works for
me only in UP on a r8a7790 ES1 Lager Board. So, this is why it is RFC only. The
complete branch with DTS updates can be found in this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/wdt-on-4.3

I'll do another version with proper timeout handling. And then I'll investigate
what it needs to reuse this driver on r7s72100 Genmai. Maybe we can get this
driver upstream via this way.

Changes since last version:

* rebase to renesas-devel-20151008-v4.3-rc4
* populate timeout value for read
* use 0xffff to trigger reset
* properly populate parent device

Cheers,

   Wolfram


Wolfram Sang (5):
  ARM: shmobile: r8a7790: add mstp4 and rwdt clock
  ARM: shmobile: r8a7790: add node for rwdt
  ARM: shmobile: r8a7790: lager: enable rwdt
  ARM: shmobile: r8a7790: let rst module allow watchdog resets if
    desired
  watchdog: sh_mobile: add driver

 arch/arm/boot/dts/r8a7790-lager.dts       |   4 +
 arch/arm/boot/dts/r8a7790.dtsi            |  16 ++-
 arch/arm/mach-shmobile/setup-rcar-gen2.c  |  17 ++-
 drivers/watchdog/Kconfig                  |   8 ++
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/sh_mobile_wdt.c          | 187 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |   1 +
 7 files changed, 230 insertions(+), 4 deletions(-)
 create mode 100644 drivers/watchdog/sh_mobile_wdt.c

-- 
2.1.4

