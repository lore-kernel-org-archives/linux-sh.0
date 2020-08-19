From: Wang Hai <wanghai38@huawei.com>
Date: Wed, 19 Aug 2020 11:26:17 +0000
Subject: [PATCH -next] sh: mach-sh03: remove duplicate include
Message-Id: <20200819112617.6015-1-wanghai38@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove linux/rtc.h which is included more than once

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 arch/sh/boards/mach-sh03/rtc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
index 8b23ed7c201c..165e2ccaab4d 100644
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
2.17.1
