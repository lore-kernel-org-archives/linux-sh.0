Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234921A239D
	for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549773; cv=none; b=L98Lp79MnYxT+A26s+CXWsTvOG/nNYBhYSBsrdGUgaGpIdu8xzAQs8QMMfSuC41uGFIBs4P6yuJ+4DLL0pjTQrayDi3OgdjUVT1u08fRsFABoktLqPS9YeC+ES8vqgF8xTUrbuXzX4L4QecB6twMb9idyN7gUPGrl2Rc1kmi3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549773; c=relaxed/simple;
	bh=iGGseqx9Ut5ViSPAG0PhwW+aGehMNfQFpL91q5ypQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8V1u/NRUNlmlnJEFtk1moCbE1PRld6zQ+wQc7FcMXlWFWTh7VIZNXyxvGYiUJQuJjQSoh/sgO3u/Evg8VHAzT/jqnyPZQSpe6j8BrDFOfC4KU0RSgf9MRpHUP3KwSRtWyT+ePP64MHJMGCxE3Jh1iKnAyuuionPOu1GLKvjmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LU4QW+MN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LU4QW+MN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21670dce0a7so17227265ad.1
        for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549770; x=1736154570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=LU4QW+MNOhbE1wMpxZf5W8BWtU4X4oesBCIsibBGNOHSaMuRf/wJZx1ELNXh9cA7hS
         89G5ezs+gPAJPOFoQsy9KLlYwcajFd4kC7pkPs0o118RQTdClzCk/GCrvuGtdYHN0TCw
         /T2HwLN7LR5bih6T5OKPqLyUw1eZSumtHmJZ2VHa9b6542IXnxnqYSTmdUPOzu1X3e5u
         9LxelDQFkyZ/Mvfr/D+5OWJfteXzxmKSpnEe/hMSkBBmMj19bN1uIxrFYKYbg5VamT7j
         +CLw+iNk3Lx6FpLsOOexKakWrkKYcE7rkZPaQayuWIWfdyvCzdHtWaP26ygOogTCPmed
         9EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549770; x=1736154570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=A1CaY5VzMYt4PNyWHIiuFStIx9eYPVQNYiJ+yaaLWM/G4k5lqDRLzawOVmMggHHzFt
         1QMbFwID5fbCfitJiOn9VQIN+U1t/U9lIIG7fOXDudGaoEW67QlM/Tht2a98x693nPCB
         J2LisLVLgkKopelrJzY9dxi5i4L3kanVI+souo8BeTFfEU+JsRBnDCGL6C3e7r/WbSDG
         Q7FbOWjlkQT1dH8pu3nyipHxe9dlmcXaljxSFBAff5UIhdU15W7gu332Kt20Z5yRx96F
         suBXEQfBWCl9NS8W5bsDvNsygSF1bDZ3I0V1yeTGOy2UUf7k6cWCb45uxN2oa0EiUJN9
         f3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXtosm8qlrGhu0Gg1Pj1dNv0CDOSdErP+Y1OMzLSH3AP6XgMLfHU0hAe7CdckaDTNXJ4nN3VoCSNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKr6fSIOwR1v9kR/e6EYiKGuWjZ19hm4xn6Nz2z5xPgT5yt8k1
	U0QryOJjWHNp6EOx6wao4HWjoQR3Ibi9jW6zUMxDHDEuMdl+X/GbMSaTiasHugQ=
X-Gm-Gg: ASbGncurx04CX1mcxbP+l2q13bqBOBv+ldER38EfT9I6QLSxx0teUEGI33QyaOU95wA
	d5CelU2pREIUZk65pyf1zAV0jHqkBLku2i/GaK84bU61+ygbdPzRr4A3WScrZHiZM4gk2Ob/FJP
	dnvD6JesUCZy8mtIbzUam/neHH384w/NmccPTqIDIzrsJTnINEFpD0yLEFVWfNVmTdvAm94fm2n
	OgO+6jDdsqezzj9pEjNoKxZxJX5gKufh1/qxh8dnYQx9rKo56Ru+Rj6OntOf8Af+vXDzBvD3buD
	f0Wluq05bixcilzhX013rQ==
X-Google-Smtp-Source: AGHT+IFhgZxpyzdRj713xWVIn5lnq5dMIdipHJPkhLMIEEbSziCo236oEOGt7kn6Wpg3lXZNnJqwCQ==
X-Received: by 2002:a05:6a21:1517:b0:1e1:adb9:d1a6 with SMTP id adf61e73a8af0-1e5e08439e8mr55857078637.41.1735549770532;
        Mon, 30 Dec 2024 01:09:30 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:30 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page table
Date: Mon, 30 Dec 2024 17:07:39 +0800
Message-Id: <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1

