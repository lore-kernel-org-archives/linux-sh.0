From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 14:43:04 +0000
Subject: [PATCH 03/04] sh: add boot code to MMCIF driver header
Message-Id: <20100518144304.29239.85313.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a set of MMCIF functions for the romImage
boot loader that allows the kernel to be booted directly
from an MMC card.

Thanks to Jeremy Baker for the initial prototype.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 include/linux/mmc/sh_mmcif.h |  129 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

--- 0004/include/linux/mmc/sh_mmcif.h
+++ work/include/linux/mmc/sh_mmcif.h	2010-05-18 21:20:44.000000000 +0900
@@ -68,4 +68,133 @@ extern inline void sh_mmcif_writel(void 
 	writel(val, addr + reg);
 }
 
+#define SH_MMCIF_BBS 512 /* boot block size */
+
+extern inline void sh_mmcif_boot_cmd_send(void __iomem *base,
+					  unsigned long cmd, unsigned long arg)
+{
+	sh_mmcif_writel(base, MMCIF_CE_INT, 0);
+	sh_mmcif_writel(base, MMCIF_CE_ARG, arg);
+	sh_mmcif_writel(base, MMCIF_CE_CMD_SET, cmd);
+}
+
+extern inline int sh_mmcif_boot_cmd_poll(void __iomem *base, unsigned long mask)
+{
+	unsigned long tmp;
+	int cnt;
+
+	for (cnt = 0; cnt < 1000000; cnt++) {
+		tmp = sh_mmcif_readl(base, MMCIF_CE_INT);
+		if (tmp & mask) {
+			sh_mmcif_writel(base, MMCIF_CE_INT, tmp & ~mask);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+extern inline int sh_mmcif_boot_cmd(void __iomem *base,
+				    unsigned long cmd, unsigned long arg)
+{
+	sh_mmcif_boot_cmd_send(base, cmd, arg);
+	return sh_mmcif_boot_cmd_poll(base, 0x00010000);
+}
+
+extern inline int sh_mmcif_boot_do_read_single(void __iomem *base,
+					       unsigned int block_nr,
+					       unsigned long *buf)
+{
+	int k;
+
+	/* CMD13 - Status */
+	sh_mmcif_boot_cmd(base, 0x0d400000, 0x00010000);
+
+	if (sh_mmcif_readl(base, MMCIF_CE_RESP0) != 0x0900)
+		return -1;
+
+	/* CMD17 - Read */
+	sh_mmcif_boot_cmd(base, 0x11480000, block_nr * SH_MMCIF_BBS);
+	if (sh_mmcif_boot_cmd_poll(base, 0x00100000) < 0)
+		return -1;
+
+	for (k = 0; k < (SH_MMCIF_BBS / 4); k++)
+		buf[k] = sh_mmcif_readl(base, MMCIF_CE_DATA);
+
+	return 0;
+}
+
+extern inline int sh_mmcif_boot_do_read(void __iomem *base,
+					unsigned long first_block,
+					unsigned long nr_blocks,
+					void *buf)
+{
+	unsigned long k;
+	int ret = 0;
+
+	/* CMD16 - Set the block size */
+	sh_mmcif_boot_cmd(base, 0x10400000, SH_MMCIF_BBS);
+
+	for (k = 0; !ret && k < nr_blocks; k++)
+		ret = sh_mmcif_boot_do_read_single(base, first_block + k,
+						   buf + (k * SH_MMCIF_BBS));
+
+	return ret;
+}
+
+extern inline void sh_mmcif_boot_init(void __iomem *base)
+{
+	unsigned long tmp;
+
+	/* reset */
+	tmp = sh_mmcif_readl(base, MMCIF_CE_VERSION);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp | 0x80000000);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp & ~0x80000000);
+
+	/* byte swap */
+	sh_mmcif_writel(base, MMCIF_CE_BUF_ACC, 0x00010000);
+
+	/* Set block size in MMCIF hardware */
+	sh_mmcif_writel(base, MMCIF_CE_BLOCK_SET, SH_MMCIF_BBS);
+
+	/* Enable the clock, set it to Bus clock/256 (about 325Khz)*/
+	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL, 0x01072fff);
+
+	/* CMD0 */
+	sh_mmcif_boot_cmd(base, 0x00000040, 0);
+
+	/* CMD1 - Get OCR */
+	do {
+		sh_mmcif_boot_cmd(base, 0x01405040, 0x40300000); /* CMD1 */
+	} while ((sh_mmcif_readl(base, MMCIF_CE_RESP0) & 0x80000000)
+		 != 0x80000000);
+
+	/* CMD2 - Get CID */
+	sh_mmcif_boot_cmd(base, 0x02806040, 0);
+
+	/* CMD3 - Set card relative address */
+	sh_mmcif_boot_cmd(base, 0x03400040, 0x00010000);
+}
+
+extern inline void sh_mmcif_boot_slurp(void __iomem *base,
+				       unsigned char *buf,
+				       unsigned long no_bytes)
+{
+	unsigned long tmp;
+
+	/* In data transfer mode: Set clock to Bus clock/4 (about 20Mhz) */
+	sh_mmcif_writel(base, MMCIF_CE_CLK_CTRL, 0x01012fff);
+
+	/* CMD9 - Get CSD */
+	sh_mmcif_boot_cmd(base, 0x09806000, 0x00010000);
+
+	/* CMD7 - Select the card */
+	sh_mmcif_boot_cmd(base, 0x07400000, 0x00010000);
+
+	tmp = no_bytes / SH_MMCIF_BBS;
+	tmp += (no_bytes % SH_MMCIF_BBS) ? 1 : 0;
+
+	sh_mmcif_boot_do_read(base, 512, tmp, buf);
+}
+
 #endif /* __SH_MMCIF_H__ */
