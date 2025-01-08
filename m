Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A811AAA29
	for <linux-sh@vger.kernel.org>; Wed,  8 Jan 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319761; cv=none; b=a4DMheGXohE797VUH0tq1xoGRMoe9eNjA/6N1YDs62AStqkr8xTiKxHzUI/AN4BM33Ku7pLCbVibjVvlRTO70TsL8tpXlbqLtaNH3+O2qUYLL1+OggDrHSD+d9foRL1Y1988Tfq8QZxdlQX5wYHWNC5d663cnrC3/F2MICyuHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319761; c=relaxed/simple;
	bh=Kx0FsgNq46QBGZYoDJIY0xToNCyy11ntqe8BvR51hdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTiKsFslQMDvIv2MfSmzdD/+Jie7k563O10iYOs0iNfvlsy5ngQqnL+FXtgpGYX39VGZ4TcZVg7oWkqB1pCLRjgezp5mnQhmx1Syy6R7CB3LDp3iyg0K+VUm4Y8N5i+lqsEGA9Repj1IGcdn9vGwKiBs778Wuo+SLSI3SPuAIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UwMWDmGP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UwMWDmGP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21644aca3a0so69234785ad.3
        for <linux-sh@vger.kernel.org>; Tue, 07 Jan 2025 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319757; x=1736924557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFL9SGbXxYqRlw6G0JwTVWRijc5/6EOrJfB/UywRwlQ=;
        b=UwMWDmGPRQyV0OPMr+JXUg8p94KGwNfE/gk3eQ2xe0hPBJYYBpIZUQYd/gvaM6nBdb
         fz1LW/ZqdT4Z1Qj/VklBy8eUQkhnfXhQMcLvZrXkJau51xQwoG3Zgge+9xRvzXcZ1N5K
         D8KGmNfhI9ZbIjqdqeNe3bGMBVHZ2T/YE+vsGFQQIZzPKoBvX+/EEb+Zv8qBeupm7oHE
         yFVwxVK+J9c5oqlj/RIr6VmPln3pac7G/qI8Fd0MzPvYdBTboPiiRKYH3H/UP9NROOWP
         R0s/iBYejwTIr43XmQTP5qn5XauQbh8Ktut2LOMexVEjKLUugB4DGNwJeBmLAgutGyzQ
         tOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319757; x=1736924557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFL9SGbXxYqRlw6G0JwTVWRijc5/6EOrJfB/UywRwlQ=;
        b=rpZagrFn+R+yMzJ+yf61F2F+xoWM+fCTGzOUAos2EKPUquyramBBpd64AyjoWj2rlZ
         XNs1+Q+XWpkVUP9bD8JpRd3wibn/NYk38L9XJMSGEiDhPkmVeOiuKklAvj7i45uVSViU
         hzi9hvw4M6/x8W0V4LHs/b8MPccMzBsWxzJmFmkPFnk/jBxGIz0+TGklEwxayC90oRKb
         NLi0F5Is1/fdeICMRoAfYdkLJr/aJp053vJjItrOTZR7gBCpFS632wv0XNhuqQ/JRwZd
         2gE8D4FvFmURT1GF/BRRuHgn3pasHNZVYNyFhUDPmbMWIzfvWcOT+HYc42U1bCCw75vi
         FE4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIgy40E322OoAabvI2mrvyIEAJMHEhHIicdXDMjMwIuvh9RdMAAsfjjBMWtXF1552brdwPU8RWxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRcg7To5h5iKfz8xM8yrY9Gn1xhTZzU66O2eE0kG8/Vy1dt6s
	3veMj86V0BsgK+o359iaK4dJN+hKQ9knfy5fKoyCj13NlH1BhjZSf3KKGxU1nQ8=
X-Gm-Gg: ASbGncuuS3g+SR6Hlg3Fj3ieIhGEk8ISDSi0UJjU/oiZzCBzfzGSY3vrg8xRH++k/Qq
	qdehxj8b0rXcOPnE0bcA0blfL0X0wms/qdgEsZ2dyAyfiWJMB9FFq1mNv+8Q96kFtSR/m5tgXcE
	a8n/WJp3Hm2x2kceo8YEPq8BvxSvSq6aDBmJmRYcS8qTIQ1XMRxAWUkMBxHtVmuSLqe9f4GxdJR
	bK1p7ASuXJFkt4QXffIguXwp38pu2TVwsSM+A2NhB4rBkjrVJRL71rh+/2Vii+7lh9JNaRDYZII
	JdaQfVQvBw+OMEEYSG0fhqX8d8U=
X-Google-Smtp-Source: AGHT+IFBkkoQabtOk36FtfqYc8ZUQnhLYoik+Qreb3ophWoDY5tLIXttH+D63mfzQSCD0xoXOJPU5A==
X-Received: by 2002:a17:902:dac8:b0:215:773a:c168 with SMTP id d9443c01a7336-21a83f48cf9mr30903435ad.1.1736319757144;
        Tue, 07 Jan 2025 23:02:37 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:02:36 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 13/17] s390: pgtable: consolidate PxD and PTE TLB free paths
Date: Wed,  8 Jan 2025 14:57:29 +0800
Message-Id: <ac69360a5f3350ebb2f63cd14b7b45316a130ee4.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
freed - same as it is done for PTE tables. That allows consolidating
TLB free paths for all table types.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/tlb.h |  3 ---
 arch/s390/mm/pgalloc.c      | 14 ++++----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index dde847a5be545..d5b27a2445c96 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -102,7 +102,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 {
 	if (mm_pmd_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -122,7 +121,6 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 {
 	if (mm_p4d_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
@@ -141,7 +139,6 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 569de24d33761..c73b89811a264 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
+static void pagetable_dtor_free(struct ptdesc *ptdesc)
 {
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
-	struct page *page = ptdesc_page(ptdesc);
 
-	if (compound_order(page) == CRST_ALLOC_ORDER) {
-		/* pmd, pud, or p4d */
-		pagetable_free(ptdesc);
-		return;
-	}
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -211,7 +205,7 @@ static void pte_free_now(struct rcu_head *head)
 {
 	struct ptdesc *ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
 
-	pagetable_pte_dtor_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
-- 
2.20.1

