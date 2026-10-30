Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349508;
	b=QIYbt0n21UK5vDGm4SUM5HJ5WCUdVb8KMqAQiYcdKsOV0qQdTIIdaJM5l6BGDC9Qho5v
	 lwqZ5tjLA43i4Xk/vb04qQfaBn9eF4KNauBK2rLpsidIf9ZSz0d4Yad69J3cq/RWUdMg3
	 13A1JNRfmCjNeGLNNDVQRIS6D6WF6iUzD43X99dRHLtcncuxsqo6KznTG/G5/Pqnjt1YL
	 qgq6HFxycvSXm1KYnhBiPns9ar4isX5UwBoBDyy0/W10AdDYzi0cqTaYYQcVR92ytPpe3
	 rnXSFDpuoIBnsvk/BIZyl+FBqoTbIUhwZuAttt3FCYfzgkOSzfd+Od9Nitnl4+MyyQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
	b=js90bVi6CLA1QSTOpsXshlCh0D5MEVF1mYWV4keP9BK8iPpHBKx1ND3IaWnNI6iHsTDx
	 zKpO1f2L5Pf8eFfjYuxW7cYa5zOliCsTnItTwDiDxtH9KuPgEWSdW+7GibOSXiHAEeSbW
	 5ZxIDZD7sBaNBYU4sQUg/NfzF36oW4KtoijyVcYCHQepw59vnW5dWkpJVQdHhaI/Peuu9
	 BE3lXxazgHOngK+fbt/M4Lg08vCtWskdFVBbXPTaSPy1Zx9xCM2ygwe3qkIZ2rxj7/z1r
	 bo8k7O1mnA1F84ZlkXC+Bnrrd60OXad6OzjJxuiuEmPZW1ze/fMS4sOTJnU9YETNFmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DB60A2630
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 08:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A92DB60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso286485a91.0
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349507; x=1793954307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=lHH6tm9eFLhBmHpmdTsOkTK3m0JIEPEobyAy6uFj3sElhv15/krfzc86zEF2LGl09l
         gANlXa9+ttvNpFVE8BCo/X34y5GeAZHgYcshWRwb+tLEjO9u7xUJponHyaycOlvphmA/
         CNY/pQCj9auwT+9XNiX7L5KsJkoqEKjUVQuBq8L8t6MReuJnqehrSrKxGqsUz45vytRW
         6s2huHzN3py+tWUMsxojPDdwmCxyIiDi6O2DbC6mzwPhvXhQMQmOnjRBbL3ZSxb+67Mf
         IL1BSOy6qndNztXXGEyBjCrGUximKMiGuRC5myYgtlauUDaCp5YKeJOseTmSgMVE7HNz
         Kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349507; x=1793954307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=OpljTpdz1u4shwl91vSwdFZLSbSC2EHOyip+pb33+KsBNofA7esZSU7g2wSzh0tPkr
         8MHkqc7XleefL4wGxMLK1gj/xRdKVmncPmXfvp8EQogJyCpGiJYbSnE8IgKrxHYts/sk
         o4v3/cIdnfcQXCcYuaUiBNsOXROaH6UrwYh/GTfhtqOLF9CnDrdj+KrTmqASln6Mkhjz
         8Iw+Vem29DKpqgAFqzBZtHRg9oghdOeX39KrnuPZBMTFbiluk9NemJApuEqiiAPjZhUu
         vn2snKD1qdhtyCNDV26H96yU9AdKPLs5pp+Ms8cFaU8gr7Lveea1Nnz+ZzTt069qdyNu
         W6lw==
X-Forwarded-Encrypted: i=1; AKwUvBwn95+9CP/5bgcSsg5aSAvSyKsQfOImEcc6AZ2tz1HwvGEN4YrXd/Hu1eff6fvwZO24e1ADYlEbsw==@vger.kernel.org
X-Gm-Message-State: AFq9FYINfN4cNI9ynITIi1/YmTYEGIEmIYorYyhV1R1mdkU1lsi+8D46
	fORp5YAz/l0wQLBR9SrYo14mi5ZkNCmyN+ECtYr9dox+Gah/mMoOl+8EUNJO0nJ9tuI=
