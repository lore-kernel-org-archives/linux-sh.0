From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 09 Aug 2011 08:06:01 +0000
Subject: [PATCH 05/13] ARM: gpio: nomadik: convert drivers to use asm/gpio.h
Message-Id: <E1QqhK5-0003aG-5F@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpio/gpio-nomadik.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 2c212c7..f7f0406 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -28,7 +28,7 @@
 
 #include <plat/pincfg.h>
 #include <mach/hardware.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 /*
  * The GPIO module in the Nomadik family of Systems-on-Chip is an
-- 
1.7.4.4

