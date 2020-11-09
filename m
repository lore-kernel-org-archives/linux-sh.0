From: Wang Qing <wangqing@vivo.com>
Date: Mon, 09 Nov 2020 02:35:01 +0000
Subject: [PATCH] sh: mach-sh03: remove duplicate include
Message-Id: <1604889303-26722-1-git-send-email-wangqing@vivo.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Wang Qing <wangqing@vivo.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/sh/boards/mach-sh03/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 8b23ed7..7fb4748 100644
--- a/arch/sh/boards/mach-sh03/rtc.c
+++ b/arch/sh/boards/mach-sh03/rtc.c
@@ -11,7 +11,6 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/bcd.h>
-#include <linux/rtc.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/rtc.h>
-- 
2.7.4
