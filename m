From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 22 Jun 2015 14:42:28 +0000
Subject: [PATCH 0/3] R-Car Gen2 USB0 Host/Function switching
Message-Id: <1434984151-27274-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

This patch set adds support for USB Host/Function switching using external
gpios to get the vbus and id signals.

I am aware that the dt binding for the USB phy will need updating, but wanted
to get this patch set out first to see whether this is the best way to
implement this.

Phil

Phil Edworthy (3):
  usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
  phy: rcar-gen2 usb: Add Host/Function switching for USB0
  arm: koelsch: make USB0 perform Host/Function switching

 arch/arm/boot/dts/r8a7791-koelsch.dts  |   7 +-
 drivers/phy/phy-rcar-gen2.c            | 269 ++++++++++++++++++++++++++++++---
 drivers/usb/renesas_usbhs/common.h     |   2 +
 drivers/usb/renesas_usbhs/mod.c        |   3 +
 drivers/usb/renesas_usbhs/mod_gadget.c |  38 +++++
 5 files changed, 294 insertions(+), 25 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
