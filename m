From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 30 May 2016 18:58:03 +0000
Subject: [PATCH v4 15/16] char/genrtc: remove asm-generic/rtc.h from mips
Message-Id: <1464634684-1248135-16-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1464634684-1248135-1-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

arch/mips/sni/time.c includes asm-generic/rtc.h for no apparent reason,
and it works fine without that header, so lets remove the inclusion
in preparation of deleting the file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/sni/time.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index fb4b3520cdc6..7ee14f41fc25 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -8,7 +8,6 @@
 
 #include <asm/sni.h>
 #include <asm/time.h>
-#include <asm-generic/rtc.h>
 
 #define SNI_CLOCK_TICK_RATE	3686400
 #define SNI_COUNTER2_DIV	64
-- 
2.7.0

