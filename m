From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 27 Oct 2015 01:18:23 +0000
Subject: [PATCH v4 0/7] usb: host: xhci-plat: add support for the R-Car M2-N and H3 xHCI controllers
Message-Id: <1445908710-5812-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set adds support for R-Car M2-N (r8a7793) and H3 (r8a7795) xHCI
controllers. To add support these new SoCs, this patch set adds a new member
"priv" in struct xhci_hcd.

This patch is based on the latest usb.git / usb-next branch.
(The commit id = 0bbc367e21bfeea33230d893be4fa3a3ff9bcb48)

Changes from v3:
 - Fix subject and description in patch 1.

Changes from v2:
 - Rebase the latest usb-next branch (commit id = 0bbc367e21bfeea33230d)
 - Modify hcd_priv_size and extra_priv_size in xhci.c and xhci-{plat,pci}.c
   as a clean-up patch.
 - Change "priv" of struct xhci_hcd from const pointer to priv[0].

Changes from v1:
 - Add "const void *priv" in struct xhci_hcd to simplify the code to match
   platform specific variables using of_device_id.data.
   To achieve this purpose, this patch set made patch 1 to 3.


Yoshihiro Shimoda (7):
  usb: host: xhci: cleanup hcd private size
  usb: host: xhci: add a platform-private field
  usb: host: xhci-plat: add struct xhci_plat_priv
  usb: host: xhci-plat: add firmware_name in xhci_plat_priv
  usb: host: xhci-rcar: Change code for new SoCs
  usb: host: xhci-plat: add support for the R-Car M2-N xHCI controller
  usb: host: xhci-plat: add support for the R-Car H3 xHCI controllers

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 +-
 drivers/usb/host/xhci-pci.c                        |  1 -
 drivers/usb/host/xhci-plat.c                       | 88 +++++++++++++++-------
 drivers/usb/host/xhci-plat.h                       | 39 ++++++++++
 drivers/usb/host/xhci-rcar.c                       | 44 +++++++----
 drivers/usb/host/xhci-rcar.h                       |  3 +
 drivers/usb/host/xhci.c                            |  2 +-
 drivers/usb/host/xhci.h                            |  3 +
 8 files changed, 140 insertions(+), 44 deletions(-)
 create mode 100644 drivers/usb/host/xhci-plat.h

-- 
1.9.1

