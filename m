From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Feb 2013 19:46:59 +0000
Subject: [PATCH v3 12/13] mmc: add DT bindings for more MMC capability flags
Message-Id: <1360180020-18555-13-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>

Many MMC capability flags are platform-dependent and are traditionally set
in platform data. With DT often each such capability requires a special
binding. Add bindings for MMC_CAP_SD_HIGHSPEED, MMC_CAP_MMC_HIGHSPEED,
MMC_CAP_POWER_OFF_CARD and MMC_CAP_SDIO_IRQ capabilities. Also add code to
DT parser to look up "keep-power-in-suspend" and "enable-sdio-wakeup"
bindings and set MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ respectively,
if found.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
---

v3: add cap-sdio-irq

 Documentation/devicetree/bindings/mmc/mmc.txt |    4 ++++
 drivers/mmc/core/host.c                       |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 51dd64f..a043c78 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -25,6 +25,10 @@ Optional properties:
 - max-frequency: maximum operating clock frequency
 - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
   this system, even if the controller claims it is.
+- cap-sd-highspeed: SD high-speed timing is supported
+- cap-mmc-highspeed: MMC high-speed timing is supported
+- cap-power-off-card: powering off the card is safe
+- cap-sdio-irq: enable SDIO IRQ signalling on this interface
 
 *NOTE* on CD and WP polarity. As of 3.8, SD/MMC drivers parse their DT nodes
 each in its own way, including calculation of CD and WP polarities. Our goal is
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c412612..56b6227 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -380,6 +380,19 @@ void mmc_of_parse(struct mmc_host *host)
 	}
 	if (explicit_inv_wp ^ gpio_inv_wp)
 		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+
+	if (of_find_property(np, "cap-sd-highspeed", &len))
+		host->caps |= MMC_CAP_SD_HIGHSPEED;
+	if (of_find_property(np, "cap-mmc-highspeed", &len))
+		host->caps |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_find_property(np, "cap-power-off-card", &len))
+		host->caps |= MMC_CAP_POWER_OFF_CARD;
+	if (of_find_property(np, "cap-sdio-irq", &len))
+		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (of_find_property(np, "keep-power-in-suspend", &len))
+		host->pm_caps |= MMC_PM_KEEP_POWER;
+	if (of_find_property(np, "enable-sdio-wakeup", &len))
+		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 
 EXPORT_SYMBOL(mmc_of_parse);
-- 
1.7.2.5

