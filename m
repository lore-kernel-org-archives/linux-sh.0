From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 May 2014 10:07:36 +0000
Subject: [PATCH 0/3] add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <5379D7E8.9070700@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This patch set adds the USB xHCI support for the R-Car H2 and M2 SoCs.
These SoCs use an xHCI but still need specific initialization, mainly
to setup the firmware downloading and the specific registers.

This patch set depends on the following patches:
	http://marc.info/?l=linux-usb&m0014937401793&w=2
	http://marc.info/?l=linux-usb&m0014935801786&w=2
	http://marc.info/?l=linux-usb&m0014933101775&w=2
	http://marc.info/?l=linux-usb&m0014932301770&w=2

However, this patch set doesn't depend on the following patch because
this patch set uses the "USB phy", not "phy":
	http://marc.info/?l=linux-usb&m0025742005303&w=2

Yoshihiro Shimoda (3):
  usb: host: xhci-plat: add xhci_plat_start()
  usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI
    controllers
  Documentation: dt-bindings: update xhci-platform DT binding for R-Car
    Gen2

 Documentation/devicetree/bindings/usb/usb-xhci.txt |    3 +-
 drivers/usb/host/Kconfig                           |    8 +
 drivers/usb/host/Makefile                          |    3 +
 drivers/usb/host/xhci-plat.c                       |   25 ++-
 drivers/usb/host/xhci-rcar.c                       |  187 ++++++++++++++++++++
 drivers/usb/host/xhci-rcar.h                       |   37 ++++
 6 files changed, 261 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/host/xhci-rcar.c
 create mode 100644 drivers/usb/host/xhci-rcar.h

-- 
1.7.9.5
