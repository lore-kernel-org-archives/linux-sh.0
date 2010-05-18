From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 14:42:51 +0000
Subject: [PATCH 02/04] sh: prepare MMCIF driver header file
Message-Id: <20100518144251.29239.6655.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the MMCIF driver to include register information
and register access functions in the header file.
The MMCIF boot code builds on top of this.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/sh_mmcif.c  |  125 ++++++++++++++++--------------------------
 include/linux/mmc/sh_mmcif.h |   32 ++++++++++
 2 files changed, 82 insertions(+), 75 deletions(-)

--- 0003/drivers/mmc/host/sh_mmcif.c
+++ work/drivers/mmc/host/sh_mmcif.c	2010-05-18 21:04:37.000000000 +0900
@@ -30,25 +30,6 @@
 #define DRIVER_NAME	"sh_mmcif"
 #define DRIVER_VERSION	"2010-04-28"
 
-#define MMCIF_CE_CMD_SET	0x00000000
-#define MMCIF_CE_ARG		0x00000008
-#define MMCIF_CE_ARG_CMD12	0x0000000C
-#define MMCIF_CE_CMD_CTRL	0x00000010
-#define MMCIF_CE_BLOCK_SET	0x00000014
-#define MMCIF_CE_CLK_CTRL	0x00000018
-#define MMCIF_CE_BUF_ACC	0x0000001C
-#define MMCIF_CE_RESP3		0x00000020
-#define MMCIF_CE_RESP2		0x00000024
-#define MMCIF_CE_RESP1		0x00000028
-#define MMCIF_CE_RESP0		0x0000002C
-#define MMCIF_CE_RESP_CMD12	0x00000030
-#define MMCIF_CE_DATA		0x00000034
-#define MMCIF_CE_INT		0x00000040
-#define MMCIF_CE_INT_MASK	0x00000044
-#define MMCIF_CE_HOST_STS1	0x00000048
-#define MMCIF_CE_HOST_STS2	0x0000004C
-#define MMCIF_CE_VERSION	0x0000007C
-
 /* CE_CMD_SET */
 #define CMD_MASK		0x3f000000
 #define CMD_SET_RTYP_NO		((0 << 23) | (0 << 22))
@@ -207,27 +188,17 @@ struct sh_mmcif_host {
 	wait_queue_head_t intr_wait;
 };
 
-static inline u32 sh_mmcif_readl(struct sh_mmcif_host *host, unsigned int reg)
-{
-	return readl(host->addr + reg);
-}
-
-static inline void sh_mmcif_writel(struct sh_mmcif_host *host,
-					unsigned int reg, u32 val)
-{
-	writel(val, host->addr + reg);
-}
 
 static inline void sh_mmcif_bitset(struct sh_mmcif_host *host,
 					unsigned int reg, u32 val)
 {
-	writel(val | sh_mmcif_readl(host, reg), host->addr + reg);
+	writel(val | readl(host->addr + reg), host->addr + reg);
 }
 
 static inline void sh_mmcif_bitclr(struct sh_mmcif_host *host,
 					unsigned int reg, u32 val)
 {
-	writel(~val & sh_mmcif_readl(host, reg), host->addr + reg);
+	writel(~val & readl(host->addr + reg), host->addr + reg);
 }
 
 
