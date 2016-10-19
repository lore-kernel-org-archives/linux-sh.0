From: Rich Felker <dalias@libc.org>
Date: Wed, 19 Oct 2016 17:53:52 +0000
Subject: [PATCH] irqchip/jcore: don't show Kconfig menu item for driver
Message-Id: <883a3d17084003e3cf21bab73ec12828fe4ff6c6.1476899495.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>

Core drivers for J-Core SoCs will be selected implicitly via
CONFIG_SH_JCORE_SOC instead. Based on a corresponding change to the
clocksource/timer driver requested by Daniel Lezcano.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 43bed4e..c877910 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -157,8 +157,8 @@ config PIC32_EVIC
 	select IRQ_DOMAIN
 
 config JCORE_AIC
-	bool "J-Core integrated AIC"
-	depends on OF && (SUPERH || COMPILE_TEST)
+	bool "J-Core integrated AIC" if COMPILE_TEST
+	depends on OF
 	select IRQ_DOMAIN
 	help
 	  Support for the J-Core integrated AIC.
-- 
2.10.0

