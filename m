From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 21 Mar 2013 09:27:56 +0000
Subject: [PATCH] memblock: kill "config MAX_ACTIVE_REGIONS"
Message-Id: <1363858076.1390.104.camel@x61.thuisdomein>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Hogan <james.hogan@imgtec.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>
Cc: Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

The Kconfig symbol MAX_ACTIVE_REGIONS is unused. Commit
0ee332c1451869963626bf9cac88f165a90990e1 ("memblock: Kill
early_node_map[]") removed the only place were it was actually used. But
it did not remove its Kconfig entries (for powerpc and sh).

Remove those two entries (and the entry for metag, that popped up in
v3.9-rc1).

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Eyeball tested again.

1) It felt silly to split this clean up patch into three patches. But if
the maintainers involved disagree I'm happy to split and resend it. 

 arch/metag/mm/Kconfig | 5 -----
 arch/powerpc/Kconfig  | 5 -----
 arch/sh/mm/Kconfig    | 7 -------
 3 files changed, 17 deletions(-)

diff --git a/arch/metag/mm/Kconfig b/arch/metag/mm/Kconfig
index 794f26a..03fb8f1 100644
--- a/arch/metag/mm/Kconfig
+++ b/arch/metag/mm/Kconfig
@@ -93,11 +93,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "2" if SPARSEMEM
-	default "1"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 867ace7..b674397 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -427,11 +427,6 @@ config NODES_SHIFT
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "256" if PPC64
-	default "32"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5a43a87..dba285e 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -137,13 +137,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config MAX_ACTIVE_REGIONS
-	int
-	default "6" if (CPU_SUBTYPE_SHX3 && SPARSEMEM)
-	default "2" if SPARSEMEM && (CPU_SUBTYPE_SH7722 || \
-		       CPU_SUBTYPE_SH7785)
-	default "1"
-
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 
-- 
1.7.11.7

