From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Feb 2010 07:38:14 +0000
Subject: [PATCH 04/05] tmio_mmc: Remove const from platform data V3
Message-Id: <20100217073814.32726.87689.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100217073735.32726.12020.sendpatchset@t400s>
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

From: Magnus Damm <damm@opensource.se>

Remove const from the tmio-mmc platform data hclk V3.
This change makes it possible to remove the type cast
from the sh_mobile_sdhi driver which is using the clock
framework to get the clock rate.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Previously posted V2 to linux-mmc 20091126 as
 "[PATCH 02/03] mmc: Remove const from tmio-mmc platform data V2"

 Changes from V2:
 - rediff to fit on top of capabilities patch

 include/linux/mfd/tmio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0003/include/linux/mfd/tmio.h
+++ work/include/linux/mfd/tmio.h	2010-02-17 15:52:15.000000000 +0900
@@ -59,7 +59,7 @@ void tmio_core_mmc_clk_div(void __iomem 
  * data for the MMC controller
  */
 struct tmio_mmc_data {
-	const unsigned int		hclk;
+	unsigned int			hclk;
 	unsigned long			capabilities;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
