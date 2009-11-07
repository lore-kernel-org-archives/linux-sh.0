From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 07 Nov 2009 10:55:57 +0000
Subject: [PATCH 3/3] sh: Use ioremap_fixed() to implement SH-5 ioremap()
Message-Id: <c8d9990eb969fd92af2581bc2e4822abf8d40ec0.1257590789.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the fixmap-based memory mapping implementation for SH-5's ioremap()
functions and delete the old static allocator that was borrowed from
sparc.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/ioremap_64.c |  290 +----------------------------------------------
 1 files changed, 4 insertions(+), 286 deletions(-)

diff --git a/arch/sh/mm/ioremap_64.c b/arch/sh/mm/ioremap_64.c
index b16843d..f651247 100644
--- a/arch/sh/mm/ioremap_64.c
+++ b/arch/sh/mm/ioremap_64.c
@@ -28,299 +28,17 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
 
-static struct resource shmedia_iomap = {
-	.name	= "shmedia_iomap",
-	.start	= IOBASE_VADDR + PAGE_SIZE,
-	.end	= IOBASE_END - 1,
-};
-
-static void shmedia_mapioaddr(unsigned long pa, unsigned long va,
-			      unsigned long flags);
-static void shmedia_unmapioaddr(unsigned long vaddr);
-static void __iomem *shmedia_ioremap(struct resource *res, u32 pa,
-				     int sz, unsigned long flags);
-
-/*
- * We have the same problem as the SPARC, so lets have the same comment:
- * Our mini-allocator...
- * Boy this is gross! We need it because we must map I/O for
- * timers and interrupt controller before the kmalloc is available.
- */
-
-#define XNMLN  15
-#define XNRES  10
-
-struct xresource {
-	struct resource xres;   /* Must be first */
-	int xflag;              /* 1 = used */
-	char xname[XNMLN+1];
-};
-
-static struct xresource xresv[XNRES];
-
-static struct xresource *xres_alloc(void)
-{
-	struct xresource *xrp;
-	int n;
-
-	xrp = xresv;
-	for (n = 0; n < XNRES; n++) {
-		if (xrp->xflag = 0) {
-			xrp->xflag = 1;
-			return xrp;
-		}
-		xrp++;
-	}
-	return NULL;
-}
-
-static void xres_free(struct xresource *xrp)
-{
-	xrp->xflag = 0;
-}
-
-static struct resource *shmedia_find_resource(struct resource *root,
-					      unsigned long vaddr)
-{
-	struct resource *res;
-
-	for (res = root->child; res; res = res->sibling)
-		if (res->start <= vaddr && res->end >= vaddr)
-			return res;
-
-	return NULL;
-}
-
-static void __iomem *shmedia_alloc_io(unsigned long phys, unsigned long size,
-				      const char *name, unsigned long flags)
-{
-	struct xresource *xres;
-	struct resource *res;
-	char *tack;
-	int tlen;
-
-	if (name = NULL)
-		name = "???";
-
-	xres = xres_alloc();
-	if (xres != 0) {
-		tack = xres->xname;
-		res = &xres->xres;
-	} else {
-		printk_once(KERN_NOTICE "%s: done with statics, "
-			       "switching to kmalloc\n", __func__);
-		tlen = strlen(name);
-		tack = kmalloc(sizeof(struct resource) + tlen + 1, GFP_KERNEL);
-		if (!tack)
-			return NULL;
-		memset(tack, 0, sizeof(struct resource));
-		res = (struct resource *) tack;
-		tack += sizeof(struct resource);
-	}
-
-	strncpy(tack, name, XNMLN);
-	tack[XNMLN] = 0;
-	res->name = tack;
-
-	return shmedia_ioremap(res, phys, size, flags);
-}
-
-static void __iomem *shmedia_ioremap(struct resource *res, u32 pa, int sz,
-				     unsigned long flags)
-{
-	unsigned long offset = ((unsigned long) pa) & (~PAGE_MASK);
-	unsigned long round_sz = (offset + sz + PAGE_SIZE-1) & PAGE_MASK;
-	unsigned long va;
-	unsigned int psz;
-
-	if (allocate_resource(&shmedia_iomap, res, round_sz,
-			      shmedia_iomap.start, shmedia_iomap.end,
-			      PAGE_SIZE, NULL, NULL) != 0) {
-		panic("alloc_io_res(%s): cannot occupy\n",
-		      (res->name != NULL) ? res->name : "???");
-	}
-
-	va = res->start;
-	pa &= PAGE_MASK;
-
-	psz = (res->end - res->start + (PAGE_SIZE - 1)) / PAGE_SIZE;
-
-	for (psz = res->end - res->start + 1; psz != 0; psz -= PAGE_SIZE) {
-		shmedia_mapioaddr(pa, va, flags);
-		va += PAGE_SIZE;
-		pa += PAGE_SIZE;
-	}
-
-	return (void __iomem *)(unsigned long)(res->start + offset);
-}
-
-static void shmedia_free_io(struct resource *res)
-{
-	unsigned long len = res->end - res->start + 1;
-
-	BUG_ON((len & (PAGE_SIZE - 1)) != 0);
-
-	while (len) {
-		len -= PAGE_SIZE;
-		shmedia_unmapioaddr(res->start + len);
-	}
-
-	release_resource(res);
-}
-
-static __init_refok void *sh64_get_page(void)
-{
-	void *page;
-
-	if (slab_is_available())
-		page = (void *)get_zeroed_page(GFP_KERNEL);
-	else
-		page = alloc_bootmem_pages(PAGE_SIZE);
-
-	if (!page || ((unsigned long)page & ~PAGE_MASK))
-		panic("sh64_get_page: Out of memory already?\n");
-
-	return page;
-}
-
-static void shmedia_mapioaddr(unsigned long pa, unsigned long va,
-			      unsigned long flags)
-{
-	pgd_t *pgdp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep, pte;
-	pgprot_t prot;
-
-	pr_debug("shmedia_mapiopage pa %08lx va %08lx\n",  pa, va);
-
-	if (!flags)
-		flags = 1; /* 1 = CB0-1 device */
-
-	pgdp = pgd_offset_k(va);
-	if (pgd_none(*pgdp) || !pgd_present(*pgdp)) {
-		pudp = (pud_t *)sh64_get_page();
-		set_pgd(pgdp, __pgd((unsigned long)pudp | _KERNPG_TABLE));
-	}
-
-	pudp = pud_offset(pgdp, va);
-	if (pud_none(*pudp) || !pud_present(*pudp)) {
-		pmdp = (pmd_t *)sh64_get_page();
-		set_pud(pudp, __pud((unsigned long)pmdp | _KERNPG_TABLE));
-	}
-
-	pmdp = pmd_offset(pudp, va);
-	if (pmd_none(*pmdp) || !pmd_present(*pmdp)) {
-		ptep = (pte_t *)sh64_get_page();
-		set_pmd(pmdp, __pmd((unsigned long)ptep + _PAGE_TABLE));
-	}
-
-	prot = __pgprot(_PAGE_PRESENT | _PAGE_READ     | _PAGE_WRITE  |
-			_PAGE_DIRTY   | _PAGE_ACCESSED | _PAGE_SHARED | flags);
-
-	pte = pfn_pte(pa >> PAGE_SHIFT, prot);
-	ptep = pte_offset_kernel(pmdp, va);
-
-	if (!pte_none(*ptep) &&
-	    pte_val(*ptep) != pte_val(pte))
-		pte_ERROR(*ptep);
-
-	set_pte(ptep, pte);
-
-	flush_tlb_kernel_range(va, PAGE_SIZE);
-}
-
-static void shmedia_unmapioaddr(unsigned long vaddr)
-{
-	pgd_t *pgdp;
-	pud_t *pudp;
-	pmd_t *pmdp;
-	pte_t *ptep;
-
-	pgdp = pgd_offset_k(vaddr);
-	if (pgd_none(*pgdp) || pgd_bad(*pgdp))
-		return;
-
-	pudp = pud_offset(pgdp, vaddr);
-	if (pud_none(*pudp) || pud_bad(*pudp))
-		return;
-
-	pmdp = pmd_offset(pudp, vaddr);
-	if (pmd_none(*pmdp) || pmd_bad(*pmdp))
-		return;
-
-	ptep = pte_offset_kernel(pmdp, vaddr);
-
-	if (pte_none(*ptep) || !pte_present(*ptep))
-		return;
-
-	clear_page((void *)ptep);
-	pte_clear(&init_mm, vaddr, ptep);
-}
-
 void __iomem *__ioremap(unsigned long offset, unsigned long size,
 			unsigned long flags)
 {
-	char name[14];
-
-	sprintf(name, "phys_%08x", (u32)offset);
-	return shmedia_alloc_io(offset, size, name, flags);
+	prot = __pgprot(_PAGE_PRESENT | _PAGE_READ     | _PAGE_WRITE  |
+			_PAGE_DIRTY   | _PAGE_ACCESSED | _PAGE_SHARED | flags);
+	return ioremap_fixed(offset, size, prot);
 }
 EXPORT_SYMBOL(__ioremap);
 
 void __iounmap(void __iomem *virtual)
 {
-	unsigned long vaddr = (unsigned long)virtual & PAGE_MASK;
-	struct resource *res;
-	unsigned int psz;
-
-	res = shmedia_find_resource(&shmedia_iomap, vaddr);
-	if (!res) {
-		printk(KERN_ERR "%s: Failed to free 0x%08lx\n",
-		       __func__, vaddr);
-		return;
-	}
-
-	psz = (res->end - res->start + (PAGE_SIZE - 1)) / PAGE_SIZE;
-
-	shmedia_free_io(res);
-
-	if ((char *)res >= (char *)xresv &&
-	    (char *)res <  (char *)&xresv[XNRES]) {
-		xres_free((struct xresource *)res);
-	} else {
-		kfree(res);
-	}
+	iounmap_fixed(virtual);
 }
 EXPORT_SYMBOL(__iounmap);
-
-static int
-ioremap_proc_info(char *buf, char **start, off_t fpos, int length, int *eof,
-		  void *data)
-{
-	char *p = buf, *e = buf + length;
-	struct resource *r;
-	const char *nm;
-
-	for (r = ((struct resource *)data)->child; r != NULL; r = r->sibling) {
-		if (p + 32 >= e)        /* Better than nothing */
-			break;
-		nm = r->name;
-		if (nm = NULL)
-			nm = "???";
-
-		p += sprintf(p, "%08lx-%08lx: %s\n",
-			     (unsigned long)r->start,
-			     (unsigned long)r->end, nm);
-	}
-
-	return p-buf;
-}
-
-static int __init register_proc_onchip(void)
-{
-	create_proc_read_entry("io_map", 0, 0, ioremap_proc_info,
-			       &shmedia_iomap);
-	return 0;
-}
-late_initcall(register_proc_onchip);
-- 
1.6.2.5

