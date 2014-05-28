From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 28 May 2014 11:22:41 +0000
Subject: [PATCH v2 0/3] add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <5385C701.6020404@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

This patch set adds the USB xHCI support for the R-Car H2 and M2 SoCs.
These SoCs use an xHCI but still need specific initialization, mainly
to setup the firmware downloading and the specific registers.

This patch set is based on the usb-next branch of Greg usb.git tree.
(commit id = 7027df36e41836b11f01b0d30eee40c55df7d013)

This patch also depends on the following patches:
	http://marc.info/?l=linux-usb&m0025742005303&w=2


However, this driver could not work correctly in the usb-next branch.
When I connected a usb high speed hub, the xHCI driver output the following
log.

xhci-hcd ee000000.xhci: ERROR: unexpected command completion code 0x11.
hub 1-1:1.0: config failed, can't update HCD hub info (err -22)

If I did "git bisect", it said the d8521afe35862f4fbe3ccd6ca37897c0a304edf3
is the first bad commit. I'm not sure about detail of the commit now. But,
I would like to submit these patches about R-Car H2/M2 xHCI because
they could work in the usb-linus branch (commit 7ac3764fcaf) with some
related patches about the xhci-plat driver.

Changes since v1:
 - Fix some typos in patch 2.
 - Remove duplicated #define in patch 2.
 - Remove usb_phy framework calling in patch 2.
 - Change prototype of xhci_rcar_start() in patch 2.
 - Change compatible strings from "renesas,r8a779[01]-xhci" to
   "renesas,xhci-r8a779[01]" in patch 2 and 3. Because of Renesas SoC
   maintainer's comment:
    http://marc.info/?l=linux-sh&m0109049002958&w=2

 - Rewrite the custom get_unaligned_le32() and add comment about it in patch 2.
 - Add Acked-by from Geert Uytterhoeven in patch 1 and 3.

Yoshihiro Shimoda (3):
  usb: host: xhci-plat: add xhci_plat_start()
  usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI
    controllers
  Documentation: dt-bindings: update xhci-platform DT binding for R-Car
    H2 and M2

 Documentation/devicetree/bindings/usb/usb-xhci.txt |    3 +-
 drivers/usb/host/Kconfig                           |    8 +
 drivers/usb/host/Makefile                          |    3 +
 drivers/usb/host/xhci-plat.c                       |   25 ++-
 drivers/usb/host/xhci-rcar.c                       |  180 ++++++++++++++++++++
 drivers/usb/host/xhci-rcar.h                       |   27 +++
 6 files changed, 244 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/host/xhci-rcar.c
 create mode 100644 drivers/usb/host/xhci-rcar.h

-- 
1.7.9.5
