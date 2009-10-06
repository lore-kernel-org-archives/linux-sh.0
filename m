From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:26 +0000
Subject: [PATCH 06/14] sh: CONFIG_PMB doesn't mean the MMU is in 32bit mode
Message-Id: <f3db2577f84d907a48af39434d7f9a879e985faf.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_PMB will eventually allow the MMU to be switched between 29-bit
and 32-bit mode dynamically at runtime.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/head_32.S |    2 +-
 arch/sh/mm/Kconfig       |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index a78be74..1151ecd 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -33,7 +33,7 @@ ENTRY(empty_zero_page)
 	.long	1		/* LOADER_TYPE */
 	.long	0x00000000	/* INITRD_START */
 	.long	0x00000000	/* INITRD_SIZE */
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) && defined(CONFIG_PMB_FIXED)
 	.long	0x53453f00 + 32	/* "SE?" = 32 bit */
 #else
 	.long	0x53453f00 + 29	/* "SE?" = 29 bit */
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 64dc1ad..b8a9032 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -83,7 +83,6 @@ config 32BIT
 config PMB_ENABLE
 	bool "Support 32-bit physical addressing through PMB"
 	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
-	select 32BIT
 	default y
 	help
 	  If you say Y here, physical addressing will be extended to
@@ -98,7 +97,6 @@ choice
 config PMB
 	bool "PMB"
 	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
-	select 32BIT
 	help
 	  If you say Y here, physical addressing will be extended to
 	  32-bits through the SH-4A PMB. If this is not set, legacy
-- 
1.6.3.3

