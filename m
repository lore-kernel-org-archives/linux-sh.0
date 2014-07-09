From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Jul 2014 01:08:45 +0000
Subject: [PATCH v7 0/1] add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <53BC961D.9080803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the USB xHCI support for the R-Car H2 and M2 SoCs.
These SoCs use an xHCI but still need specific initialization, mainly
to setup the firmware downloading and the specific registers.

This patch set is based on the usb-next branch of Greg usb.git tree.
(commit id = f8dd7a2a3a572dd93d7e84d628ffb25b3309179b)

Changes since v6:
 - Rebase the latest usb-next branch

Changes since v5:
 - Fix the RCAR_USB3_RX_POL_VAL value in patch 1.
 - Also modify the RCAR_USB3_TX_POL_VAL value using the BIT macro.

Changes since v4:
 - Rebase the latest usb-next branch

Changes since v3:
 - Remove a general phy driver calling in xhci-plat.c
 - Change xhci_rcar_init_quirk() calling into xhci_plat_setup(). Because of
   usb_add_hcd() will call a generic phy driver calling.
 - Modify xhci_rcar_init_quirk()

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

Yoshihiro Shimoda (1):
  usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI
    controllers

 drivers/usb/host/Kconfig     |    8 +++
 drivers/usb/host/Makefile    |    3 +
 drivers/usb/host/xhci-plat.c |   19 ++++++
 drivers/usb/host/xhci-rcar.c |  148 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-rcar.h |   27 ++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/usb/host/xhci-rcar.c
 create mode 100644 drivers/usb/host/xhci-rcar.h

-- 
1.7.9.5

