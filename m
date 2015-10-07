From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Oct 2015 11:38:52 +0000
Subject: [PATCH v2 0/6] usb: host: xhci-plat: add support for the R-Car M2-N and H3 xHCI controllers
Message-Id: <1444217938-4668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set adds support for R-Car M2-N (r8a7793) and H3 (r8a7795) xHCI
controllers. To add support these new SoCs, this patch set adds a new member
"priv" in struct xhci_hcd.

This patch is based on the latest usb.git / usb-next branch.
(The commit id = d5f9e73309b774dd9d86428edd7958b0960bcb85.)

Changes from v1:
 - Add "const void *priv" in struct xhci_hcd to simplify the code to match
   platform specific variables using of_device_id.data.
   To achieve this purpose, this patch set made patch 1 to 3.

Yoshihiro Shimoda (6):
  usb: host: xhci: add a platform-private pointer field
  usb: host: xhci-plat: add struct xhci_plat_priv
  usb: host: xhci-plat: add firmware_name in xhci_plat_priv
  usb: host: xhci-rcar: Change code for new SoCs
  usb: host: xhci-plat: add support for the R-Car M2-N xHCI controller
  usb: host: xhci-plat: add support for the R-Car H3 xHCI controllers

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 +-
 drivers/usb/host/xhci-plat.c                       | 80 +++++++++++++++-------
 drivers/usb/host/xhci-plat.h                       | 39 +++++++++++
 drivers/usb/host/xhci-rcar.c                       | 44 ++++++++----
 drivers/usb/host/xhci-rcar.h                       |  3 +
 drivers/usb/host/xhci.h                            |  3 +
 6 files changed, 132 insertions(+), 41 deletions(-)
 create mode 100644 drivers/usb/host/xhci-plat.h

-- 
1.9.1

