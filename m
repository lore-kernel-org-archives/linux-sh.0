From: Rich Felker <dalias@libc.org>
Date: Fri, 22 Apr 2016 23:29:13 +0000
Subject: [PATCH 2/7] sh: add AT_HWCAP flag for J-Core cas.l instruction
Message-Id: <f6b971971962df746873e8f031204b042ae03e14.1461880061.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/include/uapi/asm/cpu-features.h | 1 +
 arch/sh/kernel/cpu/sh2/probe.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/sh/include/uapi/asm/cpu-features.h b/arch/sh/include/uapi/asm/cpu-features.h
index 694abe4..2f1bc85 100644
--- a/arch/sh/include/uapi/asm/cpu-features.h
+++ b/arch/sh/include/uapi/asm/cpu-features.h
@@ -22,5 +22,6 @@
 #define CPU_HAS_L2_CACHE	0x0080	/* Secondary cache / URAM */
 #define CPU_HAS_OP32		0x0100	/* 32-bit instruction support */
 #define CPU_HAS_PTEAEX		0x0200	/* PTE ASID Extension support */
+#define CPU_HAS_CAS_L		0x0400	/* cas.l atomic compare-and-swap */
 
 #endif /* __ASM_SH_CPU_FEATURES_H */
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
index d8dbb81..ecf8360 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -33,6 +33,8 @@ void cpu_probe(void)
 	boot_cpu_data.dcache.entry_shift	= 5;
 	boot_cpu_data.dcache.linesz		= 32;
 	boot_cpu_data.dcache.flags		= 0;
+
+	boot_cpu_data.flags |= CPU_HAS_CAS_L;
 #else
 	/*
 	 * SH-2 doesn't have separate caches
-- 
2.8.1


