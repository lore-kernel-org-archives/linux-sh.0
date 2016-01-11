From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Mon, 11 Jan 2016 02:17:45 +0000
Subject: [PATCH 0/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1452478667-30966-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

In this series I add iommu support to rcar-damc. It is tested on on the
lager board. It is tested by enabling CONFIG_IPMMU_VMSA and enable the
ipmmu_ds node in r8a7790.dtsi. Once booted try using dma with a device
behind the iommu, I used the mmc at /dev/mmcblk1.

* Changes since RFC
- Switch to use the dma-mapping api instead of using the iommu_map()
  directly. Turns out the dma-mapper is much smarter then me...
- Dropped the patch to expose domain->ops->pgsize_bitmap from within the
  iommu api.
- Dropped the patch showing how I tested the RFC.


Niklas S=C3=B6derlund (2):
  dmaengine: rcar-dmac: add iommu support for slave transfers
  ARM: dts: r8a7790: add iommus to dmac0 and dmac1

 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++
 drivers/dma/sh/rcar-dmac.c     | 64 ++++++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 90 insertions(+), 4 deletions(-)

--
2.7.0