@@ -253,10 +224,10 @@ static void sh_mmcif_sync_reset(struct s
 {
 	u32 tmp;
 
-	tmp = 0x010f0000 & sh_mmcif_readl(host, MMCIF_CE_CLK_CTRL);
+	tmp = 0x010f0000 & sh_mmcif_readl(host->addr, MMCIF_CE_CLK_CTRL);
 
-	sh_mmcif_writel(host, MMCIF_CE_VERSION, SOFT_RST_ON);
-	sh_mmcif_writel(host, MMCIF_CE_VERSION, SOFT_RST_OFF);
+	sh_mmcif_writel(host->addr, MMCIF_CE_VERSION, SOFT_RST_ON);
+	sh_mmcif_writel(host->addr, MMCIF_CE_VERSION, SOFT_RST_OFF);
 	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, tmp |
 		SRSPTO_256 | SRBSYTO_29 | SRWDTO_29 | SCCSTO_29);
 	/* byte swap on */
@@ -271,12 +242,10 @@ static int sh_mmcif_error_manage(struct 
 	host->sd_error = 0;
 	host->wait_int = 0;
 
-	state1 = sh_mmcif_readl(host, MMCIF_CE_HOST_STS1);
-	state2 = sh_mmcif_readl(host, MMCIF_CE_HOST_STS2);
-	pr_debug("%s: ERR HOST_STS1 = %08x\n", \
-			DRIVER_NAME, sh_mmcif_readl(host, MMCIF_CE_HOST_STS1));
-	pr_debug("%s: ERR HOST_STS2 = %08x\n", \
-			DRIVER_NAME, sh_mmcif_readl(host, MMCIF_CE_HOST_STS2));
+	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
+	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
+	pr_debug("%s: ERR HOST_STS1 = %08x\n", DRIVER_NAME, state1);
+	pr_debug("%s: ERR HOST_STS2 = %08x\n", DRIVER_NAME, state2);
 
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
@@ -288,7 +257,7 @@ static int sh_mmcif_error_manage(struct 
 					"command sequence timeout err\n");
 				return -EIO;
 			}
-			if (!(sh_mmcif_readl(host, MMCIF_CE_HOST_STS1)
+			if (!(sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1)
 								& STS1_CMDSEQ))
 				break;
 			mdelay(1);
@@ -330,9 +299,9 @@ static int sh_mmcif_single_read(struct s
 
 	host->wait_int = 0;
 	blocksize = (BLOCK_SIZE_MASK &
-			sh_mmcif_readl(host, MMCIF_CE_BLOCK_SET)) + 3;
+			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
 	for (i = 0; i < blocksize / 4; i++)
-		*p++ = sh_mmcif_readl(host, MMCIF_CE_DATA);
+		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
 
 	/* buffer read end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
@@ -353,7 +322,8 @@ static int sh_mmcif_multi_read(struct sh
 	long time;
 	u32 blocksize, i, j, sec, *p;
 
-	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host, MMCIF_CE_BLOCK_SET);
+	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host->addr,
+						     MMCIF_CE_BLOCK_SET);
 	for (j = 0; j < data->sg_len; j++) {
 		p = sg_virt(data->sg);
 		host->wait_int = 0;
@@ -370,7 +340,8 @@ static int sh_mmcif_multi_read(struct sh
 
 			host->wait_int = 0;
 			for (i = 0; i < blocksize / 4; i++)
-				*p++ = sh_mmcif_readl(host, MMCIF_CE_DATA);
+				*p++ = sh_mmcif_readl(host->addr,
+						      MMCIF_CE_DATA);
 		}
 		if (j < data->sg_len - 1)
 			data->sg++;
@@ -397,9 +368,9 @@ static int sh_mmcif_single_write(struct 
 
 	host->wait_int = 0;
 	blocksize = (BLOCK_SIZE_MASK &
-			sh_mmcif_readl(host, MMCIF_CE_BLOCK_SET)) + 3;
+			sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET)) + 3;
 	for (i = 0; i < blocksize / 4; i++)
-		sh_mmcif_writel(host, MMCIF_CE_DATA, *p++);
+		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
 
 	/* buffer write end */
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
@@ -421,7 +392,8 @@ static int sh_mmcif_multi_write(struct s
 	long time;
 	u32 i, sec, j, blocksize, *p;
 
-	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host, MMCIF_CE_BLOCK_SET);
+	blocksize = BLOCK_SIZE_MASK & sh_mmcif_readl(host->addr,
+						     MMCIF_CE_BLOCK_SET);
 
 	for (j = 0; j < data->sg_len; j++) {
 		p = sg_virt(data->sg);
@@ -439,7 +411,8 @@ static int sh_mmcif_multi_write(struct s
 
 			host->wait_int = 0;
 			for (i = 0; i < blocksize / 4; i++)
-				sh_mmcif_writel(host, MMCIF_CE_DATA, *p++);
+				sh_mmcif_writel(host->addr,
+						MMCIF_CE_DATA, *p++);
 		}
 		if (j < data->sg_len - 1)
 			data->sg++;
@@ -451,18 +424,18 @@ static void sh_mmcif_get_response(struct
 						struct mmc_command *cmd)
 {
 	if (cmd->flags & MMC_RSP_136) {
-		cmd->resp[0] = sh_mmcif_readl(host, MMCIF_CE_RESP3);
-		cmd->resp[1] = sh_mmcif_readl(host, MMCIF_CE_RESP2);
-		cmd->resp[2] = sh_mmcif_readl(host, MMCIF_CE_RESP1);
-		cmd->resp[3] = sh_mmcif_readl(host, MMCIF_CE_RESP0);
+		cmd->resp[0] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP3);
+		cmd->resp[1] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP2);
+		cmd->resp[2] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP1);
+		cmd->resp[3] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP0);
 	} else
-		cmd->resp[0] = sh_mmcif_readl(host, MMCIF_CE_RESP0);
+		cmd->resp[0] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP0);
 }
 
 static void sh_mmcif_get_cmd12response(struct sh_mmcif_host *host,
 						struct mmc_command *cmd)
 {
-	cmd->resp[0] = sh_mmcif_readl(host, MMCIF_CE_RESP_CMD12);
+	cmd->resp[0] = sh_mmcif_readl(host->addr, MMCIF_CE_RESP_CMD12);
 }
 
 static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
