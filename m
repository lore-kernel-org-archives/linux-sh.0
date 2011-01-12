From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Jan 2011 10:54:21 +0000
Subject: [PATCH] sh: sh7372 SH4AL-DSP probe support
Message-Id: <20110112105421.11079.83096.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add probe support for the sh7372 SH4AL-DSP core.

The most common use case for this is when the system
boots from the ARM core in the sh7372 and uses the
SH core for application offload as a slave CPU.

May also be used to boot the sh7372 from the SH core.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/processor.h |    2 +-
 arch/sh/kernel/cpu/proc.c       |    2 +-
 arch/sh/kernel/cpu/sh4/probe.c  |    5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- 0001/arch/sh/include/asm/processor.h
+++ work/arch/sh/include/asm/processor.h	2011-01-12 19:19:56.000000000 +0900
@@ -35,7 +35,7 @@ enum cpu_type {
 	CPU_SH7723, CPU_SH7724, CPU_SH7757, CPU_SHX3,
 
 	/* SH4AL-DSP types */
-	CPU_SH7343, CPU_SH7722, CPU_SH7366,
+	CPU_SH7343, CPU_SH7722, CPU_SH7366, CPU_SH7372,
 
 	/* SH-5 types */
         CPU_SH5_101, CPU_SH5_103,
--- 0001/arch/sh/kernel/cpu/proc.c
+++ work/arch/sh/kernel/cpu/proc.c	2011-01-12 19:24:22.000000000 +0900
@@ -25,7 +25,7 @@ static const char *cpu_name[] = {
 	[CPU_SH5_101]	= "SH5-101",	[CPU_SH5_103]	= "SH5-103",
 	[CPU_MXG]	= "MX-G",	[CPU_SH7723]	= "SH7723",
 	[CPU_SH7366]	= "SH7366",	[CPU_SH7724]	= "SH7724",
-	[CPU_SH_NONE]	= "Unknown"
+	[CPU_SH7372]	= "SH7372",	[CPU_SH_NONE]	= "Unknown"
 };
 
 const char *get_cpu_subtype(struct sh_cpuinfo *c)
--- 0001/arch/sh/kernel/cpu/sh4/probe.c
+++ work/arch/sh/kernel/cpu/sh4/probe.c	2011-01-12 19:24:02.000000000 +0900
@@ -154,6 +154,11 @@ void __cpuinit cpu_probe(void)
 		case 0x11:
 			boot_cpu_data.type = CPU_SH7757;
 			break;
+		case 0xd0:
+		case 0x40: /* yon-ten-go */
+			boot_cpu_data.type = CPU_SH7372;
+			break;
+
 		}
 		break;
 	case 0x4000:	/* 1st cut */
