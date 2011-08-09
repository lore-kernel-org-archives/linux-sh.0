From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 09 Aug 2011 08:06:21 +0000
Subject: [PATCH 06/13] ARM: gpio: davinci: convert drivers to use asm/gpio.h
Message-Id: <E1QqhKP-0003aK-9R@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
In-Reply-To: <20110809080411.GA1831@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/usb/musb/davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 8bdf25a..f9a3f62 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -35,7 +35,7 @@
 
 #include <mach/hardware.h>
 #include <mach/memory.h>
-#include <mach/gpio.h>
+#include <asm/gpio.h>
 #include <mach/cputype.h>
 
 #include <asm/mach-types.h>
-- 
1.7.4.4

