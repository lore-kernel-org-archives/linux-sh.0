From: Simon Horman <horms@verge.net.au>
Date: Fri, 26 Nov 2010 23:02:58 +0000
Subject: [PATCH 2/3] mmc, sh: Correct value for reset
Message-Id: <1290812579-20410-2-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1290812579-20410-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

This resolves a regression that I introduced in
"mmc, sh: Move constants to sh_mmcif.h". Having
examined the manual and tested the code on an AP4EVB board
it seems that the correct sequence is.

1) Write 1 to bit 31 and zeros to all other bits
2) Write zero to all bits

Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 include/linux/mmc/sh_mmcif.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index f216a88..519a2cd 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -87,7 +87,7 @@ struct sh_mmcif_plat_data {
 
 /* CE_VERSION */
 #define SOFT_RST_ON		(1 << 31)
-#define SOFT_RST_OFF		~SOFT_RST_ON
+#define SOFT_RST_OFF		0
 
 static inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
 {
@@ -175,12 +175,9 @@ static inline int sh_mmcif_boot_do_read(void __iomem *base,
 
 static inline void sh_mmcif_boot_init(void __iomem *base)
 {
-	unsigned long tmp;
-
 	/* reset */
-	tmp = sh_mmcif_readl(base, MMCIF_CE_VERSION);
-	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp | SOFT_RST_ON);
-	sh_mmcif_writel(base, MMCIF_CE_VERSION, tmp & SOFT_RST_OFF);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, SOFT_RST_ON);
+	sh_mmcif_writel(base, MMCIF_CE_VERSION, SOFT_RST_OFF);
 
 	/* byte swap */
 	sh_mmcif_writel(base, MMCIF_CE_BUF_ACC, BUF_ACC_ATYP);
-- 
1.7.2.3

