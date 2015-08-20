From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:07 +0000
Subject: [PATCH 0/7][RFC] Local: Hack: arm64: dts: renesas: add support for USB 2.0 host of r8a7795
Message-Id: <1440052154-3768-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set adds support for USB 2.0 host of r8a7795. This patch is based
on the renesas-driver.git / renesas-drivers-2015-08-18-v4.2-rc7 tag and
local pinctrl driver that Morimoto-san submitted (but, SH-ML denied the email?).
Since "Renesas Gen3 initial patch" of next version (v6) will be released
by Morimoto-san, this patch set should be not merged.

Yoshihiro Shimoda (7):
  arm64: dts: r8a7795: add mstp7 node and enable HSUSB clock
  arm64: dts: r8a7795: add EHCI[012] clocks
  arm64: dts: r8a7795: add usb-phy device nodes
  arm64: dts: r8a7795: add device nodes of EHCI and OHCI
  arm64: dts: salvatorx: add pfc node and subnodes for usb 2.0
  arm64: dts: salvatorx: enable usb2_phy nodes
  arm64: dts: salvatorx: enable ehci and ohci nodes

 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts |  59 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi          | 104 ++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h         |   4 +
 3 files changed, 167 insertions(+)

-- 
1.9.1

