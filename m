From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 06:50:17 +0000
Subject: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement prefetch().
Message-Id: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GCC's __builtin_prefetch() was introduced a long time ago, all
supported GCC versions have it. So this patch is to use it for
implementing the prefetch on SH2A and SH4.

The current  prefetch implementation is almost equivalent with
__builtin_prefetch.
The third parameter in the __builtin_prefetch is the locality
that it's not supported on SH architectures.  It has been set
to three and it should be verified if it's suitable for SH2A
as well. I didn't test on this architecture.

The builtin usage should be more efficient that an __asm__
because less barriers, and because the compiler doesn't see the
inst as a "black box" allowing better code generation.

This has been already done on other architectures (see the commit:
0453fb3c528c5eb3483441a466b24a4cb409eec5).

Many thanks to Christian Bruel <christain.bruel@st.com> for his
support on evaluate the impact of the gcc built-in on SH4 arch.

No regressions found while testing with LMbench on STLinux targets.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
---
 arch/sh/include/asm/processor_32.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 46d5179..e3c73cd 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -199,10 +199,13 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define ARCH_HAS_PREFETCHW
 static inline void prefetch(void *x)
 {
-	__asm__ __volatile__ ("pref @%0\n\t" : : "r" (x) : "memory");
+	__builtin_prefetch(x, 0, 3);
 }
 
-#define prefetchw(x)	prefetch(x)
+static inline void prefetchw(void *x)
+{
+	__builtin_prefetch(x, 1, 3);
+}
 #endif
 
 #endif /* __KERNEL__ */
-- 
1.5.5.6

