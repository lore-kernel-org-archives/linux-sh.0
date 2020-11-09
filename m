From: Wang Qing <wangqing@vivo.com>
Date: Mon, 09 Nov 2020 02:45:51 +0000
Subject: [PATCH] arch: sh: remove duplicate include
Message-Id: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Wang Qing <wangqing@vivo.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/sh/kernel/cpu/sh3/entry.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
index 25eb809..e48b3dd
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -14,7 +14,6 @@
 #include <cpu/mmu_context.h>
 #include <asm/page.h>
 #include <asm/cache.h>
-#include <asm/thread_info.h>
 
 ! NOTE:
 ! GNU as (as of 2.9.1) changes bf/s into bt/s and bra, when the address
-- 
2.7.4
