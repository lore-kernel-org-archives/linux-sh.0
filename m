From: jagdsh.linux@gmail.com
Date: Wed, 27 Mar 2019 16:21:05 +0000
Subject: [PATCH] arch:sh:mach-sh03/rtc.c : Remove duplicate header
Message-Id: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, paul.burton@mips.com, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Jagadeesh Pagadala <jagdsh.linux@gmail.com>

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sh/boards/mach-sh03/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 8b23ed7..165e2cc 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -14,7 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include <linux/rtc.h>
 #include <linux/platform_device.h>
 
 #define RTC_BASE	0xb0000000
-- 
1.8.3.1
