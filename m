From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 11 Dec 2018 07:20:55 +0000
Subject: [PATCH -next] sh: sh03: rtc: remove duplicated include from rtc.c
Message-Id: <1544512855-138362-1-git-send-email-yuehaibing@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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
