From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 17 Jul 2008 11:03:53 +0000
Subject: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <20080717110353.GB14949@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here is my latest attempt at an MMC host driver for the MMCIF interface
found on many SH-4 socs, particularly the SH7760, SH778x, and SH7763.

This is a very basic driver, without DMA support and crippled performance
due to hardware or driver bugs wrt. multiblock writes.

The driver has been extensively tested on SH7760 only.  The SH7780 and 7763
MMCIF should theoretically work with some minor adjustments.

Patch is against latest linus git.

Thanks!
        Manuel Lauss

--- 
From: Manuel Lauss <mano@roarinelk.homelinux.net>

Host driver for SH7760 on-chip MMCIF interface.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/mmc/host/Kconfig     |    6 +
 drivers/mmc/host/Makefile    |    1 +
 drivers/mmc/host/sh7760mmc.c | 1195 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-sh/mmc.h         |   56 ++
 4 files changed, 1258 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mmc/host/sh7760mmc.c
 create mode 100644 include/asm-sh/mmc.h

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index dc6f257..a778a4c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -174,3 +174,9 @@ config MMC_SDRICOH_CS
 	  To compile this driver as a module, choose M here: the
 	  module will be called sdricoh_cs.
 
+config MMC_SH7760
+	tristate "Renesas SH7760 MMCIF Interface support  (EXPERIMENTAL)"
+	depends on CPU_SUBTYPE_SH7760
+	help
+	  Say Y or M here to enable the SH7760 MMC Interface driver.
+
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index db52eeb..95f1f1f 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
 obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
+obj-$(CONFIG_MMC_SH7760)	+= sh7760mmc.o
 
