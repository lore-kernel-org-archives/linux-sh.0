From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Jun 2012 13:23:16 +0000
Subject: [PATCH 3/9 v4] mmc: add two capability flags for CD and WP signal polarity
Message-Id: <1340371402-4801-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

To handle CD and WP SD/MMC slot pins we need generic flags to specify their
polarity.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4:

1. MMC_CAP2_*_ACTIVE_HIGH inverted compared to v3

 include/linux/mmc/host.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 90b6a38..c1a03ee 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -256,6 +256,8 @@ struct mmc_host {
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
+#define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
+#define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.2.5

