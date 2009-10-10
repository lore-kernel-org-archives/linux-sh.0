From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 10 Oct 2009 13:09:16 +0000
Subject: [PATCH] sh: Teach the DWARF unwinder about modules
Message-Id: <1255180156-870-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pass a module's .eh_frame section to the DWARF unwinder at module load
time so that the section's FDEs and CIEs can be registered with the
DWARF unwinder. This allows us to unwind the stack through module code
when generating backtraces.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/dwarf.h |   15 +++++
 arch/sh/kernel/dwarf.c      |  135 +++++++++++++++++++++++++++++++++----------
 arch/sh/kernel/module.c     |   33 +++++++++++
 3 files changed, 153 insertions(+), 30 deletions(-)

diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index c367ed3..aacdc74 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -241,6 +241,12 @@ struct dwarf_cie {
 
 	unsigned long flags;
 #define DWARF_CIE_Z_AUGMENTATION	(1 << 0)
+
+	/*
+	 * 'mod' will be non-NULL if this CIE came from a module's
+	 * .eh_frame section.
+	 */
+	struct module *mod;
 };
 
 /**
@@ -255,6 +261,12 @@ struct dwarf_fde {
 	unsigned char *instructions;
 	unsigned char *end;
 	struct list_head link;
+
+	/*
+	 * 'mod' will be non-NULL if this FDE came from a module's
+	 * .eh_frame section.
+	 */
+	struct module *mod;
 };
 
 /**
@@ -364,6 +376,9 @@ static inline unsigned int DW_CFA_operand(unsigned long insn)
 
 extern struct dwarf_frame *dwarf_unwind_stack(unsigned long,
 					      struct dwarf_frame *);
+extern int dwarf_parse_section(char *, char *, struct module *);
+extern void dwarf_module_unload(struct module *);
+
 #endif /* !__ASSEMBLY__ */
 
 #define CFI_STARTPROC	.cfi_startproc
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 577302f..981315c 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -655,7 +655,7 @@ bail:
 }
 
 static int dwarf_parse_cie(void *entry, void *p, unsigned long len,
-			   unsigned char *end)
+			   unsigned char *end, struct module *mod)
 {
 	struct dwarf_cie *cie;
 	unsigned long flags;
@@ -751,6 +751,8 @@ static int dwarf_parse_cie(void *entry, void *p, unsigned long len,
 	cie->initial_instructions = p;
 	cie->instructions_end = end;
 
+	cie->mod = mod;
+
 	/* Add to list */
 	spin_lock_irqsave(&dwarf_cie_lock, flags);
 	list_add_tail(&cie->link, &dwarf_cie_list);
@@ -761,7 +763,7 @@ static int dwarf_parse_cie(void *entry, void *p, unsigned long len,
 
 static int dwarf_parse_fde(void *entry, u32 entry_type,
 			   void *start, unsigned long len,
-			   unsigned char *end)
+			   unsigned char *end, struct module *mod)
 {
 	struct dwarf_fde *fde;
 	struct dwarf_cie *cie;
@@ -810,6 +812,8 @@ static int dwarf_parse_fde(void *entry, u32 entry_type,
 	fde->instructions = p;
 	fde->end = end;
 
+	fde->mod = mod;
+
 	/* Add to list. */
 	spin_lock_irqsave(&dwarf_fde_lock, flags);
 	list_add_tail(&fde->link, &dwarf_fde_list);
@@ -875,15 +879,15 @@ static void dwarf_unwinder_cleanup(void)
 }
 
 /**
- *	dwarf_unwinder_init - initialise the dwarf unwinder
+ *	dwarf_parse_section - parse DWARF section
+ *	@eh_frame_start: start address of the .eh_frame section
+ *	@eh_frame_end: end address of the .eh_frame section
+ *	@mod: the kernel module containing the .eh_frame section
  *
- *	Build the data structures describing the .dwarf_frame section to
- *	make it easier to lookup CIE and FDE entries. Because the
- *	.eh_frame section is packed as tightly as possible it is not
- *	easy to lookup the FDE for a given PC, so we build a list of FDE
- *	and CIE entries that make it easier.
+ *	Parse the information in a .eh_frame section.
  */
-static int __init dwarf_unwinder_init(void)
+int dwarf_parse_section(char *eh_frame_start, char *eh_frame_end,
+			struct module *mod)
 {
 	u32 entry_type;
 	void *p, *entry;
@@ -891,29 +895,12 @@ static int __init dwarf_unwinder_init(void)
 	unsigned long len;
 	unsigned int c_entries, f_entries;
 	unsigned char *end;
-	INIT_LIST_HEAD(&dwarf_cie_list);
-	INIT_LIST_HEAD(&dwarf_fde_list);
 
 	c_entries = 0;
 	f_entries = 0;
-	entry = &__start_eh_frame;
-
-	dwarf_frame_cachep = kmem_cache_create("dwarf_frames",
-			sizeof(struct dwarf_frame), 0, SLAB_PANIC, NULL);
-	dwarf_reg_cachep = kmem_cache_create("dwarf_regs",
-			sizeof(struct dwarf_reg), 0, SLAB_PANIC, NULL);
-
-	dwarf_frame_pool = mempool_create(DWARF_FRAME_MIN_REQ,
-					  mempool_alloc_slab,
-					  mempool_free_slab,
-					  dwarf_frame_cachep);
+	entry = eh_frame_start;
 
-	dwarf_reg_pool = mempool_create(DWARF_REG_MIN_REQ,
-					 mempool_alloc_slab,
-					 mempool_free_slab,
-					 dwarf_reg_cachep);
-
-	while ((char *)entry < __stop_eh_frame) {
+	while ((char *)entry < eh_frame_end) {
 		p = entry;
 
 		count = dwarf_entry_len(p, &len);
@@ -925,6 +912,7 @@ static int __init dwarf_unwinder_init(void)
 			 * entry and move to the next one because 'len'
 			 * tells us where our next entry is.
 			 */
+			err = -EINVAL;
 			goto out;
 		} else
 			p += count;
@@ -936,13 +924,14 @@ static int __init dwarf_unwinder_init(void)
 		p += 4;
 
 		if (entry_type = DW_EH_FRAME_CIE) {
-			err = dwarf_parse_cie(entry, p, len, end);
+			err = dwarf_parse_cie(entry, p, len, end, mod);
 			if (err < 0)
 				goto out;
 			else
 				c_entries++;
 		} else {
-			err = dwarf_parse_fde(entry, entry_type, p, len, end);
+			err = dwarf_parse_fde(entry, entry_type, p, len,
+					      end, mod);
 			if (err < 0)
 				goto out;
 			else
@@ -955,6 +944,92 @@ static int __init dwarf_unwinder_init(void)
 	printk(KERN_INFO "DWARF unwinder initialised: read %u CIEs, %u FDEs\n",
 	       c_entries, f_entries);
 
+	return 0;
+
+out:
+	return err;
+}
+
+/**
+ *	dwarf_module_unload - remove FDE/CIEs associated with @mod
+ *	@mod: the module that is being unloaded
+ *
+ *	Remove any FDEs and CIEs from the global lists that came from
+ *	@mod's .eh_frame section because @mod is being unloaded.
+ */
+void dwarf_module_unload(struct module *mod)
+{
+	struct dwarf_fde *fde;
+	struct dwarf_cie *cie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwarf_cie_lock, flags);
+
+again_cie:
+	list_for_each_entry(cie, &dwarf_cie_list, link) {
+		if (cie->mod = mod)
+			break;
+	}
+
+	if (&cie->link != &dwarf_cie_list) {
+		list_del(&cie->link);
+		kfree(cie);
+		goto again_cie;
+	}
+
+	spin_unlock_irqrestore(&dwarf_cie_lock, flags);
+
+	spin_lock_irqsave(&dwarf_fde_lock, flags);
+
+again_fde:
+	list_for_each_entry(fde, &dwarf_fde_list, link) {
+		if (fde->mod = mod)
+			break;
+	}
+
+	if (&fde->link != &dwarf_fde_list) {
+		list_del(&fde->link);
+		kfree(fde);
+		goto again_fde;
+	}
+
+	spin_unlock_irqrestore(&dwarf_fde_lock, flags);
+}
+
+/**
+ *	dwarf_unwinder_init - initialise the dwarf unwinder
+ *
+ *	Build the data structures describing the .dwarf_frame section to
+ *	make it easier to lookup CIE and FDE entries. Because the
+ *	.eh_frame section is packed as tightly as possible it is not
+ *	easy to lookup the FDE for a given PC, so we build a list of FDE
+ *	and CIE entries that make it easier.
+ */
+static int __init dwarf_unwinder_init(void)
+{
+	int err;
+	INIT_LIST_HEAD(&dwarf_cie_list);
+	INIT_LIST_HEAD(&dwarf_fde_list);
+
+	dwarf_frame_cachep = kmem_cache_create("dwarf_frames",
+			sizeof(struct dwarf_frame), 0, SLAB_PANIC, NULL);
+	dwarf_reg_cachep = kmem_cache_create("dwarf_regs",
+			sizeof(struct dwarf_reg), 0, SLAB_PANIC, NULL);
+
+	dwarf_frame_pool = mempool_create(DWARF_FRAME_MIN_REQ,
+					  mempool_alloc_slab,
+					  mempool_free_slab,
+					  dwarf_frame_cachep);
+
+	dwarf_reg_pool = mempool_create(DWARF_REG_MIN_REQ,
+					 mempool_alloc_slab,
+					 mempool_free_slab,
+					 dwarf_reg_cachep);
+
+	err = dwarf_parse_section(__start_eh_frame, __stop_eh_frame, NULL);
+	if (err)
+		goto out;
+
 	err = unwinder_register(&dwarf_unwinder);
 	if (err)
 		goto out;
diff --git a/arch/sh/kernel/module.c b/arch/sh/kernel/module.c
index c2efdcd..dafc4ea 100644
--- a/arch/sh/kernel/module.c
+++ b/arch/sh/kernel/module.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <asm/unaligned.h>
+#include <asm/dwarf.h>
 
 void *module_alloc(unsigned long size)
 {
@@ -145,10 +146,42 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+#ifdef CONFIG_DWARF_UNWINDER
+	unsigned int i, err;
+	unsigned long start, end;
+	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	start = end = 0;
+
+	for (i = 1; i < hdr->e_shnum; i++) {
+		/* Alloc bit cleared means "ignore it." */
+		if ((sechdrs[i].sh_flags & SHF_ALLOC)
+		    && !strcmp(secstrings+sechdrs[i].sh_name, ".eh_frame")) {
+			start = sechdrs[i].sh_addr;
+			end = start + sechdrs[i].sh_size;
+			break;
+		}
+	}
+
+	/* No DWARF info in module, oh well. */
+	if (i = hdr->e_shnum)
+		return 0;
+
+	err = dwarf_parse_section((char *)start, (char *)end, me);
+	if (err)
+		printk(KERN_WARNING "%s: failed to parse DWARF info\n",
+		       me->name);
+
+#endif /* CONFIG_DWARF_UNWINDER */
+
 	return module_bug_finalize(hdr, sechdrs, me);
 }
 
 void module_arch_cleanup(struct module *mod)
 {
 	module_bug_cleanup(mod);
+
+#ifdef CONFIG_DWARF_UNWINDER
+	dwarf_module_unload(mod);
+#endif /* CONFIG_DWARF_UNWINDER */
 }
-- 
1.6.4.rc0

