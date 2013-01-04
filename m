From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 04 Jan 2013 00:40:51 +0000
Subject: [PATCH 0/9] SH pinctrl DT support
Message-Id: <1357260060-32164-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's a patch set that implements DT bindings for the SuperH and SH Mobile pin
controllers (PFC). The patches are based on my previous PFC pinctrl and pinmux
patch series ("[PATCH 00/22] SH pinctrl and pinmux implementation") and are
available from my git tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux-dt

The series is pretty self-explanatory. DT bindings are added in patch 1/9, and
the following patches move board code over to the device tree. All patches
except 5/9 and 8/9 have already been posted in an older version as part of the
"[PATCH v2 00/77] SH pin control and GPIO rework with OF support" patch set.

To be perfectly honest I'm a bit unsure about the DT bindings. The platforms
that implement pinctrl DT bindings use a wide variety of architectures. I
haven't found clear guidelines regarding how those bindings should be
implemented (Documentation/devicetree/pinctrl just states that bindings are
driver-specific). Comments will be appreciated.

Laurent Pinchart (8):
  sh-pfc: Add OF support
  ARM: shmobile: r8a7740: Add pin control device in device tree
  ARM: shmobile: armadillo: Populate platform devices from device tree
  ARM: shmobile: armadillo: Move pinctrl mappings to device tree
  ARM: shmobile: kzm9g: Add pin control device in device tree
  ARM: shmobile: kzm9g: Populate platform devices from device tree
  ARM: shmobile: kzm9g: Move pinctrl mappings to device tree
  ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree

Nobuhiro Iwamatsu (1):
  ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   76 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   12 +++-
 arch/arm/boot/dts/r8a7740.dtsi                     |    6 ++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   28 +++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |   32 ++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c     |   11 +---
 arch/arm/mach-shmobile/board-kzm9g.c               |   11 +---
 drivers/pinctrl/sh-pfc/core.c                      |   62 +++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |   54 ++++++++++++++
 9 files changed, 270 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi

-- 
Regards,

Laurent Pinchart

