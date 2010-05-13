From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 13 May 2010 14:15:38 +0000
Subject: [PATCH 4a/9 v4] mmc: prepare tmio_mmc for passing of DMA configuration
Message-Id: <Pine.LNX.4.64.1005131604540.4671@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

After this patch, if the "dma" pointer in struct tmio_mmc_data is not NULL, it
points to a struct, containing two tokens, that have to be passed to the
dmaengine driver for channel configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3 -> v4:

tmio part of [PATCH 4a/9 v3], no changes in the code.

 include/linux/mfd/tmio.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index c3f7dff..360fc95 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -55,12 +55,18 @@ int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
 void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
 
+struct tmio_mmc_dma {
+	void *chan_priv_tx;
+	void *chan_priv_rx;
+};
+
 /*
  * data for the MMC controller
  */
 struct tmio_mmc_data {
 	unsigned int			hclk;
 	unsigned long			capabilities;
+	struct tmio_mmc_dma		*dma;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
1.6.2.4