@@ -596,18 +569,19 @@ static void sh_mmcif_start_cmd(struct sh
 		MASK_MRDATTO | MASK_MRBSYTO | MASK_MRSPTO;
 
 	if (host->data) {
-		sh_mmcif_writel(host, MMCIF_CE_BLOCK_SET, 0);
-		sh_mmcif_writel(host, MMCIF_CE_BLOCK_SET, mrq->data->blksz);
+		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET, 0);
+		sh_mmcif_writel(host->addr, MMCIF_CE_BLOCK_SET,
+				mrq->data->blksz);
 	}
 	opc = sh_mmcif_set_cmd(host, mrq, cmd, opc);
 
-	sh_mmcif_writel(host, MMCIF_CE_INT, 0xD80430C0);
-	sh_mmcif_writel(host, MMCIF_CE_INT_MASK, mask);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT, 0xD80430C0);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, mask);
 	/* set arg */
-	sh_mmcif_writel(host, MMCIF_CE_ARG, cmd->arg);
+	sh_mmcif_writel(host->addr, MMCIF_CE_ARG, cmd->arg);
 	host->wait_int = 0;
 	/* set cmd */
-	sh_mmcif_writel(host, MMCIF_CE_CMD_SET, opc);
+	sh_mmcif_writel(host->addr, MMCIF_CE_CMD_SET, opc);
 
 	time = wait_event_interruptible_timeout(host->intr_wait,
 		host->wait_int = 1 || host->sd_error = 1, host->timeout);
