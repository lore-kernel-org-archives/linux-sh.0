From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 24 Oct 2009 16:52:11 +0000
Subject: [PATCH] sh: Use SYS_SUPPORTS_32BIT for managing 32BIT dependencies.
Message-Id: <1256403131-20140-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/sh/Kconfig    |    6 ++++++
 arch/sh/mm/Kconfig |    8 +++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0dc7e3c..20a3488 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -121,6 +121,9 @@ config SYS_SUPPORTS_APM_EMULATION
 	bool
 	select ARCH_SUSPEND_POSSIBLE
 
+config SYS_SUPPORTS_32BIT
+	bool
+
 config SYS_SUPPORTS_SMP
 	bool
 
@@ -402,6 +405,7 @@ config CPU_SUBTYPE_SH7757
 	bool "Support SH7757 processor"
 	select CPU_SH4A
 	select CPU_SHX2
+	select SYS_SUPPORTS_32BIT
 	help
 	  Select SH7757 if you have a SH4A SH7757 CPU.
 
@@ -418,12 +422,14 @@ config CPU_SUBTYPE_SH7770
 config CPU_SUBTYPE_SH7780
 	bool "Support SH7780 processor"
 	select CPU_SH4A
+	select SYS_SUPPORTS_32BIT
 
 config CPU_SUBTYPE_SH7785
 	bool "Support SH7785 processor"
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_32BIT
 	select SYS_SUPPORTS_NUMA
 
 config CPU_SUBTYPE_SH7786
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 64dc1ad..64b5d43 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -82,7 +82,7 @@ config 32BIT
 
 config PMB_ENABLE
 	bool "Support 32-bit physical addressing through PMB"
-	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
+	depends on MMU && EXPERIMENTAL && SYS_SUPPORTS_32BIT
 	select 32BIT
 	default y
 	help
@@ -97,7 +97,7 @@ choice
 
 config PMB
 	bool "PMB"
-	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
+	depends on MMU && EXPERIMENTAL && SYS_SUPPORTS_32BIT
 	select 32BIT
 	help
 	  If you say Y here, physical addressing will be extended to
@@ -106,9 +106,7 @@ config PMB
 
 config PMB_FIXED
 	bool "fixed PMB"
-	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || \
-					   CPU_SUBTYPE_SH7780 || \
-					   CPU_SUBTYPE_SH7785)
+	depends on MMU && EXPERIMENTAL && SYS_SUPPORTS_32BIT
 	select 32BIT
 	help
 	  If this option is enabled, fixed PMB mappings are inherited
-- 
1.6.4

