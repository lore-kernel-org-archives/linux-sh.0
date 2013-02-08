From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 08 Feb 2013 18:38:24 +0000
Subject: [PATCH/RFC v2 0/8] ARM: shmobile: SD/MMC for armadillo800eva- and kzm9g-reference
Message-Id: <1360348712-29255-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This series extends the 3-patch series, sent by me yesterday. It is still 
to be decided, whether and which of these patches are suitable for upstream, 
and which of them just demonstrate, how to get the hardware running.

Thanks
Guennadi

Guennadi Liakhovetski (8):
  ARM: shmobile: add MMCIF and SDHI DT clock aliases to sh73a0 and
    r8a7740
  ARM: shmobile: add SDHI and MMCIF interfaces to
    armadillo800eva-reference
  ARM: shmobile: SDHI and MMCIF interfaces to kzm9g-reference
  ARM: shmobile: move GIC and I2C devices from sh73a0 common .dtsi to
    reference
  ARM: shmobile: add sh73a0-specific timer initialisation to
    kzm9g-reference
  ARM: shmobile: add INTC interrupt controllers on sh73a0 in the DT
    case
  ARM: shmobile: parse DT and configure pinmux early on kzm9g-reference
  ARM: shmobile: add ethernet support to kzm9g-reference

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   44 ++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   42 ++++++++++-
 arch/arm/boot/dts/sh73a0-reference.dtsi            |   69 ++++++++++++++++++
 arch/arm/boot/dts/sh73a0.dtsi                      |   69 ------------------
 .../board-armadillo800eva-reference.c              |   52 ++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |   74 ++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7740.c             |    4 +
 arch/arm/mach-shmobile/clock-sh73a0.c              |    3 +
 arch/arm/mach-shmobile/include/mach/common.h       |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c               |   24 +++++--
 10 files changed, 300 insertions(+), 82 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
