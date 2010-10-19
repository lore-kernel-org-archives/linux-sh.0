From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 19 Oct 2010 01:43:29 +0000
Subject: [RFC/PATCH] sh: Add 32bit cou mode to cpu_flags
Message-Id: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is not method to confirm which of 32bit mode or 29bit mode Linux
kernel works.
This patch adds a mode to cpu_flags and can confirm it from auxv and proc
filesystem.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/cpu-features.h |    1 +
 arch/sh/kernel/cpu/sh4/probe.c     |    4 ++++
 arch/sh/kernel/setup.c             |    8 +++++++-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/cpu-features.h b/arch/sh/include/asm/cpu-features.h
index 694abe4..dc1265b 100644
--- a/arch/sh/include/asm/cpu-features.h
+++ b/arch/sh/include/asm/cpu-features.h
@@ -22,5 +22,6 @@
 #define CPU_HAS_L2_CACHE	0x0080	/* Secondary cache / URAM */
 #define CPU_HAS_OP32		0x0100	/* 32-bit instruction support */
 #define CPU_HAS_PTEAEX		0x0200	/* PTE ASID Extension support */
+#define CPU_IS_32BIT_MODE	0x0400	/* linux kernel works 32bit mode */
 
 #endif /* __ASM_SH_CPU_FEATURES_H */
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index b93458f..4bda234 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -189,6 +189,10 @@ void __cpuinit cpu_probe(void)
 		break;
 	}
 
+#ifdef CONFIG_32BIT
+	boot_cpu_data.flags |= CPU_IS_32BIT_MODE;
+#endif
+
 	/*
 	 * On anything that's not a direct-mapped cache, look to the CVR
 	 * for I/D-cache specifics.
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 4e27846..460ac72 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -352,7 +352,8 @@ EXPORT_SYMBOL(get_cpu_subtype);
 /* Symbolic CPU flags, keep in sync with asm/cpu-features.h */
 static const char *cpu_flags[] = {
 	"none", "fpu", "p2flush", "mmuassoc", "dsp", "perfctr",
-	"ptea", "llsc", "l2", "op32", "pteaex", NULL
+	"ptea", "llsc", "l2", "op32", "pteaex", "32bit",
+	NULL
 };
 
 static void show_cpuflags(struct seq_file *m, struct sh_cpuinfo *c)
@@ -410,6 +411,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	else
 		seq_printf(m, "cut\t\t: %d.%d\n", c->cut_major, c->cut_minor);
 
+	if (c->flags & CPU_IS_32BIT_MODE)
+		seq_printf(m, "cpu mode\t: 32bit\n");
+	else
+		seq_printf(m, "cpu mode\t: 29bit\n");
+
 	show_cpuflags(m, c);
 
 	seq_printf(m, "cache type\t: ");
-- 
1.7.1

