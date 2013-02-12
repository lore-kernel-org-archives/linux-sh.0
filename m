From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 15:50:01 +0000
Subject: [PATCH/RFC 0/3] ARM: shmobile: pinctrl sparse pin numbers
Message-Id: <1360684204-12888-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

This implements support for sparse pin / GPIO numbers for r-/sh-mobile. 
Most probably this won't become the mainline implementation, so, mainly an 
RFC / demonstration.

Guennadi Liakhovetski (3):
  pinctrl: sh-pfc: support sparse GPIO numbers
  pinctrl: sh-pfc: add pin groups for all SD/MMC interfaces on sh73a0
  ARM: shmobile: switch SDHI and MMCIF interfaces on kzm9g-reference to
    pinctrl

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   61 ++++++--
 arch/arm/boot/dts/sh73a0-reference.dtsi        |    9 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   36 +----
 arch/arm/mach-shmobile/board-kzm9g.c           |   30 ++--
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    2 +
 drivers/pinctrl/sh-pfc/core.h                  |    1 +
 drivers/pinctrl/sh-pfc/gpio.c                  |    6 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c            |  203 ++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pinctrl.c               |  111 +++++++++++--
 drivers/pinctrl/sh-pfc/sh_pfc.h                |    2 +
 10 files changed, 377 insertions(+), 84 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
