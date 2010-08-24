From: Arnd Hannemann <arnd@arndnet.de>
Date: Tue, 24 Aug 2010 15:27:01 +0000
Subject: [PATCH 3/4] sh_mmcif: Allow the platform to specify own get_cd handler
Message-Id: <1282663622-20564-4-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com, Arnd Hannemann <arnd@arndnet.de>

In some platforms (e.g. AP4EVB) the card detect pin of a slot is not directly
connected to the sh_mmcif controller, so that polling needs to be used. To
overcome the overhead induced by querying the controller on each poll cycle,
card detection can be handled in the platform code more efficiently.
This patch exposes a get_cd hook for that purpose.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/sh_mmcif.c  |   12 ++++++++++++
 include/linux/mmc/sh_mmcif.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5d3f824..25eebbb 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -710,9 +710,21 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->bus_width = ios->bus_width;
 }
 
+static int sh_mmcif_get_cd(struct mmc_host *mmc)
+{
+	struct sh_mmcif_host *host = mmc_priv(mmc);
+	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+
+	if (!p->get_cd)
+		return -ENOSYS;
+	else
+		return p->get_cd(host->pd);
+}
+
 static struct mmc_host_ops sh_mmcif_ops = {
 	.request	= sh_mmcif_request,
 	.set_ios	= sh_mmcif_set_ios,
+	.get_cd		= sh_mmcif_get_cd,
 };
 
 static void sh_mmcif_detect(struct mmc_host *mmc)
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index d4a2ebb..d19e211 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -34,6 +34,7 @@
 struct sh_mmcif_plat_data {
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	void (*down_pwr)(struct platform_device *pdev);
+	int (*get_cd)(struct platform_device *pdef);
 	u8	sup_pclk;	/* 1 :SH7757, 0: SH7724/SH7372 */
 	unsigned long caps;
 	u32	ocr;
-- 
1.7.0.4

