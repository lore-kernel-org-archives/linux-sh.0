From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:14:03 +0000
Subject: [PATCH 0/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller
Message-Id: <1423469645-2976-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch set is based on slave-dma.git / next branch.
(commit id = 6ed0123a70ac7a8e0f0480c3e87b3b89c9b98fa9)

Yoshihiro Shimoda (2):
  dmaengine: renesas,usb-dmac: Add device tree bindings documentation
  dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver

 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |   37 +
 drivers/dma/sh/Kconfig                             |    8 +
 drivers/dma/sh/Makefile                            |    1 +
 drivers/dma/sh/usb-dmac.c                          | 1274 ++++++++++++++++++++
 4 files changed, 1320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
 create mode 100644 drivers/dma/sh/usb-dmac.c

-- 
1.7.9.5

