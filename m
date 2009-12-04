From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:44 +0000
Subject: [PATCH (sh-2.6.30.y) 02/13] stm: pm: Preliminary pm integration
Message-Id: <1259938375-27499-2-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch
 - adds the PM_Standby support to the ST40 micros
 - fixes some files to support hibernation on ST40 vs Sh code

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/Kconfig                 |    1 +
 arch/sh/include/asm/suspend.h   |   12 ------------
 arch/sh/kernel/Makefile_32      |    2 +-
 arch/sh/kernel/asm-offsets.c    |    2 ++
 arch/sh/kernel/cpu/sh4/Makefile |   18 ++----------------
 5 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 14fb721..d435f0b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -168,6 +168,7 @@ config CPU_SUBTYPE_ST40
 	select CPU_SH4
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SUSPEND_POSSIBLE
 
 config CPU_ST40_300
 	bool
diff --git a/arch/sh/include/asm/suspend.h b/arch/sh/include/asm/suspend.h
index 9a2c890..b1b9953 100644
--- a/arch/sh/include/asm/suspend.h
+++ b/arch/sh/include/asm/suspend.h
@@ -4,18 +4,6 @@
 #ifndef __ASSEMBLY__
 static inline int arch_prepare_suspend(void) { return 0; }
 
-static inline void save_processor_state(void)
-{
-	return;
-}
-
-static inline void restore_processor_state(void)
-{
-	return;
-}
-
-extern const unsigned long __nosave_begin, __nosave_end;
-
 #include <asm/ptrace.h>
 
 struct swsusp_arch_regs {
diff --git a/arch/sh/kernel/Makefile_32 b/arch/sh/kernel/Makefile_32
index 8258571..6c28322 100644
--- a/arch/sh/kernel/Makefile_32
+++ b/arch/sh/kernel/Makefile_32
@@ -14,7 +14,7 @@ obj-y	:= debugtraps.o idle.o io.o io_generic.o irq.o			\
 	   sys_sh.o sys_sh32.o syscalls_32.o time_32.o topology.o	\
 	   traps.o traps_32.o
 
-obj-y				+= cpu/ timers/
+obj-y				+= cpu/ timers/ pm/
 obj-$(CONFIG_VSYSCALL)		+= vsyscall/
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
diff --git a/arch/sh/kernel/asm-offsets.c b/arch/sh/kernel/asm-offsets.c
index d2fa0c5..ba2ba6d 100644
--- a/arch/sh/kernel/asm-offsets.c
+++ b/arch/sh/kernel/asm-offsets.c
@@ -29,11 +29,13 @@ int main(void)
 
 	DEFINE(_PTRS_PER_PGD,	PTRS_PER_PGD);
 
+#ifndef CONFIG_CPU_SUBTYPE_ST40
 #ifdef CONFIG_HIBERNATION
 	DEFINE(PBE_ADDRESS, offsetof(struct pbe, address));
 	DEFINE(PBE_ORIG_ADDRESS, offsetof(struct pbe, orig_address));
 	DEFINE(PBE_NEXT, offsetof(struct pbe, next));
 	DEFINE(SWSUSP_ARCH_REGS_SIZE, sizeof(struct swsusp_arch_regs));
 #endif
+#endif
 	return 0;
 }
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index 456237b..85debb4 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -5,7 +5,9 @@
 obj-y	:= probe.o common.o
 common-y	+= entry.o
 
+ifndef CONFIG_CPU_SUBTYPE_ST40
 obj-$(CONFIG_HIBERNATION)		+= $(addprefix ../sh3/, swsusp.o)
+endif
 obj-$(CONFIG_SH_FPU)			+= fpu.o softfloat.o
 obj-$(CONFIG_SH_STORE_QUEUES)		+= sq.o
 
@@ -41,19 +43,3 @@ endif
 clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
 
 obj-y	+= $(clock-y)
-
-obj-$(CONFIG_STM_CPU_FREQ)		+= cpufreq-stm.o
-
-ifdef CONFIG_SUSPEND
-obj-y					+= suspend.o suspend-core.o
-obj-$(CONFIG_CPU_SUBTYPE_STX5197)	+= suspend-stx5197.o
-obj-$(CONFIG_CPU_SUBTYPE_STX7100)	+= suspend-stx7100.o
-obj-$(CONFIG_CPU_SUBTYPE_STX7105)	+= suspend-stx7105.o
-obj-$(CONFIG_CPU_SUBTYPE_STX7111)	+= suspend-stx7111.o
-obj-$(CONFIG_CPU_SUBTYPE_STX7141)	+= suspend-stx7141.o
-obj-$(CONFIG_CPU_SUBTYPE_STX7200)	+= suspend-stx7200.o
-endif
-
-ifdef CONFIG_HIBERNATION
-obj-y					+= cpu.o swsusp.o
-endif
-- 
1.6.2.5

