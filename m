From: Sasha Levin <sashal@kernel.org>
Date: Mon, 08 Jun 2020 23:05:14 +0000
Subject: [PATCH AUTOSEL 5.6 189/606] sh: include linux/time_types.h for sockios
Message-Id: <20200608231211.3363633-189-sashal@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit fc94cf2092c7c1267fa2deb8388d624f50eba808 upstream.

Using the socket ioctls on arch/sh (and only there) causes build time
problems when __kernel_old_timeval/__kernel_old_timespec are not already
visible to the compiler.

Add an explict include line for the header that defines these
structures.

Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200519131327.1836482-1-arnd@arndb.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.25.1
