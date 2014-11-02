From: Kevin Cernekee <cernekee@gmail.com>
Date: Sun, 02 Nov 2014 01:03:54 +0000
Subject: [PATCH V3 07/14] irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
Message-Id: <1414890241-9938-8-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org
Cc: linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

This can compile for MIPS (or anything else) now.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..09c79d1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
 
 config BRCMSTB_L2_IRQ
 	bool
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-- 
2.1.1

