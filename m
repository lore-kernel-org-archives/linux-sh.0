From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 20:26:14 +0000
Subject: [PATCH] sh: support a 2-byte smp_store_mb
Message-Id: <1451507059-1224-1-git-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-sh@vger.kernel.org

At the moment, xchg on sh only supports 4 and 1 byte values, so using it
from smp_store_mb means attempts to store a 2 byte value using this
macro fail.

And happens to be exactly what virtio drivers want to do.

Check size and fall back to a slower, but safe, WRITE_ONCE+smp_mb.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: this is on top of my __smp_XXX barrier rework.
Please don't cherry-pick, please ack so I can
queue this in virtio tree together with driver change
that depends on it.

 arch/sh/include/asm/barrier.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
index f887c64..0cc5735 100644
--- a/arch/sh/include/asm/barrier.h
+++ b/arch/sh/include/asm/barrier.h
@@ -32,7 +32,15 @@
 #define ctrl_barrier()	__asm__ __volatile__ ("nop;nop;nop;nop;nop;nop;nop;nop")
 #endif
 
-#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
+#define __smp_store_mb(var, value) do { \
+	if (sizeof(var) != 4 && sizeof(var) != 1) { \
+		 WRITE_ONCE(var, value); \
+		__smp_mb(); \
+	} else { \
+		(void)xchg(&var, value);  \
+	} \
+} while (0)
+
 #define smp_store_mb(var, value) __smp_store_mb(var, value)
 
 #include <asm-generic/barrier.h>
-- 
MST
