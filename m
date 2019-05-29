From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Date: Wed, 29 May 2019 10:16:11 +0000
Subject: [PATCH] sh/intc: Fix obsolete function
Message-Id: <1559124971-13074-1-git-send-email-dingxiang@cmss.chinamobile.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

simple_strtoul is obsolete, use kstrtoul instead.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/sh/intc/userimask.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
index 87d69e7..d1d8e9b 100644
--- a/drivers/sh/intc/userimask.c
+++ b/drivers/sh/intc/userimask.c
@@ -33,7 +33,8 @@
 {
 	unsigned long level;
 
-	level = simple_strtoul(buf, NULL, 10);
+	if (kstrtoul(buf, 10, &level))
+		return -EINVAL;
 
 	/*
 	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
-- 
1.9.1
