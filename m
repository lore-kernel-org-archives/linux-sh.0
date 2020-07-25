From: Yi Wang <wang.yi59@zte.com.cn>
Date: Sat, 25 Jul 2020 00:17:26 +0000
Subject: [PATCH] sh: sh4: Fix reference count leak in sq_dev_add
Message-Id: <1595636246-15392-1-git-send-email-wang.yi59@zte.com.cn>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp
Cc: dalias@libc.org, akpm@linux-foundation.org, peterz@infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

kobject_init_and_add() takes reference even when it fails. If this
function returns an error, kobject_put() must be called to properly
clean up the memory associated with the object.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/sh/kernel/cpu/sh4/sq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index d432164..3fbd6fd 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -350,6 +350,8 @@ static int sq_dev_add(struct device *dev, struct subsys_interface *sif)
 				     "%s", "sq");
 	if (!error)
 		kobject_uevent(kobj, KOBJ_ADD);
+	else
+		kobject_put(kobj);
 	return error;
 }
 
-- 
2.9.5
