From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2020 14:19:36 +0000
Subject: [PATCH] sh: remove spurious circular inclusion from asm/smp.h
Message-Id: <20200910141934.GF3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Commit 0cd39f4600ed4de8 added inclusion of smp.h to lockdep.h,
creating a circular include dependency where arch/sh's asm/smp.h in
turn includes spinlock.h which depends on lockdep.h. Since our
asm/smp.h does not actually need spinlock.h, just remove it.

Fixes: 0cd39f4600ed4de8 ("locking/seqlock, headers: Untangle the spaghetti monster")
Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/include/asm/smp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/include/asm/smp.h b/arch/sh/include/asm/smp.h
index 1a0d7cf71c10..100bf241340b 100644
--- a/arch/sh/include/asm/smp.h
+++ b/arch/sh/include/asm/smp.h
@@ -8,7 +8,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <asm/current.h>
 #include <asm/percpu.h>
-- 
2.21.0