X-Gm-Gg: AYBFou3IS/+XBDqDto/zS3wdiZ8K/n2+ittnJZTI4nK0kI4KJllY24e4B1lcb7MvADO
	g5hLKnslE4XbuN+Zcq6oD+s20D4KmN+I7FU8fDyXQQqtrus1IlCQP5VZ9kpv5XaV1IupaFJdD4v
	rO2+rWOpfZVUi/PPvohmDKXoQafx7D7TtOs9LXpxqiqdYTuve/QlQ92O7BLRzeyfLhTz7g4UFj/
	r/zuvCvwqfHIV/E6JiZnB1jV//wHnIdKobyf32gB10lvzJWRINcvv0i72KuFXscePipug6DlQan
	FZqK6/FEqI3pPNrTphY+e+4SyH4vgB8Re6YcxCoI1aOtZnY6mKyOw0Yloz5K0sAgLj9RcONXuzY
	xFNhIelA8gdfz1eooUu2dp4g5nb2D0/LS+VMqqeEc4dlnb3Bx4UlhhlHq3JVrOmr2+dWqhEI3C1
	U2oOps3fGvPbKl/1BGkGBHNH67lABhQgH2BoPnXSDk62VFwQFx38SrOXSY1wvaOZNwLgsg8NITN
	FBTaK/DFgJCg6lbeSDMNZlL5qvQO0fOBB1JoAd656rvhD3qQ1XCaCIItBfxdkXoSvnj5aKenldh
	bjWrLGva2u2jTrytZ0aNq48eFRVqERTwyYArg0MUDRfKai3Lq5g=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3ae8979969fmr1091626a91.38.1793349506870;
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
Date: Fri, 30 Oct 2026 16:38:00 +0800
Message-ID: <20261030083800.599152-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pagetable_free() now runs pagetable_dtor() for constructed page
tables. Calling the destructor immediately before freeing the page table
therefore duplicates the lifecycle handling at each caller.

Remove the redundant calls and let pagetable_free() handle the
destructor. No functional change is intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h    | 1 -
 arch/powerpc/mm/book3s64/mmu_context.c | 1 -
 arch/powerpc/mm/book3s64/pgtable.c     | 1 -
 arch/powerpc/mm/pgtable-frag.c         | 2 --
 arch/s390/include/asm/pgalloc.h        | 4 ----
 arch/sparc/mm/init_64.c                | 1 -
 arch/x86/mm/pgtable.c                  | 1 -
 7 files changed, 11 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 27c3b91ac0b8..f607d239ce16 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -62,7 +62,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 2fe787e6c2dc..36ce18e625cc 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -249,7 +249,6 @@ static void pmd_frag_destroy(void *pmd_frag)
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PMD_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..4ff471775f2d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -450,7 +450,6 @@ void pmd_fragment_free(unsigned long *pmd)
 
 	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index ae742564a3d5..2568bb514181 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -26,7 +26,6 @@ void pte_frag_destroy(void *pte_frag)
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PTE_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
 		folio_clear_active(ptdesc_folio(ptdesc));
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
@@ -110,7 +109,6 @@ static void pte_free_now(struct rcu_head *head)
 	struct ptdesc *ptdesc;
 
 	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index a5de9e61ea9e..d554c475c61f 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -66,7 +66,6 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	if (mm_p4d_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, (unsigned long *) p4d);
 }
 
@@ -88,7 +87,6 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 	if (mm_pud_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(pud));
 	crst_table_free(mm, (unsigned long *) pud);
 }
 
@@ -111,7 +109,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (mm_pmd_folded(mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
 
@@ -144,7 +141,6 @@ static inline pgd_t *pgd_alloc_noprof(struct mm_struct *mm)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 9bbccb5d23a8..9f3cb7883f3f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2840,7 +2840,6 @@ static void __pte_free(pgtable_t pte)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 81b3bb9a197a..9929d7d55d72 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -156,7 +156,6 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		if (pmds[i]) {
 			ptdesc = virt_to_ptdesc(pmds[i]);
 
-			pagetable_dtor(ptdesc);
 			pagetable_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
-- 
2.54.0

