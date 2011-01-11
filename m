From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 11 Jan 2011 05:31:48 +0000
Subject: Re: [PATCH /RFC] sh: landisk: Fix ioremap address for CF I/O window
Message-Id: <20110111053147.GA31863@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1294369427-4149-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1294369427-4149-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 07, 2011 at 12:03:47PM +0900, Nobuhiro Iwamatsu wrote:
> By commit f33609344acfdde1c1acedf6de3efe6b80af93a6, it was revised
> by p3_ioremap to use ioremap_prot.
> However, CF I/O window is not usable because this did not map to P3 area
> This changes from ioremap_prot to __ioremap.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Does this work for you?

---

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 70c1186..6c4d156 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -290,6 +290,14 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 	 * mapping must be done by the PMB or by using page tables.
 	 */
 	if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
+		u64 flags = pgprot_val(prot);
+
+		/*
+		 * Anything using the legacy PTEA space attributes needs
+		 * to be kicked down to page table mappings.
+		 */
+		if (unlikely(flags & _PAGE_PCC_MASK))
+			return NULL;
 		if (unlikely(pgprot_val(prot) & _PAGE_CACHABLE))
 			return (void __iomem *)P1SEGADDR(offset);
 
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 43528ec..f76b90f 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -76,6 +76,12 @@
 /* Wrapper for extended mode pgprot twiddling */
 #define _PAGE_EXT(x)		((unsigned long long)(x) << 32)
 
+#ifdef CONFIG_X2TLB
+
+#define _PAGE_PCC_MASK	0x00000000	/* No legacy PTEA support */
+
+#else
+
 /* software: moves to PTEA.TC (Timing Control) */
 #define _PAGE_PCC_AREA5	0x00000000	/* use BSC registers for area5 */
 #define _PAGE_PCC_AREA6	0x80000000	/* use BSC registers for area6 */
@@ -89,7 +95,8 @@
 #define _PAGE_PCC_ATR8	0x60000000	/* Attribute Memory space, 8 bit bus */
 #define _PAGE_PCC_ATR16	0x60000001	/* Attribute Memory space, 6 bit bus */
 
-#ifndef CONFIG_X2TLB
+#define _PAGE_PCC_MASK	0xe0000001
+
 /* copy the ptea attributes */
 static inline unsigned long copy_ptea_attributes(unsigned long x)
 {
@@ -231,13 +238,7 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 					   _PAGE_EXT_KERN_EXEC))
 
 #define PAGE_KERNEL_PCC(slot, type) \
-			__pgprot(_PAGE_PRESENT | _PAGE_DIRTY | \
-				 _PAGE_ACCESSED | _PAGE_FLAGS_HARD | \
-				 _PAGE_EXT(_PAGE_EXT_KERN_READ | \
-					   _PAGE_EXT_KERN_WRITE | \
-					   _PAGE_EXT_KERN_EXEC) \
-				 (slot ? _PAGE_PCC_AREA5 : _PAGE_PCC_AREA6) | \
-				 (type))
+			__pgprot(0)
 
 #elif defined(CONFIG_MMU) /* SH-X TLB */
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_CACHABLE | \
