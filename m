From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 29 May 2014 01:31:57 +0000
Subject: [PATCH v3 0/2] add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <53868E0D.7060703@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

This patch set adds the USB xHCI support for the R-Car H2 and M2 SoCs.
These SoCs use an xHCI but still need specific initialization, mainly
to setup the firmware downloading and the specific registers.

This patch set is based on the usb-next branch of Greg usb.git tree.
(commit id = ff1fcd50bc2459744e6f948310bc18eb7d6e8c72)


This patch series has a Gregory CLEMENT's patch. Since the patch needed to
fix some things, I modified the patch:
http://marc.info/?l=linux-usb&m0025742005303&w=2
http://marc.info/?l=linux-usb&m0088117126268&w=2


Changes since v2:
 - Fix goto direction in patch 1.
 - Remove some unnecessary checks in patch 1.
 - Add MODULE_FIRMWARE() in patch 2.
 - Add a comment about xhci_rcar_init_quirk() in patch 2.

Changes since v1 (about patch 2 only because patch 1 and 3 ware applied):
 - Fix some typos in patch 2.
 - Remove duplicated #define in patch 2.
 - Remove usb_phy framework calling in patch 2.
 - Change prototype of xhci_rcar_start() in patch 2.
 - Change compatible strings from "renesas,r8a779[01]-xhci" to
   "renesas,xhci-r8a779[01]" in patch 2. Because of Renesas SoC
   maintainer's comment:
    http://marc.info/?l=linux-sh&m0109049002958&w=2

 - Rewrite the custom get_unaligned_le32() and add comment about it in patch 2.


Gregory CLEMENT (1):
  usb: host: xhci-plat: add optional PHY support

Yoshihiro Shimoda (1):
  usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI
    controllers

 drivers/usb/host/Kconfig     |    8 +++
 drivers/usb/host/Makefile    |    3 +
 drivers/usb/host/xhci-plat.c |   45 +++++++++++-
 drivers/usb/host/xhci-rcar.c |  162 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rcar.h |   27 +++++++
 drivers/usb/host/xhci.h      |    2 +
 6 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-rcar.c
 create mode 100644 drivers/usb/host/xhci-rcar.h

-- 
1.7.9.5
