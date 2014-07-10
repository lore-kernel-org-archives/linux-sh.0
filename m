From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 20:36:43 +0000
Subject: [PATCH V2] dmaengine: inherit debug settings from the subsystem for subdirectories
Message-Id: <1405024603-4023-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

To be able to see debug messages during boot, enable the debug settings
from Kconfig also for drivers in subdirectories.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes since initial version:

* extended to all subdirs (but only tested with sh)
* give reason in commit message

 drivers/dma/bestcomm/Makefile | 3 +++
 drivers/dma/dw/Makefile       | 3 +++
 drivers/dma/ioat/Makefile     | 3 +++
 drivers/dma/ipu/Makefile      | 3 +++
 drivers/dma/ppc4xx/Makefile   | 3 +++
 drivers/dma/sh/Makefile       | 3 +++
 drivers/dma/xilinx/Makefile   | 3 +++
 7 files changed, 21 insertions(+)

diff --git a/drivers/dma/bestcomm/Makefile b/drivers/dma/bestcomm/Makefile
index aed2df2a6580..61aab44d205a 100644
--- a/drivers/dma/bestcomm/Makefile
+++ b/drivers/dma/bestcomm/Makefile
@@ -2,6 +2,9 @@
 # Makefile for BestComm & co
 #
 
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 bestcomm-core-objs	:= bestcomm.o sram.o
 bestcomm-ata-objs	:= ata.o bcom_ata_task.o
 bestcomm-fec-objs	:= fec.o bcom_fec_rx_task.o bcom_fec_tx_task.o
diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index 3eebd1ce2c6b..1301d24615a5 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -1,3 +1,6 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_DW_DMAC_CORE)	+= dw_dmac_core.o
 dw_dmac_core-objs	:= core.o
 
diff --git a/drivers/dma/ioat/Makefile b/drivers/dma/ioat/Makefile
index 0ff7270af25b..163618fdfd7a 100644
--- a/drivers/dma/ioat/Makefile
+++ b/drivers/dma/ioat/Makefile
@@ -1,2 +1,5 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
 ioatdma-y := pci.o dma.o dma_v2.o dma_v3.o dca.o
diff --git a/drivers/dma/ipu/Makefile b/drivers/dma/ipu/Makefile
index 6704cf48326d..07dea0b0228f 100644
--- a/drivers/dma/ipu/Makefile
+++ b/drivers/dma/ipu/Makefile
@@ -1 +1,4 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-y	+= ipu_irq.o ipu_idmac.o
diff --git a/drivers/dma/ppc4xx/Makefile b/drivers/dma/ppc4xx/Makefile
index b3d259b3e52a..acd081dbf16a 100644
--- a/drivers/dma/ppc4xx/Makefile
+++ b/drivers/dma/ppc4xx/Makefile
@@ -1 +1,4 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += adma.o
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 1ce88b28cfc6..275297a89bd5 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,3 +1,6 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
 obj-$(CONFIG_SH_DMAE) += shdma.o
 shdma-y := shdmac.o
diff --git a/drivers/dma/xilinx/Makefile b/drivers/dma/xilinx/Makefile
index 3c4e9f2fea28..a169981e73e3 100644
--- a/drivers/dma/xilinx/Makefile
+++ b/drivers/dma/xilinx/Makefile
@@ -1 +1,4 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_XILINX_VDMA) += xilinx_vdma.o
-- 
2.0.0

