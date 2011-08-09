From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 09 Aug 2011 08:07:21 +0000
Subject: [PATCH 09/13] ARM: gpio: tegra: convert drivers to use asm/gpio.h
Message-Id: <E1QqhLN-0003aX-Lg@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 18b0bd3..e9094f1 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -21,7 +21,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/sdhci.h>
 
 #include "sdhci-pltfm.h"
-- 
1.7.4.4

