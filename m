From: Christoph Hellwig <hch@lst.de>
Date: Thu, 10 Sep 2020 05:40:35 +0000
Subject: support range based offsets in dma-direct
Message-Id: <20200910054038.324517-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, Nathan Chancellor <natechancellor@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org

Hi all,

this series adds range-based offsets to the dma-direct implementation.  The
guts of the change are a patch from Jim with some modifications from me,
but to do it nicely we need to ARM patches to prepare for it as well.

Diffstat:
 arch/arm/common/dmabounce.c                        |    2 
 arch/arm/include/asm/dma-direct.h                  |   69 +++++++++++++++++
 arch/arm/include/asm/dma-mapping.h                 |   70 ------------------
 arch/arm/mach-keystone/keystone.c                  |   21 +++--
 arch/sh/drivers/pci/pcie-sh7786.c                  |    9 +-
 arch/x86/pci/sta2x11-fixup.c                       |    6 +
 drivers/acpi/arm64/iort.c                          |    6 +
 drivers/base/core.c                                |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    8 +-
 drivers/iommu/io-pgtable-arm.c                     |    2 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    9 ++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |   11 ++
 drivers/of/address.c                               |   73 ++++++++----------
 drivers/of/device.c                                |   44 +++++++----
 drivers/of/of_private.h                            |   11 +-
 drivers/of/unittest.c                              |   34 ++++++--
 drivers/remoteproc/remoteproc_core.c               |    4 -
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   10 ++
 drivers/usb/core/message.c                         |    5 -
 drivers/usb/core/usb.c                             |    3 
 include/linux/device.h                             |    4 -
 include/linux/dma-direct.h                         |   52 +++++++++++--
 include/linux/dma-mapping.h                        |   19 ++++
 kernel/dma/coherent.c                              |    7 -
 kernel/dma/direct.c                                |   81 ++++++++++++++++++++-
 25 files changed, 373 insertions(+), 189 deletions(-)
