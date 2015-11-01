From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Nov 2015 19:19:34 +0000
Subject: [RFC v3 0/5] RCLK watchdog driver
Message-Id: <1446405579-5367-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Okay, a little bit rushed, but I wanted to deliver this version before next week
starts. This one still has the Lager patches, which are only for testing(!) and
not meant to be upstreamed(!!) ;)

I assume the BSP team already has Gen3 integration patches, and those I'll pick
up when the BSP is released and the driver is otherwise fine.

Changes since last version:

* renamed from sh_mobile to renesas_rwdt all over the place
* clk_divisor is now selected to give maximum max_timeout value
* set_timeout is now supported \o/
* removed bootstatus report, didn't work for me on Lager
  needs more investigation
* minor cleanups

Enjoy and test... It worked for me (tm)


Wolfram Sang (5):
  ARM: shmobile: r8a7790: add mstp4 and rwdt clock
  ARM: shmobile: r8a7790: add node for rwdt
  ARM: shmobile: r8a7790: lager: enable rwdt
  ARM: shmobile: r8a7790: let rst module allow watchdog resets if
    desired
  watchdog: renesas-rwdt: add driver

 arch/arm/boot/dts/r8a7790-lager.dts       |   4 +
 arch/arm/boot/dts/r8a7790.dtsi            |  16 ++-
 arch/arm/mach-shmobile/setup-rcar-gen2.c  |  16 ++-
 drivers/watchdog/Kconfig                  |   8 ++
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/renesas_rwdt.c           | 222 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |   1 +
 7 files changed, 264 insertions(+), 4 deletions(-)
 create mode 100644 drivers/watchdog/renesas_rwdt.c

-- 
2.1.4