@@ -752,43 +726,44 @@ static irqreturn_t sh_mmcif_intr(int irq
 	u32 state = 0;
 	int err = 0;
 
-	state = sh_mmcif_readl(host, MMCIF_CE_INT);
+	state = sh_mmcif_readl(host->addr, MMCIF_CE_INT);
 
 	if (state & INT_RBSYE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~(INT_RBSYE | INT_CRSPE));
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
+				~(INT_RBSYE | INT_CRSPE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MRBSYE);
 	} else if (state & INT_CRSPE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~INT_CRSPE);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_CRSPE);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCRSPE);
 	} else if (state & INT_BUFREN) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~INT_BUFREN);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFREN);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 	} else if (state & INT_BUFWEN) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~INT_BUFWEN);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFWEN);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 	} else if (state & INT_CMD12DRE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT,
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
 			~(INT_CMD12DRE | INT_CMD12RBE |
 			  INT_CMD12CRE | INT_BUFRE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCMD12DRE);
 	} else if (state & INT_BUFRE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~INT_BUFRE);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_BUFRE);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MBUFRE);
 	} else if (state & INT_DTRANE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~INT_DTRANE);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~INT_DTRANE);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MDTRANE);
 	} else if (state & INT_CMD12RBE) {
-		sh_mmcif_writel(host, MMCIF_CE_INT,
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT,
 				~(INT_CMD12RBE | INT_CMD12CRE));
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, MASK_MCMD12RBE);
 	} else if (state & INT_ERR_STS) {
 		/* err interrupts */
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~state);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	} else {
 		pr_debug("%s: Not support int\n", DRIVER_NAME);
-		sh_mmcif_writel(host, MMCIF_CE_INT, ~state);
+		sh_mmcif_writel(host->addr, MMCIF_CE_INT, ~state);
 		sh_mmcif_bitclr(host, MMCIF_CE_INT_MASK, state);
 		err = 1;
 	}
@@ -894,12 +869,12 @@ static int __devinit sh_mmcif_probe(stru
 		goto clean_up2;
 	}
 
-	sh_mmcif_writel(host, MMCIF_CE_INT_MASK, MASK_ALL);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 	sh_mmcif_detect(host->mmc);
 
 	pr_info("%s: driver version %s\n", DRIVER_NAME, DRIVER_VERSION);
 	pr_debug("%s: chip ver H'%04x\n", DRIVER_NAME,
-			sh_mmcif_readl(host, MMCIF_CE_VERSION) & 0x0000ffff);
+		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
 clean_up2:
@@ -917,7 +892,7 @@ static int __devexit sh_mmcif_remove(str
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
 	int irq[2];
 
-	sh_mmcif_writel(host, MMCIF_CE_INT_MASK, MASK_ALL);
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
--- 0003/include/linux/mmc/sh_mmcif.h
+++ work/include/linux/mmc/sh_mmcif.h	2010-05-18 21:06:15.000000000 +0900
@@ -14,6 +14,9 @@
 #ifndef __SH_MMCIF_H__
 #define __SH_MMCIF_H__
 
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
 /*
  * MMCIF : CE_CLK_CTRL [19:16]
  * 1000 : Peripheral clock / 512
@@ -36,4 +39,33 @@ struct sh_mmcif_plat_data {
 	u32	ocr;
 };
 
+#define MMCIF_CE_CMD_SET	0x00000000
+#define MMCIF_CE_ARG		0x00000008
+#define MMCIF_CE_ARG_CMD12	0x0000000C
+#define MMCIF_CE_CMD_CTRL	0x00000010
+#define MMCIF_CE_BLOCK_SET	0x00000014
+#define MMCIF_CE_CLK_CTRL	0x00000018
+#define MMCIF_CE_BUF_ACC	0x0000001C
+#define MMCIF_CE_RESP3		0x00000020
+#define MMCIF_CE_RESP2		0x00000024
+#define MMCIF_CE_RESP1		0x00000028
+#define MMCIF_CE_RESP0		0x0000002C
+#define MMCIF_CE_RESP_CMD12	0x00000030
+#define MMCIF_CE_DATA		0x00000034
+#define MMCIF_CE_INT		0x00000040
+#define MMCIF_CE_INT_MASK	0x00000044
+#define MMCIF_CE_HOST_STS1	0x00000048
+#define MMCIF_CE_HOST_STS2	0x0000004C
+#define MMCIF_CE_VERSION	0x0000007C
+
+extern inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
+{
+	return readl(addr + reg);
+}
+
+extern inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
+{
+	writel(val, addr + reg);
+}
+
 #endif /* __SH_MMCIF_H__ */
