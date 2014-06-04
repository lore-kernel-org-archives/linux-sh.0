From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 04 Jun 2014 08:22:29 +0000
Subject: [PATCH v5 0/1] add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <538ED745.5080106@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This patch adds the USB xHCI support for the R-Car H2 and M2 SoCs.
These SoCs use an xHCI but still need specific initialization, mainly
to setup the firmware downloading and the specific registers.

This patch set is based on the usb-next branch of Greg usb.git tree.
(commit id = 4a95b1fce97756d0333f8232eb7ed6974e93b054)

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
