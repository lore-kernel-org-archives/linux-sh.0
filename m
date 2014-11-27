From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 27 Nov 2014 00:15:04 +0000
Subject: [GIT PULL FOR v3.19] R-Car DMA engine driver
Message-Id: <3453038.BtMDKhPqev@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Vinod,

The following changes since commit 9d3cc3e584296b83351f41c72ea7faf439d03e4a:

  Merge branch 'topic/at_xdmac' into next (2014-11-17 14:07:35 +0530)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git dma/next

for you to fetch changes up to ecb5e83101a23b0ad86c92342639ffcc74a06761:

  dmaengine: rcar-dmac: Handle hardware descriptor allocation failure=20
(2014-11-27 02:12:55 +0200)

----------------------------------------------------------------
J=FCrg Billeter (1):
      dmaengine: rcar-dmac: Handle hardware descriptor allocation failure

Laurent Pinchart (5):
      dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
      dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
      dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)=20
driver
      dmaengine: rcar-dmac: Implement support for hardware descriptor lists
      dmaengine: rcar-dmac: Cache hardware descriptors memory

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt       |    3 -
 drivers/dma/Makefile                                    |    2 +-
 drivers/dma/sh/Kconfig                                  |   14 +-
 drivers/dma/sh/Makefile                                 |    1 +
 drivers/dma/sh/rcar-dmac.c                              | 1777 +++++++++++=
+++
 include/linux/dmaengine.h                               |    3 +
 6 files changed, 1795 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/sh/rcar-dmac.c

--=20
Regards,

Laurent Pinchart

