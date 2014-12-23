From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 23 Dec 2014 09:16:52 +0000
Subject: [GIT PULL FOR v3.20] R-Car DMA engine driver
Message-Id: <25808042.z3ylOLx5GF@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Vinod,

The following changes since commit fbde286783f7c1e55e6c33575fa1a56f8ea77c90:

  dmaengine: nbpfaxi: update the driver comments (2014-12-22 20:28:04 +0530)

are available in the git repository at:

  git://linuxtv.org/pinchartl/fbdev.git dma/next

for you to fetch changes up to ee4b876bbee2c5c53518110849f23c117eec099c:

  dmaengine: rcar-dmac: Handle hardware descriptor allocation failure=20
(2014-12-23 11:13:03 +0200)

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
 drivers/dma/sh/rcar-dmac.c                              | 1747 +++++++++++=
+++
 include/linux/dmaengine.h                               |    3 +
 6 files changed, 1765 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/sh/rcar-dmac.c

--=20
Regards,

Laurent Pinchart

