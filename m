From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 01 Apr 2015 06:22:43 +0000
Subject: [PATCH v4 0/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller
Message-Id: <1427869365-2068-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, dan.j.williams@intel.com, laurent.pinchart@ideasonboard.com, horms@verge.net.au, kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on slave-dma.git / next branch.
(commit id = 739e9c81155e74ca7acfa152eea4e8c055fe35b8)

Changes from v3:
 - Call devm_free_irq() in usb_dmac_chan_remove() to prevent the isr gets
   triggered after this driver have freed up stuff.

Changes from v2:
 - Change descriptor management to store the residue in descriptor instead
   of the channel.
 - Change acceptable any sg_len.
 - Modify usb_dmac_tx_status() to calculate the residue for flight
   descriptors.
 - Remove a local tasklet.
 - Remove #ifdef CONFIG_PM.
 Remarks: No change in patch [1/2].

Changes from v1:
 - Use virt-dma infrastructure instead of local descriptor management.
 - Change acceptable sg_len to 1.
   (because a client driver will use dmaengine_prep_slave_single().)
 - Remove usb_dmac_sleep_{suspend,resume} functions.
 - Add usb_dmac_chan_halt() in usb_dmac_runtime_suspend().
 - Use a tasklet instead of a kernel thread.
 - Add tasklet_kill() in usb_dmac_remove().
 - Fix MODULE_AUTHOR string.
 Remarks: No change in patch [1/2].

Yoshihiro Shimoda (2):
  dmaengine: renesas,usb-dmac: Add device tree bindings documentation
  dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver

 .../devicetree/bindings/dma/renesas,usb-dmac.txt   |  37 +
 drivers/dma/sh/Kconfig                             |   9 +
 drivers/dma/sh/Makefile                            |   1 +
 drivers/dma/sh/usb-dmac.c                          | 910 +++++++++++++++++++++
 4 files changed, 957 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
 create mode 100644 drivers/dma/sh/usb-dmac.c

-- 
1.9.1