diff --git a/drivers/mmc/host/sh7760mmc.c b/drivers/mmc/host/sh7760mmc.c
new file mode 100644
index 0000000..5f47128
--- /dev/null
+++ b/drivers/mmc/host/sh7760mmc.c
@@ -0,0 +1,1195 @@
+/*
+ * MMC interface driver for SH7760 and compatibles.
+ *
+ * (c) 2006-2008 MSC Vertriebsges.m.b.H,
+ *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* NOTE: SH7780/SH7763 untested due to lack of hardware. */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
+
+#include <asm/cacheflush.h>
+#include <asm/clock.h>
+#include <asm/scatterlist.h>
+#include <asm/mmc.h>
+
+/* The MMCIF does not provide any facilities for card- and read-only
+ * detection as well as voltage setting. Use GPIOs in the board-specific
+ * code for that. PLEASE READ Documentation/sh/sh7760-mmc.txt if you
+ * want to use this driver with your board!
+ *
+ * The MMCIF on the SH7763 provides its own carddetect feature.
+ *
+ * Detect the MMCIF revision based on selected CPU subtype.
+ */
+
+/* The most basic MMCIF hardware, found on the SH7760 */
+#if defined(CONFIG_CPU_SUBTYPE_SH7760)
+#define MMCIF_HWREV	1
+
+/* Basic MMCIF hw extended with a block counter */
+#elif (defined(CONFIG_CPU_SUBTYPE_SH7780) ||	\
+       defined(CONFIG_CPU_SUBTYPE_SH7785))
+#define MMCIF_HWREV	2
+
+/* above plus voltage on/off switches and carddetect with configurable
+ * debouncer */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
+#define MMCIF_HWREV	3
+#endif
+
+/* MMCIF register offsets */
+#define CMDR0		0x00
+#define CMDR1		0x01
+#define CMDR2		0x02
+#define CMDR3		0x03
+#define CMDR4		0x04
+#define CMDR5		0x05
+#define CMDSTRT		0x06
+#define OPCR		0x0A
+#define CSTR		0x0B
+#define INTCR0		0x0C
+#define INTCR1		0x0D
+#define INTSTR0		0x0E
+#define INTSTR1		0x0F
+#define CLKON		0x10
+#define CTOCR		0x11
+#define VDCNT		0x12		/* LVL3 */
+#define TBCR		0x14
+#define MODER		0x16
+#define CMDTYR		0x18
+#define RSPTYR		0x19
+#define TBNCR		0x1A		/* LVL2+ */
+/* response regs 0-16 */
+#define RSPR(x)		(0x20 + (x))
+#define RSPRD		0x31		/* LVL2+ */
+#define DTOUTR		0x32
+#define DR		0x40
+#define FIFOCLR		0x42
+#define DMACR		0x44
+#define INTCR2		0x46
+#define INTSTR2		0x48
+#define RDTIMSEL	0x4A		/* LVL1 ONLY */
+#define CSWR		0x4A		/* LVL3 */
+#define SWSR		0x4C		/* LVL3 */
+#define CHATR		0x4E		/* LVL3 */
+
+
+#define CMDTYR_NODATA		0
+#define CMDTYR_READ		(1 << 0)
+#define CMDTYR_WRITE		(1 << 1)
+#define CMDTYR_MULTI_BLOCK	(1 << 2)
+#define CMDTYR_STREAM		(1 << 3)
+#define CMDTYR_CMD12		(1 << 4)
+
+#define RSPTYR_BUSY		(1 << 5)
+#define RSPTYR_CRC		(1 << 4)
+#define RSPTYR_LONG		5
+#define RSPTYR_SHORT		4
+
+#define INTSTR_FEI		(1 << 7)
+#define INTSTR_FFI		(1 << 6)
+#define INTSTR_DRPI		(1 << 5)
+#define INTSTR_DTI		(1 << 4)
+#define INTSTR_CRPI		(1 << 3)
+#define INTSTR_CMDI		(1 << 2)
+#define INTSTR_DBSYI		(1 << 1)
+#define INTSTR_BTI		(1 << 0)	/* LVL2+ */
+
+#define INTSTR1_CRCERI		(1 << 2)
+#define INTSTR1_DTERI		(1 << 1)
+#define INTSTR1_CTERI		(1 << 0)
+
+#define INTSTR2_CDI		(1 << 2)	/* LVL3 */
+#define INTSTR2_FRDYTU		(1 << 1)
+#define INTSTR2_FRDYI		(1 << 0)
+
+#define INTSTR_CRCERI		(INTSTR1_CRCERI << 8)
+#define INTSTR_DTERI		(INTSTR1_DTERI << 8)
+#define INTSTR_CTERI		(INTSTR1_CTERI << 8)
+
+#define INTSTR_CDI		(INTSTR2_CDI << 16)
+#define INTSTR_FRDYTU		(INTSTR2_FRDYTU << 16)
+#define INTSTR_FRDYI		(INTSTR2_FRDYI << 16)
+
+#define INTSTR_CMDIRQ	(INTSTR_CRPI | INTSTR_CMDI | INTSTR_CTERI | \
+			 INTSTR_CRCERI | INTSTR_DBSYI)
+#define INTSTR_DATIRQ	(INTSTR_DRPI | INTSTR_DTI | INTSTR_DTERI | \
+			 INTSTR_FEI | INTSTR_FFI | INTSTR_DBSYI | \
+			 INTSTR_CRCERI | INTSTR_BTI)
+
+#define INTCR0_BTI		(1 << 0)	/* LVL2+ */
+#define INTCR0_DBSYIE		(1 << 1)
+#define INTCR0_CMDIE		(1 << 2)
+#define INTCR0_CRPIE		(1 << 3)
+#define INTCR0_DTIE		(1 << 4)
+#define INTCR0_DRPIE		(1 << 5)
+#define INTCR0_FFIE		(1 << 6)
+#define INTCR0_FEIE		(1 << 7)
+
+#define INTCR1_IRQEN		0xE0
+#define INTCR1_CTERIE		(1 << 0)	/* cmd timeout irq */
+#define INTCR1_DTERIE		(1 << 1)	/* data timeout irq */
+#define INTCR1_CRCERIE		(1 << 2)	/* crc error irq */
+
+#define INTCR2_FRDYIE		(1 << 0)	/* fifo ready irq */
+#define INTCR2_CDIE		(1 << 1)	/* carddetect, LVL3 */
+#define INTCR2_INTREQ3E		(1 << 7)	/* fifo, LVL2+ */
+
+#define OPCR_CMDOFF		(1 << 7)	/* stop sequencer */
+#define OPCR_RDCONT		(1 << 5)	/* cont read seq */
+#define OPCR_DATAEN		(1 << 4)	/* start write seq */
+
+#define CSTR_BUSY		(1 << 7)	/* sequencer busy */
+#define CSTR_DTBUSY		(1 << 3)	/* card is occupied */
+#define CSTR_DTBUSYTU		(1 << 2)	/* raw MCDAT pin level */
+
+#define VCDNT_VDDON		(1 << 7)	/* VDDON# signal */
+#define VDCNT_ODMOD		(1 << 6)	/* ODMOD# signal */
+
+/* MMC fifo has 64 WORD entries, or 128 bytes */
+#define MMC_FIFO_SIZE		128
+
+struct shmmc_host {
+	struct mmc_host	*mmc;
+	void __iomem *iobase;
+
+	/* request/data/cmd we are working on currently */
+	struct mmc_request	*mrq;
+	struct mmc_data		*data;
+	struct mmc_command	*cmd;
+
+	unsigned int blocks;	/* blocks left to xfer */
+	unsigned int required;	/* bytes still to write (r/w decreases) */
+	unsigned int xfered;	/* already xfered data bytes (r/w increases) */
+	enum dma_data_direction data_dir;
+
+	/* interrupt masks */
+	unsigned char ien0;
+	unsigned char ien1;
+	unsigned char ien2;
+
+	/* clock rate (CLKON register) */
+	unsigned char clkon;
+
+	/* tasklet handling mmc_request_done */
+	struct tasklet_struct done_task;
+
+	struct shmmc_platdata	*platdata;
+	struct resource *ioarea;
+};
+
+/*********************************************************************/
+
+static int shmmc_card_inserted(struct mmc_host *mmc)
+{
+	struct shmmc_host *host = mmc_priv(mmc);
+
+	if (host->platdata && host->platdata->get_cd)
+		return host->platdata->get_cd(mmc);
+
+	return -ENOSYS;
+}
+
+static int shmmc_card_readonly(struct mmc_host *mmc)
+{
+	struct shmmc_host *host = mmc_priv(mmc);
+
+	if (host->platdata && host->platdata->get_ro)
+		return host->platdata->get_ro(mmc);
+
+	return -ENOSYS;
+}
+
+static inline unsigned short MMC_INW(struct shmmc_host *h, unsigned int reg)
+{
+	return ioread16(h->iobase + reg);
+}
+
+static inline void MMC_OUTW(struct shmmc_host *h, int reg, unsigned short val)
+{
+	iowrite16(val, h->iobase + reg);
+}
+
+static inline unsigned char MMC_INB(struct shmmc_host *h, unsigned int reg)
+{
+	return ioread8(h->iobase + reg);
+}
+
+static inline void MMC_OUTB(struct shmmc_host *h, int reg, unsigned char val)
+{
+	iowrite8(val, h->iobase + reg);
+}
+
+static inline unsigned long shmmc_getirqs(struct shmmc_host *host)
+{
+	unsigned long r0, r1, r2;
+
+	r0 = MMC_INB(host, INTSTR0);
+	r1 = MMC_INB(host, INTSTR1);
+	r2 = MMC_INB(host, INTSTR2);
+	return (r2 << 16) | (r1 << 8) | r0;
+}
+
+/* clear all irq flags. makes controller resume its work */
+static inline void shmmc_clrirq(struct shmmc_host *host)
+{
+	MMC_OUTB(host, INTSTR0, 0);
+	MMC_OUTB(host, INTSTR1, 0);
+	MMC_OUTB(host, INTSTR2, 0);
+}
+
+static inline void shmmc_clock(struct shmmc_host *host, int clk)
+{
+	MMC_OUTB(host, CLKON, clk ? (host->clkon | (1 << 7)) : 0);
+}
+
+static void shmmc_done_tasklet(unsigned long arg)
+{
+	struct shmmc_host *host = (struct shmmc_host *)arg;
+	struct mmc_request *mrq;
+
+	mrq = host->mrq;
+
+	/* should not happen, but I've seen it once or twice */
+	if (!mrq) {
+		pr_debug("%s: mrq = 0!\n", mmc_hostname(host->mmc));
+		return;
+	}
+	host->mrq = NULL;
+
+	/* HACK ALERT: I need this cache flush on my SH7760 system because
+	 * otherwise bits of the card response will be corrupted,
+	 * preventing card identification due to malformed CID/SCR/...
+	 * Don't know why, but it has been this way all the way back to
+	 * 2.6.17.  -- mlau
+	 */
+	flush_dcache_all();
+
+	mmc_request_done(host->mmc, mrq);
+}
+
+static void shmmc_done(struct shmmc_host *host)
+{
+	shmmc_clock(host, 0);
+
+	host->ien0 = 0;
+	host->ien1 &= INTCR1_IRQEN;
+	host->ien2 &= INTCR2_CDIE | INTCR2_INTREQ3E;
+
+	MMC_OUTB(host, INTCR0, 0);
+	MMC_OUTB(host, INTCR1, host->ien1);
+	MMC_OUTB(host, INTCR2, host->ien2);
+
+	shmmc_clrirq(host);
+
+	if (host->data)
+		host->data->bytes_xfered = host->xfered;
+
+	host->xfered = 0;
+	host->blocks = 0;
+	host->required = 0;
+
+	host->data = NULL;
+	host->cmd = NULL;
+
+	tasklet_schedule(&host->done_task);
+}
+
+static void shmmc_cmd(struct shmmc_host *host, struct mmc_command *cmd)
+{
+	unsigned char cmdtyr, rsptyr, i;
+
+	shmmc_clock(host, 0);
+	host->cmd = cmd;
+
+	/* enable MMCIF and "cmd xfer timeout" irqs */
+	host->ien1 |= INTCR1_IRQEN | INTCR1_CTERIE;
+
+	/* setup command type */
+	cmdtyr = 0;
+	if (cmd->opcode = 12)
+		cmdtyr = CMDTYR_CMD12;
+
+	if (cmd->data) {
+		if (cmd->data->flags & MMC_DATA_WRITE)
+			cmdtyr |= CMDTYR_WRITE;
+
+		if (cmd->data->flags & MMC_DATA_READ)
+			cmdtyr |= CMDTYR_READ;
+
+		if (cmd->data->flags & MMC_DATA_STREAM)
+			cmdtyr |= CMDTYR_STREAM;
+
+		if (cmd->data->blocks > 1)
+			cmdtyr |= CMDTYR_MULTI_BLOCK;
+	}
+
+	/* setup response type */
+	rsptyr = 0;
+	MMC_OUTB(host, CTOCR, 0);		/* default cmd timeout */
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		host->ien0 |= INTCR0_CRPIE;	/* response received irq */
+
+		if (cmd->flags & MMC_RSP_136) {
+			rsptyr = RSPTYR_LONG;
+			/* longer timeout for long response */
+			MMC_OUTB(host, CTOCR, 1);
+		} else
+			rsptyr = RSPTYR_SHORT;
+
+		if (cmd->flags & MMC_RSP_BUSY)
+			rsptyr |= RSPTYR_BUSY;
+
+		if (cmd->flags & MMC_RSP_CRC) {
+			rsptyr |= RSPTYR_CRC;
+			host->ien1 |= INTCR1_CRCERIE;
+		}
+#ifdef CONFIG_CPU_SUBTYPE_SH7760
+		/* SH7760: skip R2 CRC checks; these fail every time */
+		if (mmc_resp_type(cmd) = MMC_RSP_R2) {
+			rsptyr &= ~RSPTYR_CRC;
+			host->ien1 &= ~INTCR1_CRCERIE;
+		}
+#endif
+	} else {
+		/* no response: irq when cmd was transmitted */
+		host->ien0 |= INTCR0_CMDIE;
+	}
+
+	MMC_OUTB(host, CMDR0, (1 << 6) | (cmd->opcode & 0x3f));
+	MMC_OUTB(host, CMDR1, cmd->arg >> 24);
+	MMC_OUTB(host, CMDR2, cmd->arg >> 16);
+	MMC_OUTB(host, CMDR3, cmd->arg >> 8);
+	MMC_OUTB(host, CMDR4, cmd->arg);
+
+	for (i = 0; i < 17; i++)
+		MMC_OUTB(host, RSPR(i), 0);
+	MMC_OUTB(host,  CMDTYR, cmdtyr);
+	MMC_OUTB(host,  RSPTYR, rsptyr);
+	/* ~1 sec data timeout @ 20MHz FIXME: make pclk dependent */
+	MMC_OUTW(host, DTOUTR, 0x1000);
+
+	/* enable interrupts */
+	MMC_OUTB(host, INTCR0, host->ien0);
+	MMC_OUTB(host, INTCR1, host->ien1);
+	MMC_OUTB(host, INTCR2, host->ien2);
+
+	/* start MMC engine */
+	shmmc_clock(host, 1);
+	MMC_OUTB(host, CMDSTRT, 1);
+}
+
+static void shmmc_data_done(struct shmmc_host *host)
+{
+	if (host->data)
+		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg,
+			     host->data->sg_len, host->data_dir);
+
+	/* issue the stop cmd if available */
+	if (host->mrq->stop) {
+		MMC_OUTB(host, OPCR, OPCR_CMDOFF);
+		host->ien0 = 0;
+		host->ien1 &= INTCR1_IRQEN;
+		host->ien2 &= INTCR2_CDIE | INTCR2_INTREQ3E;
+		MMC_OUTB(host, INTCR0, 0);
+		MMC_OUTB(host, INTCR1, host->ien1);
+		MMC_OUTB(host, INTCR2, host->ien2);
+		shmmc_cmd(host, host->mrq->stop);
+	} else {
+		shmmc_done(host);
+	}
+}
+
+static void shmmc_read_resp(struct shmmc_host *host, struct mmc_command *cmd)
+{
+	if (cmd->flags & MMC_RSP_136) {
+		cmd->resp[0]  = MMC_INB(host, RSPR(1)) << 24;
+		cmd->resp[0] |= MMC_INB(host, RSPR(2)) << 16;
+		cmd->resp[0] |= MMC_INB(host, RSPR(3)) << 8;
+		cmd->resp[0] |= MMC_INB(host, RSPR(4));
+		cmd->resp[1]  = MMC_INB(host, RSPR(5)) << 24;
+		cmd->resp[1] |= MMC_INB(host, RSPR(6)) << 16;
+		cmd->resp[1] |= MMC_INB(host, RSPR(7)) << 8;
+		cmd->resp[1] |= MMC_INB(host, RSPR(8));
+		cmd->resp[2]  = MMC_INB(host, RSPR(9)) << 24;
+		cmd->resp[2] |= MMC_INB(host, RSPR(10)) << 16;
+		cmd->resp[2] |= MMC_INB(host, RSPR(11)) << 8;
+		cmd->resp[2] |= MMC_INB(host, RSPR(12));
+		cmd->resp[3]  = MMC_INB(host, RSPR(13)) << 24;
+		cmd->resp[3] |= MMC_INB(host, RSPR(14)) << 16;
+		cmd->resp[3] |= MMC_INB(host, RSPR(15)) << 8;
+		cmd->resp[3] |= MMC_INB(host, RSPR(16));
+	} else {
+		cmd->resp[0]  = MMC_INB(host, RSPR(12)) << 24;
+		cmd->resp[0] |= MMC_INB(host, RSPR(13)) << 16;
+		cmd->resp[0] |= MMC_INB(host, RSPR(14)) << 8;
+		cmd->resp[0] |= MMC_INB(host, RSPR(15));
+	}
+}
+
+static void shmmc_cmd_done(struct shmmc_host *host)
+{
+	struct mmc_command *cmd;
+
+	cmd = host->cmd;
+	host->cmd = NULL;
+
+	/* disable cmd-only irqs */
+	host->ien0 &= ~(INTCR0_CRPIE | INTCR0_CMDIE);
+	host->ien1 &= ~INTCR1_CTERIE;
+	MMC_OUTB(host, INTCR0, host->ien0);
+	MMC_OUTB(host, INTCR1, host->ien1);
+
+	/* explicitly check for cmd->data (not host->data), because the
+	 * completed command could be the data->stop/mrq->stop cmd!
+	 */
+	if (!(cmd->data)) {
+		shmmc_done(host);
+	} else if ((host->data) && (host->data->flags & MMC_DATA_WRITE)) {
+		/* start write-data-engine */
+		MMC_OUTB(host, OPCR, OPCR_DATAEN);
+	} else {
+		/* data read op starts automatically. just enable CRC irqs */
+		host->ien1 |= INTCR1_CRCERIE;
+		MMC_OUTB(host, INTCR1, host->ien1);
+	}
+}
+
+static unsigned long
+shmmc_cmd_irq(struct shmmc_host *host, unsigned long istat)
+{
+	/* command timeout */
+	if (istat & INTSTR_CTERI) {
+		host->cmd->error = -ETIMEDOUT;
+		MMC_OUTB(host, OPCR, OPCR_CMDOFF);
+		shmmc_done(host);
+		return 0;
+	}
+
+	/* cmd returned CRC error */
+	if (istat & INTSTR_CRCERI) {
+		host->cmd->error = -EILSEQ;
+		MMC_OUTB(host, OPCR, OPCR_CMDOFF);
+		shmmc_done(host);
+		return 0;
+	}
+
+	/* cmd with no response was sent */
+	if (istat & INTSTR_CMDI) {
+		shmmc_done(host);
+		return 0;
+	}
+
+	/* received a response */
+	if (istat & INTSTR_CRPI) {
+		istat &= ~INTSTR_CRPI;
+
+		shmmc_read_resp(host, host->cmd);
+
+		host->ien0 &= ~INTCR0_CRPIE;
+		MMC_OUTB(host, INTCR0, host->ien0);
+
+		/* if card goes busy, wait for busy end */
+		if ((MMC_INB(host, CSTR) & CSTR_DTBUSY) &&
+		   (host->cmd->flags & MMC_RSP_BUSY)) {
+			host->ien0 |= INTCR0_DBSYIE;
+			MMC_OUTB(host, INTCR0, host->ien0);
+		} else {
+			istat = 0;
+			shmmc_cmd_done(host);
+		}
+	}
+
+	/* card is no longer busy, cmd has ended */
+	if (istat & INTSTR_DBSYI) {
+		istat = 0;
+
+		host->ien0 &= ~INTCR0_DBSYIE;
+		MMC_OUTB(host, INTCR0, host->ien0);
+
+		shmmc_cmd_done(host);
+	}
+
+	return istat;
+}
+
+static inline void
+shmmc_read_fifo(struct shmmc_host *host, unsigned long cnt)
+{
+	unsigned short *sga;
+
+	/* get a pointer to physical RAM */
+	sga = (unsigned short *)P2SEGADDR(sg_dma_address(host->data->sg)
+					  + host->xfered);
+
+	host->xfered += cnt;
+	host->required -= cnt;
+
+	while (cnt > 1) {
+		*sga++ = be16_to_cpu(MMC_INW(host, DR));
+		cnt -= 2;
+	}
+
+	if (cnt)
+		*(unsigned char *)sga = MMC_INB(host, DR);
+}
+
+static inline void
+shmmc_write_fifo(struct shmmc_host *host, unsigned long cnt)
+{
+	unsigned short *sga;
+
+	/* get a pointer to physical RAM */
+	sga = (unsigned short *)P2SEGADDR(sg_dma_address(host->data->sg)
+					  + host->xfered);
+
+	host->xfered += cnt;
+	host->required -= cnt;
+
+	while (cnt > 1) {
+		MMC_OUTW(host, DR, cpu_to_be16(*sga++));
+		cnt -= 2;
+	}
+
+	if (cnt)
+		MMC_OUTB(host, DR, *(unsigned char *)sga);
+}
+
+static unsigned long
+shmmc_data_irq(struct shmmc_host *host, unsigned long istat)
+{
+	unsigned int j;
+
+	/* data crc error */
+	if (istat & INTSTR_CRCERI) {
+		host->data->error = -EILSEQ;
+		MMC_OUTB(host, OPCR, OPCR_CMDOFF);
+		shmmc_done(host);
+		return 0;
+	}
+
+	/* data timeout error */
+	if (istat & INTSTR_DTERI) {
+		host->data->error = -ETIMEDOUT;
+		MMC_OUTB(host, OPCR, OPCR_CMDOFF);
+		shmmc_done(host);
+		return 0;
+	}
+
+	/* FIFO full */
+	if (istat & INTSTR_FFI) {
+		istat &= ~INTSTR_FFI;
+
+		j = MMC_FIFO_SIZE;
+		if (host->required < j)
+			j = host->required;
+
+		/* read from fifo; modifies host->required! */
+		shmmc_read_fifo(host, j);
+		if (host->required < 1) {
+			host->ien0 &= ~INTCR0_FFIE;
+			host->ien1 &= ~INTCR1_DTERIE;
+			MMC_OUTB(host, INTCR0, host->ien0);
+			MMC_OUTB(host, INTCR1, host->ien1);
+
+			/* streams get no DTI irq, so we're done */
+			if (host->data->flags & MMC_DATA_STREAM)
+				shmmc_data_done(host);
+
+		} else {
+			/* FFI irq has halted receiver; re-enable it */
+			MMC_OUTB(host, OPCR, OPCR_RDCONT);
+		}
+	}
+
+	/* "1 block received"-irq; must be processed after FFI */
+	if (istat & INTSTR_DTI) {
+		istat &= ~INTSTR_DTI;
+
+		host->blocks--;
+		if (host->blocks < 1) {
+			host->ien0 &= ~INTCR0_DTIE;
+			MMC_OUTB(host, INTCR0, host->ien0);
+
+			/* for cases when required data < fifo size */
+			if ((host->required != 0) &&
+			    (host->data->flags & MMC_DATA_READ))
+				shmmc_read_fifo(host, host->required);
+
+			shmmc_data_done(host);
+		}
+	}
+
+	/*
+	 * FIFO empty. Fill it.
+	 * FIXME: how to deal with stream transfers? streams do not
+	 * generate the DRPI/DTI irqs!
+	 */
+	if (istat & INTSTR_FEI) {
+		istat &= ~INTSTR_FEI;
+
+		j = MMC_FIFO_SIZE;
+		if (host->required < j)
+			j = host->required;
+
+		if (j > 0) {
+			/* fill fifo; modifies host->required! */
+			shmmc_write_fifo(host, j);
+
+			if (host->required < 1) {
+				host->ien0 &= ~INTCR0_FEIE;
+				host->ien1 &= ~INTCR1_DTERIE;
+				MMC_OUTB(host, INTCR0, host->ien0);
+				MMC_OUTB(host, INTCR1, host->ien1);
+			}
+
+			/* FEI stopped transfer clock, start it again */
+			MMC_OUTB(host, OPCR, OPCR_DATAEN);
+		}
+	}
+
+	/* "1 block was written to the card"-irq */
+	if (istat & INTSTR_DRPI) {
+		istat &= ~INTSTR_DRPI;
+
+		host->blocks--;
+
+		host->ien0 |= INTCR0_DBSYIE;
+		host->ien0 &= ~INTCR0_DRPIE;
+		MMC_OUTB(host, INTCR0, host->ien0);
+		/*
+		 * card might now be busy writing the received
+		 * data. DBSYI should trigger next after card
+		 * has finished.
+		 */
+	}
+
+	/* the card is no longer busy, continue */
+	if (istat & INTSTR_DBSYI) {
+		istat &= ~INTSTR_DBSYI;
+
+		if (host->blocks < 1) {
+			istat = 0;
+			shmmc_data_done(host);
+		} else {
+			host->ien0 &= ~INTCR0_DBSYIE;
+			host->ien0 |= INTCR0_DRPIE;
+			MMC_OUTB(host, INTCR0, host->ien0);
+		}
+	}
+
+	return istat;
+}
+
+static irqreturn_t shmmc_irq(int irq, void *ptr)
+{
+	struct shmmc_host *host = ptr;
+	unsigned long istat;
+
+	istat = shmmc_getirqs(host);
+
+	/* SH7763 carddetect */
+	if (unlikely(istat & INTSTR_CDI)) {
+		istat &= ~INTSTR_CDI;
+		MMC_OUTB(host, INTSTR2, INTSTR2_CDI);	/* ack it */
+		mmc_detect_change(host->mmc, msecs_to_jiffies(500));
+	}
+
+	if ((istat & INTSTR_CMDIRQ) && (host->cmd))
+		istat = shmmc_cmd_irq(host, istat);
+
+	if ((istat & INTSTR_DATIRQ) && (host->data))
+		istat = shmmc_data_irq(host, istat);
+
+	if (istat)
+		pr_debug("unhandled IRQs: 0x%08lx\n", istat);
+
+	shmmc_clrirq(host);
+
+	return IRQ_HANDLED;
+}
+
+static void shmmc_prep_data(struct shmmc_host *host, struct mmc_data *data)
+{
+	unsigned int wl, blksz_bits;
+
+	MMC_OUTB(host, FIFOCLR, 0);
+	MMC_OUTB(host, TBCR, 0);
+
+	if (!data)
+		return;
+
+	if (data->flags & MMC_DATA_STREAM) {
+		printk(KERN_DEBUG "%s: stream transfers not yet supported!\n",
+			mmc_hostname(host->mmc));
+		BUG();
+	}
+
+	if (data->flags & MMC_DATA_READ) {
+		host->data_dir = DMA_FROM_DEVICE;
+		host->ien0 = INTCR0_FFIE;		/* fifo-full irq */
+	}
+
+	if (data->flags & MMC_DATA_WRITE) {
+		host->data_dir = DMA_TO_DEVICE;
+		host->ien0 = INTCR0_FEIE;		/* fifo-empty irq */
+		host->ien0 |= INTCR0_DRPIE;		/* data-response irq */
+	}
+
+	host->ien0 |= INTCR0_DTIE;	/* data-event irq */
+	host->ien1 |= INTCR1_DTERIE;	/* data-timeout irq */
+
+	host->blocks = data->blocks;
+	host->required = data->blocks * data->blksz;
+
+	/* no fifo irqs for small xfers. need to rely on DTI/DRPI */
+	if (host->required < MMC_FIFO_SIZE)
+		host->ien0 &= ~(INTCR0_FFIE | INTCR0_FEIE);
+
+	host->data = data;
+
+	blksz_bits = ffs(data->blksz) - 1;
+	BUG_ON((1 << blksz_bits) != data->blksz);
+	MMC_OUTB(host, TBCR, blksz_bits);
+#if (MMCIF_HWREV > 1)
+	MMC_OUTW(host, TBNCR, data->blocks);
+#endif
+
+	/* map S/G */
+	/* TODO: use SH DMAC */
+	dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len, host->data_dir);
+
+	/* IMPORTANT: pre-fill fifo with write data */
+	if (data->flags & MMC_DATA_WRITE) {
+		wl = MMC_FIFO_SIZE;
+		if (host->required < wl)
+			wl = host->required;
+		/* fill fifo; modifies host->required! */
+		shmmc_write_fifo(host, wl);
+		if (host->required < 1)
+			host->ien0 &= ~INTCR0_FEIE;
+	}
+}
+
+static void shmmc_request(struct mmc_host *mmc, struct mmc_request *req)
+{
+	struct shmmc_host *host = mmc_priv(mmc);
+
+	host->mrq = req;
+	host->data = NULL;
+	host->cmd = NULL;
+
+	host->ien0 = 0;
+	host->ien1 &= INTCR1_IRQEN;
+	host->ien2 &= INTCR2_CDIE | INTCR2_INTREQ3E;
+	host->blocks = 0;
+	host->xfered = 0;
+	host->required = 0;
+
+	MMC_OUTB(host, INTCR0, 0);
+	MMC_OUTB(host, INTCR1, 0);
+	MMC_OUTB(host, INTCR2, 0);
+	shmmc_clrirq(host);
+
+	if (0 = shmmc_card_inserted(mmc)) {
+		req->cmd->error = -ENOMEDIUM;
+		shmmc_done(host);
+		return;
+	}
+
+	shmmc_prep_data(host, req->data);
+	shmmc_cmd(host, req->cmd);
+}
+
+/* set IO parameters. The MMCIF can only set the MMC clock rate and
+ * nothing else.
+ */
+static void shmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct clk *clk;
+	struct shmmc_host *host = mmc_priv(mmc);
+	unsigned char tmp;
+	unsigned long hclk, reqclk;
+
+	/* mmcif clock is derived from peripheral clock via a
+	 * configurable divider.
+	 */
+	clk = clk_get(NULL, "module_clk");
+	reqclk = ios->clock;
+	hclk = clk->rate;
+	clk_put(clk);
+
+	tmp = 0;
+
+	if (reqclk) {
+#if (MMCIF_HWREV = 1)
+		/* SH7760: hclk/1, hclk/2, hclk/4, hclk/8, hclk/100 */
+		/* default: slowest: hclk/100 */
+		if (reqclk >= hclk)
+			tmp |= 4;	/* hclk/1 */
+		else if (reqclk >= (hclk >> 1))
+			tmp |= 3;	/* hclk/2 */
+		else if (reqclk >= (hclk >> 2))
+			tmp |= 2;	/* hclk/4 */
+		else if (reqclk >= (hclk >> 3))
+			tmp |= 1;	/* hclk/8 */
+#else
+		/* SH7763/80/85: hclk/(1 << x), 1<=x<=8 */
+		tmp = 1;
+		while (((hclk >> tmp) > reqclk) && (tmp < 8))
+			tmp++;
+#endif
+	}
+	host->clkon = tmp;
+
+	/* SH7763 MMCIF power signals. Cleared bits hold line low */
+#if (MMCIF_HWREV >= 3)
+	tmp = MMC_INB(host, VDCNT);
+	switch (ios->bus_mode) {
+	case MMC_BUSMODE_OPENDRAIN:
+		tmp &= ~VDCNT_ODMOD;
+		break;
+	case MMC_BUSMOD_PUSHPULL:
+		tmp |= VDCNT_ODMOD;
+		break;
+	}
+
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		tmp |= VDCNT_VDDON;
+		break;
+	case MMC_POWER_UP:
+	case MMC_POWER_ON:
+		tmp &= ~VDCNT_VDDON;
+		break;
+	}
+	MMC_OUTB(host, VDCNT, tmp);
+#endif
+
+	/* boards can do setup too if necessary */
+	if (host->platdata->setios)
+		host->platdata->setios(mmc, ios);
+}
+
+static struct mmc_host_ops shmmc_ops = {
+	.request	= shmmc_request,
+	.set_ios	= shmmc_set_ios,
+	.get_ro		= shmmc_card_readonly,
+	.get_cd		= shmmc_card_inserted,
+};
+
+static int shmmc_cd_setup(struct mmc_host *mmc)
+{
+	struct shmmc_host *host = mmc_priv(mmc);
+	struct shmmc_platdata *pd = host->platdata;
+	int ret;
+
+	ret = 0;
+
+	/* call the platform_data board-cd_init method if available */
+	if (pd && pd->cd_init && (0 = pd->cd_init(mmc)))
+		goto out;	/* awesome, all done */
+
+
+	/* if the MMCIF doesn't provide CD feature, we may need to enable
+	 * polling if the board doesn't forbid it.
+	 */
+	if ((MMCIF_HWREV < 3) || (pd && (pd->flags & SHMMC_NO_ONCHIP_CD)))
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	else {
+		host->ien1 |= INTCR1_IRQEN;
+		host->ien2 |= INTCR2_CDIE;
+		MMC_OUTB(host, INTCR1, host->ien1);
+		MMC_OUTB(host, INTCR2, host->ien2);
+		goto out;
+	}
+
+	if (pd && (pd->flags & SHMMC_NO_POLL)) {
+		mmc->caps &= ~MMC_CAP_NEEDS_POLL;
+		ret = 1;	/* no carddetect at all */
+	}
+
+out:
+	return ret;
+}
+
+static void shmmc_cd_exit(struct mmc_host *mmc)
+{
+	struct shmmc_host *host = mmc_priv(mmc);
+	struct shmmc_platdata *pd = host->platdata;
+
+	if (!(mmc->caps & MMC_CAP_NEEDS_POLL) && pd && pd->cd_exit)
+		pd->cd_exit(mmc);
+}
+
+/* register with the MMC core */
+static int __devinit shmmc_probe(struct platform_device *dev)
+{
+	struct mmc_host *mmc;
+	struct shmmc_host *host;
+	struct shmmc_platdata *pd;
+	struct resource *r;
+	struct clk *clk;
+	int ret;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	pd = dev->dev.platform_data;
+
+	mmc = mmc_alloc_host(sizeof(struct shmmc_host), &dev->dev);
+	if (!mmc)
+		return -ENOMEM;
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->platdata = pd;
+
+	ret = -EBUSY;
+	host->ioarea = request_mem_region(r->start, r->end - r->start + 1,
+					  dev->name);
+	if (!host->ioarea)
+		goto out0;
+
+	host->iobase = ioremap(r->start, r->end - r->start + 1);
+	if (!host->iobase)
+		goto out1;
+
+
+	/* MMC clock depends on Peripheral Clock, and a programmable
+	 * divider. Divider caps depend on MMCIF generation:
+	 * SH7760        can do: pclk, pclk/2, pclk/4, pclk/8, pclk/100
+	 * SH7763/SH7780 can do: pclk/(1 << x), with (1 <= x <= 8).
+	 */
+	clk = clk_get(NULL, "module_clk");
+	if (IS_ERR(clk)) {
+		dev_err(&dev->dev, "can't get module_clk!\n");
+		ret = PTR_ERR(clk);
+		goto out2;
+	}
+
+#if (MMCIF_HWREV = 1)
+	/* SH7760 */
+	mmc->f_min = (clk->rate / 100);
+	mmc->f_max = clk->rate;
+#else
+	/* SH7780/85/63 */
+	mmc->f_min = (clk->rate / 256);
+	mmc->f_max = (clk->rate / 2);
+#endif
+	clk_put(clk);
+
+	mmc->ocr_avail = pd->ocr;
+	mmc->caps = 0;
+
+	/* these can be up to 2^24 - 1 bytes as long as the
+	 * used memory area is physically contiguous.
+	 */
+	mmc->max_hw_segs = 1;
+	mmc->max_phys_segs = 1;
+	mmc->max_seg_size = 4096;
+
+	/* multiblock writes are badly broken, reads are okay however.
+	 * this here unfortunatelay works around multiwrite breakage
+	 * while killing read performance (by about 75%).
+	 */
+	mmc->max_blk_count = 1;
+
+	mmc->ops = &shmmc_ops;
+
+	host->mrq = NULL;
+	host->data = NULL;
+	host->cmd = NULL;
+
+#if (MMCIF_HWREV = 1)
+	/* This register exists only on SH7760, and there's only one
+	 * value allowed to be set: Receive data at rising clkedge.
+	 */
+	MMC_OUTB(host, RDTIMSEL, 1);
+#endif
+
+	host->ien0 = 0;
+	host->ien1 = INTCR1_IRQEN;
+	host->ien2 = 0;
+
+	MMC_OUTB(host, INTCR0, host->ien0);
+	MMC_OUTB(host, INTCR1, host->ien1);
+	MMC_OUTB(host, INTCR2, host->ien2);
+
+	shmmc_clrirq(host);
+
+	/* MMCIF IRQs. This assumes that the 3 (4 with DMA) irqs are
+	 * arranged consecutively (which is the case on 7760 and 7780)
+	 */
+	r = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (!r)
+		goto out2;
+
+	ret = request_irq(r->start, shmmc_irq, IRQF_DISABLED,
+				"mmcif-fifo", host);
+	if (ret)
+		goto out2;
+
+	ret = request_irq(r->start + 1, shmmc_irq, IRQF_DISABLED,
+				"mmcif-status", host);
+	if (ret)
+		goto out3;
+
+	ret = request_irq(r->start + 2, shmmc_irq, IRQF_DISABLED,
+				"mmcif-error", host);
+	if (ret)
+		goto out4;
+
+	ret = request_irq(r->start + 3, shmmc_irq, IRQF_DISABLED,
+				"mmcif-dma", host);
+	if (ret)
+		goto out5;
+
+	tasklet_init(&host->done_task, shmmc_done_tasklet,
+			(unsigned long)host);
+
+	ret = shmmc_cd_setup(mmc);
+	if (ret) {
+		dev_dbg(&dev->dev, "no suitable carddetect found\n");
+		goto out6;
+	}
+
+	/* does board implement SDIO irq? (MMCIF does not) */
+	if (pd && pd->enable_sdio_irq) {
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+		shmmc_ops.enable_sdio_irq = pd->enable_sdio_irq;
+	} else
+		shmmc_ops.enable_sdio_irq = NULL;
+
+	ret = mmc_add_host(mmc);
+	if (ret) {
+		dev_err(&dev->dev, "mmc_add_host failed\n");
+		goto out7;
+	}
+
+	platform_set_drvdata(dev, mmc);
+	printk(KERN_INFO "%s: SuperH MMCIF (gen %d) initialized\n",
+		mmc_hostname(mmc), MMCIF_HWREV);
+	return 0;
+
+out7:
+	shmmc_cd_exit(mmc);
+out6:
+	free_irq(r->start + 3, host);
+out5:
+	free_irq(r->start + 2, host);
+out4:
+	free_irq(r->start + 1, host);
+out3:
+	free_irq(r->start, host);
+out2:
+	iounmap(host->iobase);
+out1:
+	release_resource(host->ioarea);
+	kfree(host->ioarea);
+out0:
+	mmc_free_host(mmc);
+
+	return ret;
+}
+
+static int __devexit shmmc_remove(struct platform_device *dev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct shmmc_host *host = mmc_priv(mmc);
+	struct resource *r;
+
+	MMC_OUTB(host, INTCR0, 0);
+	MMC_OUTB(host, INTCR1, 0);
+	MMC_OUTB(host, INTCR2, 0);
+	shmmc_clrirq(host);
+	tasklet_disable(&host->done_task);
+	mmc_remove_host(mmc);
+	shmmc_cd_exit(mmc);
+	r = platform_get_resource(dev, IORESOURCE_IRQ, 0);
+	if (r) {
+		free_irq(r->start + 3, host);
+		free_irq(r->start + 2, host);
+		free_irq(r->start + 1, host);
+		free_irq(r->start, host);
+	}
+	tasklet_kill(&host->done_task);
+	iounmap(host->iobase);
+	release_resource(host->ioarea);
+	kfree(host->ioarea);
+	mmc_free_host(mmc);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int shmmc_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct shmmc_host *host = mmc_priv(mmc);
+	int ret;
+
+	ret = mmc_suspend_host(mmc, state);
+	if (ret)
+		return ret;
+
+	MMC_OUTB(host, INTCR0, 0);
+	MMC_OUTB(host, INTCR1, 0);
+
+	return 0;
+}
+
+static int shmmc_resume(struct platform_device *dev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct shmmc_host *host = mmc_priv(mmc);
+
+	MMC_OUTB(host, INTCR2, host->ien2);
+	MMC_OUTB(host, INTCR1, host->ien1);
+	MMC_OUTB(host, INTCR0, host->ien0);
+
+	return mmc_resume_host(mmc);
+}
+#else
+#define shmmc_suspend NULL
+#define shmmc_resume NULL
+#endif
+
+static struct platform_driver shmmc_driver = {
+	.driver	= {
+		.name	= SHMMC_DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe          = shmmc_probe,
+	.remove         = __devexit_p(shmmc_remove),
+	.suspend        = shmmc_suspend,
+	.resume         = shmmc_resume,
+};
+
+static int __init shmmc_drv_init(void)
+{
+	return platform_driver_register(&shmmc_driver);
+}
+
+static void __exit shmmc_drv_exit(void)
+{
+	platform_driver_unregister(&shmmc_driver);
+}
+
+module_init(shmmc_drv_init);
+module_exit(shmmc_drv_exit);
+
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_DESCRIPTION("SH7760 MMCIF driver");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-sh/mmc.h b/include/asm-sh/mmc.h
new file mode 100644
index 0000000..016695e
--- /dev/null
+++ b/include/asm-sh/mmc.h
@@ -0,0 +1,56 @@
+/*
+ * platform data for SH7760/SH7780 on-chip MMC interface
+ *
+ * see Documentation/sh/sh7760_mmc.txt
+ */
+#ifndef _SH_MMC_H_
+#define _SH_MMC_H_
+
+struct mmc_host;
+struct mmc_ios;
+
+/*
+ * cd_init:	Initialize board MMC functions. Can be NULL.
+ * cd_exit:	Shutdown the carddetect, and perform cleanup. Can be NULL.
+ * get_ro:	Return 1 when the card writeprotect switch is on. Set this
+ *		to NULL if you can't support switch detection.
+ * get_cd:	Return 1 when card is in socket. Set this member to NULL
+ *		if you cannot determine card presence.
+ * setios:	Set voltages if your board supports it. Set this member to NULL
+ *		if you can't control voltages on your board.
+ * ocr:		Set to supported voltages mask. use 0x00ffffff if you can't
+ *		set voltages on your board.
+ * enable_sdio_irq:	SDIO IRQ support. The MMCIF does not have native support
+ *		for SDIO IRQs, however if your board does have it implemented
+ *		in some manner then set this member, which will result in
+ *		the driver advertising SDIO capabilities.
+ * flags:	driver flags.
+ */
+
+
+/* set this flag to prevent the driver from falling back on the mmc core
+ * carddetect-poll implementation if no suitable better method can be
+ * found.
+ */
+#define SHMMC_NO_POLL		(1 << 0)
+
+/* set this flag to prevent use of built-in carddetect feature on SH7763
+ * if the cd_init() member is not set.  In that case the polling function
+ * of the MMC core will be used.
+ */
+#define SHMMC_NO_ONCHIP_CD	(1 << 1)
+
+struct shmmc_platdata {
+	int  (*cd_init)(struct mmc_host *);
+	void (*cd_exit)(struct mmc_host *);
+	int  (*get_ro)(struct mmc_host *);
+	int  (*get_cd)(struct mmc_host *);
+	void (*setios)(struct mmc_host *, struct mmc_ios *);
+	int  ocr;
+	void (*enable_sdio_irq)(struct mmc_host *, int);
+	int flags;
+};
+
+#define SHMMC_DRIVER_NAME	"sh-mmc"
+
+#endif
-- 
1.5.6.2

