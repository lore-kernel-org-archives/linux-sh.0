From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 11:20:01 +0000
Subject: [PATCH 00/03] USB Host 2.0 and IOMMU trial on r8a7790 Lager
Message-Id: <20140916112001.14889.62059.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB Host 2.0 and IOMMU trial on r8a7790 Lager

[PATCH 01/03] PCI: rcar: Use notifier to hook up IOMMU groups
[PATCH 02/03] iommu/ipmmu-vmsa: Create mapping via group notifier
[PATCH 03/03] ARM: shmobile: lager-reference: IOMMUSY1 and USB tests

This patch series modifies the R-Car Gen2 PCI driver and the IPMMU-VMSA
driver to coexist and assign one IOMMU group per PCI host controller.

The PCI host controllers and the IOMMU device are glued together via
prototype code that adds the IOMMU as a platform device and ties in
the 3 PCI host controllers to the IPMMUSY1 device. Patch 3/3 is not
intended for upstream merge, however patch 1/3 and 2/3 may be useful
with or without further fixes. Comments are very welcome.

The code in this series has been lightly tested on r8a7790 Lager using
USB1 on the CN5 connector. A USB smart card reader has been hot plugged
and notifications and IOMMU map/unmap operations have been verified.

IOMMU groups have been used to separate the PCI host controllers into
groups of devices that need to use the same UTLB number. Perhaps it
would make sense to also use per-device ASIDs somehow, but this needs
further discussions.

After bootup the OHCI and EHCI devices associated with the IOMMU groups
can be located like this:

# cd /sys/kernel/iommu_groups/
# ls */*  
2/devices:
0000:02:02.0  0000:02:01.0  ee0d0000.pci

1/devices:
ee0b0000.pci  0000:01:02.0  0000:01:01.0

0/devices:
ee090000.pci  0000:00:02.0  0000:00:01.0

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140911-v3.17-rc4
 
 arch/arm/mach-shmobile/board-lager-reference.c |   30 +++++
 drivers/iommu/ipmmu-vmsa.c                     |  121 ++++++++++++++----------
 drivers/pci/host/pci-rcar-gen2.c               |   52 ++++++++++
 3 files changed, 157 insertions(+), 46 deletions(-)
