From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 05 Oct 2015 12:06:26 +0000
Subject: [PATCH 0/4] usb: host: xhci-plat: add support for the R-Car M2-N and H3 xHCI controllers
Message-Id: <1444046790-5804-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch set adds support for R-Car M2-N (r8a7793) and H3 (r8a7795) xHCI
controllers. To add support these new SoCs, this patch set modify some codes.

This patch is based on the latest usb.git / usb-next branch.
(The commit id = 07294cc2ea3000da706fd88c8ec7dcfadc715e14.)

Yoshihiro Shimoda (4):
  usb: host: xhci-rcar: add xhci_rcar_is_compatible() function
  usb: host: xhci-plat: add support for the R-Car M2-N xHCI controller
  usb: host: xhci-rcar: Change code for new SoCs
  usb: host: xhci-plat: add support for the R-Car H3 xHCI controllers

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  4 +-
 drivers/usb/host/xhci-plat.c                       | 11 ++-
 drivers/usb/host/xhci-rcar.c                       | 83 ++++++++++++++++++----
 drivers/usb/host/xhci-rcar.h                       |  6 ++
 4 files changed, 81 insertions(+), 23 deletions(-)

-- 
1.9.1

