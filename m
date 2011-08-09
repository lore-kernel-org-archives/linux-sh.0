From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 09 Aug 2011 08:07:01 +0000
Subject: [PATCH 08/13] ARM: gpio: ixp2000: convert drivers to use asm/gpio.h
Message-Id: <E1QqhL3-0003aT-HT@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/i2c/busses/i2c-ixp2000.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index 5d8aed5..be9991b 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -35,7 +35,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>	/* Pick up IXP2000-specific bits */
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 
 static inline int ixp2000_scl_pin(void *data)
 {
-- 
1.7.4.4

