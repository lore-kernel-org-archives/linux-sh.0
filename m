From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Fri, 05 Sep 2008 06:33:08 +0000
Subject: [PATCH] fix build failure when compiling without TRACE_IRQFLAGS_SUPPORT
Message-Id: <48C0D2A4.90208@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000406020805000203080408"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------000406020805000203080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,
playing with the kernel configuration we noticed that the
kernel doesn't build if TRACE_IRQFLAGS_SUPPORT is
forced off. So this patch just fixes it.

Anyway, we are wondering why it's not possible to disable
this option from Kconfig.
Reading the Documentation/irqflags-tracing.txt, this option is
"needed for CONFIG_PROVE_SPIN_LOCKING and
CONFIG_PROVE_RW_LOCKING to be offered by the generic
lock debugging code."
But we cannot find any references to PROVE_RW_LOCKING etc.
May be removed?

Best Regards,
Peppe & Carmelo

--------------000406020805000203080408
Content-Type: text/x-patch;
 name="linux-sh4-2.6.23.17_stm23_0116-fix_trace_irqflags.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="linux-sh4-2.6.23.17_stm23_0116-fix_trace_irqflags.patch"

This fixes the Kernel build failure when compiling without
TRACE_IRQFLAGS_SUPPORT.

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 412e025..7ccd276 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -41,10 +41,10 @@
 # define INIT_TRACE_IRQFLAGS
 #endif
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-
 #include <asm/irqflags.h>
 
+#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
+
 #define local_irq_enable() \
 	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
 #define local_irq_disable() \
@@ -67,13 +67,12 @@
  * The local_irq_*() APIs are equal to the raw_local_irq*()
  * if !TRACE_IRQFLAGS.
  */
-# define raw_local_irq_disable()	local_irq_disable()
-# define raw_local_irq_enable()		local_irq_enable()
-# define raw_local_irq_save(flags)	local_irq_save(flags)
-# define raw_local_irq_restore(flags)	local_irq_restore(flags)
+# define local_irq_disable() raw_local_irq_disable()
+# define local_irq_enable() raw_local_irq_enable()
+# define local_irq_save(flags) raw_local_irq_save(flags)
+# define local_irq_restore(flags) raw_local_irq_restore(flags)
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
-#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 #define safe_halt()						\
 	do {							\
 		trace_hardirqs_on();				\
@@ -91,6 +90,5 @@
 })
 
 #define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
-#endif		/* CONFIG_X86 */
 
 #endif

--------------000406020805000203080408--
