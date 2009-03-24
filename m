From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 24 Mar 2009 13:30:01 +0000
Subject: [PATCH] Added ASSEMBLY macro in the mmu.h file
Message-Id: <49C8E059.9040100@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090201040701050109020200"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201040701050109020200
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the ifndef __ASSEMBLY__ preprocessor to allow the
 defines in the file are used also in assembly code.

Regards
 Francesco

--------------090201040701050109020200
Content-Type: text/x-patch;
 name="0003--Added-__ASSEMBLY__-ifdef-in-the-mmu.h-file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003--Added-__ASSEMBLY__-ifdef-in-the-mmu.h-file.patch"

From 2adf176e3e8e429237742dedc82bc9ffc9f7ae97 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Tue, 24 Mar 2009 14:22:19 +0100
Subject: [PATCH] Added __ASSEMBLY__ ifdef in the mmu.h file

Added the 'ifndef _ASSEMBLY__' to be able to use the
defines in the mmu.h in assmebly code

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/include/asm/mmu.h |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 6c43625..f596303 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -1,22 +1,6 @@
 #ifndef __MMU_H
 #define __MMU_H
 
-/* Default "unsigned long" context */
-typedef unsigned long mm_context_id_t[NR_CPUS];
-
-typedef struct {
-#ifdef CONFIG_MMU
-	mm_context_id_t		id;
-	void			*vdso;
-#else
-	unsigned long		end_brk;
-#endif
-#ifdef CONFIG_BINFMT_ELF_FDPIC
-	unsigned long		exec_fdpic_loadmap;
-	unsigned long		interp_fdpic_loadmap;
-#endif
-} mm_context_t;
-
 /*
  * Privileged Space Mapping Buffer (PMB) definitions
  */
@@ -41,6 +25,24 @@ typedef struct {
 
 #define PMB_NO_ENTRY		(-1)
 
+#ifndef __ASSEMBLY__
+
+/* Default "unsigned long" context */
+typedef unsigned long mm_context_id_t[NR_CPUS];
+
+typedef struct {
+#ifdef CONFIG_MMU
+	mm_context_id_t		id;
+	void			*vdso;
+#else
+	unsigned long		end_brk;
+#endif
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long		exec_fdpic_loadmap;
+	unsigned long		interp_fdpic_loadmap;
+#endif
+} mm_context_t;
+
 struct pmb_entry;
 
 struct pmb_entry {
@@ -70,6 +72,7 @@ void pmb_free(struct pmb_entry *pmbe);
 long pmb_remap(unsigned long virt, unsigned long phys,
 	       unsigned long size, unsigned long flags);
 void pmb_unmap(unsigned long addr);
+#endif /* __ASSEMBLY__ */
 
 #endif /* __MMU_H */
 
-- 
1.6.0.6


--------------090201040701050109020200--
