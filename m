Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E7C32792
	for <linux-sh@archiver.kernel.org>; Sat, 20 Aug 2022 00:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbiHTAcg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiHTAce (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 19 Aug 2022 20:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1F5106FA6
        for <linux-sh@vger.kernel.org>; Fri, 19 Aug 2022 17:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660955551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqPWS9gGxOeL/ZhwRsPXano6Rhd9t79hH4to3Fvy2dA=;
        b=SarzMmr/Gj0z0FLBl7WPwSWB7oGXaqFvt+0x8Stw4mVKpi2Ej+VwbIpumMeeXt6n8KVGNm
        eBsfFaW9FYR+hyY1XILsFAASPTVpdUmDir2up7AN6ukLvRO+L4IC02KixMikJqgQHmC9kS
        IjK6YZ3hFP2embUVrxJishufBSM8NGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-1btemdQ7NeSIPbzJZZhjng-1; Fri, 19 Aug 2022 20:32:28 -0400
X-MC-Unique: 1btemdQ7NeSIPbzJZZhjng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28B8F101A586;
        Sat, 20 Aug 2022 00:32:28 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08CDF4010D2A;
        Sat, 20 Aug 2022 00:32:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v2 10/11] sh: mm: Convert to GENERIC_IOREMAP
Date:   Sat, 20 Aug 2022 08:31:24 +0800
Message-Id: <20220820003125.353570-11-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-1-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Add hook arch_ioremap() and arch_iounmap for sh's special operation when
ioremap() and iounmap(), then ioremap_cache() is converted to use
ioremap_prot() from GENERIC_IOREMAP.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig          |  1 +
 arch/sh/include/asm/io.h | 47 +++++++++----------------------
 arch/sh/mm/ioremap.c     | 61 ++++++++--------------------------------
 3 files changed, 26 insertions(+), 83 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..b63ad4698cf8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -25,6 +25,7 @@ config SUPERH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select GENERIC_IOREMAP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index fba90e670ed4..3c5ff82a511a 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -242,45 +242,26 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define phys_to_virt(address)	(__va(address))
 #endif
 
-#ifdef CONFIG_MMU
-void iounmap(void __iomem *addr);
-void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
-			       pgprot_t prot, void *caller);
-
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL_NOCACHE,
-			__builtin_return_address(0));
-}
-
-static inline void __iomem *
-ioremap_cache(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL,
-			__builtin_return_address(0));
-}
-#define ioremap_cache ioremap_cache
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
 
-#ifdef CONFIG_HAVE_IOREMAP_PROT
-static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-		unsigned long flags)
-{
-	return __ioremap_caller(offset, size, __pgprot(flags),
-			__builtin_return_address(0));
-}
-#endif /* CONFIG_HAVE_IOREMAP_PROT */
+int arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
 
-#else /* CONFIG_MMU */
-static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-{
-	return (void __iomem *)(unsigned long)offset;
-}
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL_NOCACHE)
 
-static inline void iounmap(volatile void __iomem *addr) { }
-#endif /* CONFIG_MMU */
+#define ioremap_cache(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
+#define ioremap_cache ioremap_cache
 
 #define ioremap_uc	ioremap
 
+#include <asm-generic/io.h>
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 21342581144d..720a9186b06b 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -72,22 +72,12 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #define __ioremap_29bit(offset, size, prot)		NULL
 #endif /* CONFIG_29BIT */
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem * __ref
-__ioremap_caller(phys_addr_t phys_addr, unsigned long size,
-		 pgprot_t pgprot, void *caller)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	struct vm_struct *area;
-	unsigned long offset, last_addr, addr, orig_addr;
+	unsigned long last_addr, phys_addr = *paddr;
 	void __iomem *mapped;
+	pgprot_t pgprot = __pgprot(*prot_val);
 
 	mapped = __ioremap_trapped(phys_addr, size);
 	if (mapped)
@@ -100,7 +90,7 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
-		return NULL;
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	/*
 	 * If we can't yet use the regular approach, go the fixmap route.
@@ -116,30 +106,8 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	if (mapped && !IS_ERR(mapped))
 		return mapped;
 
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr+1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-	area->phys_addr = phys_addr;
-	orig_addr = addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
-		vunmap((void *)orig_addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)orig_addr);
+	return NULL;
 }
-EXPORT_SYMBOL(__ioremap_caller);
 
 /*
  * Simple checks for non-translatable mappings.
@@ -158,7 +126,7 @@ static inline int iomapping_nontranslatable(unsigned long offset)
 	return 0;
 }
 
-void iounmap(void __iomem *addr)
+int arch_iounmap(void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
 	struct vm_struct *p;
@@ -167,26 +135,19 @@ void iounmap(void __iomem *addr)
 	 * Nothing to do if there is no translatable mapping.
 	 */
 	if (iomapping_nontranslatable(vaddr))
-		return;
+		return -EINVAL;
 
 	/*
 	 * There's no VMA if it's from an early fixed mapping.
 	 */
 	if (iounmap_fixed(addr) == 0)
-		return;
+		return -EINVAL;
 
 	/*
 	 * If the PMB handled it, there's nothing else to do.
 	 */
 	if (pmb_unmap(addr) == 0)
-		return;
+		return -EINVAL;
 
-	p = remove_vm_area((void *)(vaddr & PAGE_MASK));
-	if (!p) {
-		printk(KERN_ERR "%s: bad address %p\n", __func__, addr);
-		return;
-	}
-
-	kfree(p);
+	return 0;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

