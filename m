From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 20 Feb 2009 07:27:19 +0000
Subject: [PATCH 1/6] sh: Add support for SH7786 CPU subtype
Message-Id: <uljrxd2hk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


L2 cache doesn't support now.
This only support main cpu though sh7786 is multi core CPU.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/Kconfig                 |    7 +++++++
 arch/sh/include/asm/processor.h |    2 +-
 arch/sh/kernel/cpu/sh4/probe.c  |    7 +++++++
 arch/sh/kernel/setup.c          |    1 +
 arch/sh/oprofile/common.c       |    1 +
 5 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 78a01d7..0ae0968 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -356,6 +356,13 @@ config CPU_SUBTYPE_SH7785
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
 
+config CPU_SUBTYPE_SH7786
+	bool "Support SH7786 processor"
+	select CPU_SH4A
+	select CPU_SHX2
+	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_NUMA
+
 config CPU_SUBTYPE_SHX3
 	bool "Support SH-X3 processor"
 	select CPU_SH4A
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 1ef4b24..1fd58b4 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -31,7 +31,7 @@ enum cpu_type {
 	CPU_SH7760, CPU_SH4_202, CPU_SH4_501,
 
 	/* SH-4A types */
-	CPU_SH7763, CPU_SH7770, CPU_SH7780, CPU_SH7781, CPU_SH7785,
+	CPU_SH7763, CPU_SH7770, CPU_SH7780, CPU_SH7781, CPU_SH7785, CPU_SH7786,
 	CPU_SH7723, CPU_SHX3,
 
 	/* SH4AL-DSP types */
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.c
index 2e42572..2bd0ec9 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -129,6 +129,13 @@ int __init detect_cpu_and_cache_system(void)
 		boot_cpu_data.flags |= CPU_HAS_FPU | CPU_HAS_PERF_COUNTER |
 					  CPU_HAS_LLSC;
 		break;
+	case 0x4004:
+		boot_cpu_data.type = CPU_SH7786;
+		boot_cpu_data.icache.ways = 4;
+		boot_cpu_data.dcache.ways = 4;
+		boot_cpu_data.flags |= CPU_HAS_FPU | CPU_HAS_PERF_COUNTER |
+			CPU_HAS_LLSC;
+		break;
 	case 0x3008:
 		boot_cpu_data.icache.ways = 4;
 		boot_cpu_data.dcache.ways = 4;
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 370d2cf..61ab2a7 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -432,6 +432,7 @@ static const char *cpu_name[] = {
 	[CPU_SH7763]	= "SH7763",	[CPU_SH7770]	= "SH7770",
 	[CPU_SH7780]	= "SH7780",	[CPU_SH7781]	= "SH7781",
 	[CPU_SH7343]	= "SH7343",	[CPU_SH7785]	= "SH7785",
+	[CPU_SH7786]	= "SH7786",
 	[CPU_SH7722]	= "SH7722",	[CPU_SHX3]	= "SH-X3",
 	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
diff --git a/arch/sh/oprofile/common.c b/arch/sh/oprofile/common.c
index 1d97d64..1b9d430 100644
--- a/arch/sh/oprofile/common.c
+++ b/arch/sh/oprofile/common.c
@@ -107,6 +107,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_SH7780:
 	case CPU_SH7781:
 	case CPU_SH7785:
+	case CPU_SH7786:
 	case CPU_SH7723:
 	case CPU_SHX3:
 		lmodel = &op_model_sh4a_ops;
-- 
1.5.6.3

