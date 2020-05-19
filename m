From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2020 13:13:13 +0000
Subject: [PATCH] sh: include linux/time_types.h for sockios
Message-Id: <20200519131327.1836482-1-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Using the socket ioctls on arch/sh (and only there) causes build
time problems when __kernel_old_timeval/__kernel_old_timespec are
not already visible to the compiler.

Add an explict include line for the header that defines these
structures.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/uapi/asm/sockios.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index 3da561453260..ef01ced9e169 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_SH_SOCKIOS_H
 #define __ASM_SH_SOCKIOS_H
 
+#include <linux/time_types.h>
+
 /* Socket-level I/O control calls. */
 #define FIOGETOWN	_IOR('f', 123, int)
 #define FIOSETOWN 	_IOW('f', 124, int)
-- 
2.26.2
