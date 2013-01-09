From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 01:03:07 +0000
Subject: [PATCH v2 0/8] SH pinctrl DT support
Message-Id: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here's the second version of the SuperH and SH Mobile pin controllers (PFC) DT
support patch set. The patches are based on the second version of my previous
PFC pinctrl and pinmux patch series ("[PATCH v2 00/29] SH pinctrl and pinmux
implementation") and are available from my git tree at

        git://linuxtv.org/pinchartl/fbdev.git pinmux-dt

The series is pretty self-explanatory. DT bindings are added in patch 1/9, and
the following patches move board code over to the device tree.

I've dropped pinctrl mappings move to DT, as pinctrl hogging in DT didn't work
with the new pinctrl device core code. The mappings will move to DT when DT
support will be implemented in the LCDC driver.

I'm still a bit unsure about the DT bindings. The platforms that implement
pinctrl DT bindings use a wide variety of architectures. I haven't found clear
guidelines regarding how those bindings should be implemented
(Documentation/devicetree/pinctrl just states that bindings are
driver-specific). Comments will be appreciated.

Changes since v1:

- Fixed gpio cell number 2 documentation
- Added missing gpio-controller and #gpio-cells properties to r8a7740 DT
- Split kzm9g DT patch into SoC and board patches
- Dropped pinctrl mappings move to DT

Laurent Pinchart (7):
  sh-pfc: Add OF support
  ARM: shmobile: r8a7740: Add pin control device in device tree
  ARM: shmobile: armadillo: Populate platform devices from device tree
  ARM: shmobile: Include sh73a0 DTSI in kzm9g
  ARM: shmobile: sh73a0: Add pin control device in device tree
  ARM: shmobile: kzm9g: Populate platform devices from device tree
  ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree

Nobuhiro Iwamatsu (1):
  ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   77 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |    8 ++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   18 +++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |   32 ++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c     |   10 ++-
 arch/arm/mach-shmobile/board-kzm9g.c               |    7 +-
 drivers/pinctrl/sh-pfc/core.c                      |   62 +++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |   54 ++++++++++++++
 9 files changed, 259 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi

-- 
Regards,

Laurent Pinchart

