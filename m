From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Wed, 17 Nov 2010 09:27:19 +0000
Subject: [PATCH (sh-2.6)] sh: Use GCC __builtin_prefetch() to implement prefetch (V2)
Message-Id: <1289986039-24358-1-git-send-email-peppe.cavallaro@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
In-Reply-To: <1289976617-27704-1-git-send-email-peppe.cavallaro@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GCC's __builtin_prefetch() was introduced a long time ago, all
supported GCC versions have it.
So this patch removes the ARCH_HAS_PREFETCH and ARCH_HAS_PREFETCHW
macros, defined for SH2A and SH4 that will fall back on
__builtin_prefetch() through the generic code:
  include/linux/prefetch.h

The builtin usage should be more efficient that an __asm__
because less barriers, and because the compiler doesn't see the
inst as a "black box" allowing better code generation.
Many thanks to Christian Bruel <christain.bruel@st.com> for his
support on evaluate the impact of the gcc built-in on SH4 arch.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
---
 arch/sh/include/asm/processor_32.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index 46d5179..37417eb 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -195,14 +195,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #if defined(CONFIG_CPU_SH2A) || defined(CONFIG_CPU_SH4)
 #define PREFETCH_STRIDE		L1_CACHE_BYTES
-#define ARCH_HAS_PREFETCH
-#define ARCH_HAS_PREFETCHW
-static inline void prefetch(void *x)
-{
-	__asm__ __volatile__ ("pref @%0\n\t" : : "r" (x) : "memory");
-}
-
-#define prefetchw(x)	prefetch(x)
 #endif
 
 #endif /* __KERNEL__ */
-- 
1.5.5.6

