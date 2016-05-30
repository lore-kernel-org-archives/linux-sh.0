From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 30 May 2016 18:57:53 +0000
Subject: [PATCH v4 05/16] char/genrtc: remove alpha support
Message-Id: <1464634684-1248135-6-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The genrtc driver serves no purpose on Alpha because it drives the
same hardware as the original rtc.c driver, and the newer rtc-generic.c
or rtc-cmos.c drivers on architectures that use the asm-generic/rtc.h
header.

The defconfig uses CONFIG_RTC=y, so this driver is not used by default.
At one point it was used to abstract a quirk for the "Marvel" platform,
but it does not do this any more after the code was moved into yet
another driver in arch/alpha/kernel/rtc.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/rtc.h    | 1 -
 arch/alpha/kernel/core_marvel.c | 1 -
 drivers/char/Kconfig            | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)
 delete mode 100644 arch/alpha/include/asm/rtc.h

diff --git a/arch/alpha/include/asm/rtc.h b/arch/alpha/include/asm/rtc.h
deleted file mode 100644
index f71c3b0ed360..000000000000
--- a/arch/alpha/include/asm/rtc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/rtc.h>
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 53dd2f1a53aa..d5f0580746a5 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -24,7 +24,6 @@
 #include <asm/gct.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/rtc.h>
 #include <asm/vga.h>
 
 #include "proto.h"
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 31b5861649ee..e3f2f3e293e5 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -328,7 +328,7 @@ config JS_RTC
 config GEN_RTC
 	tristate "Generic /dev/rtc emulation"
 	depends on RTC!=y
-	depends on ALPHA || M68K || MN10300 || PARISC || PPC
+	depends on M68K || MN10300 || PARISC || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.7.0

