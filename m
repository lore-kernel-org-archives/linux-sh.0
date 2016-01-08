From: "=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>
Date: Fri, 08 Jan 2016 08:23:02 +0000
Subject: [RFC 0/4] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1452241386-22830-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

In this series I (try) to enable IOMMU support for rcar-dma. This
prototype works fine and is test on a lager board but it might have some
odd design choices.

What I'm most concerned about is that I could not find a good way too
keep track of mappings from different DMA channels to the same address
so that they could properly be unmapped. This issue is due to that two
channels might both try to map the same address (think rx/tx pair) and
that would make it unsafe for any one of the channels to unmap the
address without knowing if it's in use by the other.

A follow up problem to this is that if the same address is mapped from
two different channels but with different sizes and the larger size is
tried last. If such a condition should happen and the larger size is so
large that it crosses a page boundary there would be trouble.

An obvious solution to both problem would be to map address to different
iova:s in each channel and keep track of the unique mapping. That way
all the above problems would go away. The problem is I can't figure out
how to allocate a unique iova to feed to iommu_map.

Patch 4/4 is only included to show what I turn on to verify the series.
To do the verification on the lager board I simply run md5sum on
/dev/mmcblk1.


Niklas S=C3=B6derlund (4):
  iommu: add function iommu_min_pgsize
  dmaengine: rcar-dmac: add iommu support for slave transfers
  ARM: dts: r8a7790: add iommus to dmac0 and dmac1
  enable ipmmu for devcies connected to ipmmu_ds

 arch/arm/boot/dts/r8a7790.dtsi      | 32 +++++++++++++++++++++++-
 arch/arm/configs/shmobile_defconfig |  3 ++-
 drivers/dma/sh/rcar-dmac.c          | 50 +++++++++++++++++++++++++++++++++=
+++-
 include/linux/iommu.h               | 10 ++++++++
 4 files changed, 92 insertions(+), 3 deletions(-)

--
2.6.4

