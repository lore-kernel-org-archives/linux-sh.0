Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A01A254C
	for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549823; cv=none; b=b+fBaY3YT/Em1e41AYD3kOvN3JvLHxUGB0iFNLATQzVgNRvf27lRfoFpWZqRmD+N6QBQshO9aUvbczPTRf+KxLdN0OPkQHJoASGqhx2sT6JzjPZEBQbih1kNDW9E8z4fsSojqdQyyzudr78BmCJywd3xn3coZMnCRk1sUdKYJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549823; c=relaxed/simple;
	bh=H/x1u07M3HXF9oVd+o3reuerQgd2pca8MMjlY49GFUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK/riNZlDvpNCIkqyOEWI3J7NFq225f5JXC28pc/WhPqfa1kvksH20R2GaAqL0keHR99OB0Ivd8Vo0ISeaoE3qdXEiighkcPXFMpeBXlacOrcbMVuwT+kvqubBz2Pi1kI7fndS0dlKDknNoIUBXqxBORUq9Igm/qrgcENa60aNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QtFMIkv2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QtFMIkv2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165cb60719so116239435ad.0
        for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549820; x=1736154620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=QtFMIkv2dn6svHZ1SXPQ4UcYxOWhSxEtecpc9ZcR84UJIkvDc0nxxdiBEQqkLzNte+
         cOxd6huGH1XR7kB1cB/zsiN7Qx34VpSyDjv955svhVtX5ie0cLqDc+DpV+m3aY0sncw1
         tWKBxDXeRR8moOHkZgP3jB7Zs12UvZbtQnBi8xea0wQiKkQKF1v7PoGlx7OKqV1QBzbr
         JMa1XWurnJ+ziDTJnN85CxxdfmjzNS2FWd1eRtGaMIIYQ9zDgH98o3haRQTCSQbHZQv/
         DZ9Q2RF8X4RYJ7RuPOwnMeo6uwMeFpZeYBos5Bj51v3vzvJDZjzS0uu0C/dhUOfW02Tf
         fZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549820; x=1736154620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA0mhWnXo6upWemI3POPEc6VJyAkyxFJggkOB6WNq2k=;
        b=iCWafmPBYGZfkwBhy0QcM0FTmm5jyR2z5Ob5pNrBZzLybRWdm9Wi2x5qibpHpj0YNf
         vEilhHlIddL+KnxbI9lrYqvPP9T7HlVz0bTmuNwZ5s1a1ti6QaGViZHBp9VIaUaUTgid
         Y+ZlZH57T3TXp6Vl6p1CNvydPU2Z4VGIuO/aWvG8zoSQyuKyxjlrHXk/VonKb++IFpWG
         3m0pMMCFsj3Sti3J0bcXWqzo1WmY6Splmp5PCBovUN2lAW6fr8Xo9tYpYk/p3uSe/LwQ
         ndwAOdDl8b7U0/G6UWjFL0pnWCDWw+pHiRjzrxv3Ucb55e7pSz45ibjJuf63e1FRRj0a
         s0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1dKeOJK8nT5FRdHZ/N4Pq4IWQOoMe21sfL9GXnE0vQWaUQGojEleovCGrBzfPxcgaPgbVVhC/NA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18iiOruSEYiBL8miVHMwN7F0hgT4iKQrIheIgweu9nJOSLJSK
	Pp5BVCsLW6QsqznUS1jAIdMpPoTV+/DCxDvtLgmk6hUPYH5mhYwvqBxFIWAbTmU=
X-Gm-Gg: ASbGnctKdgZG3SmgelkZqert6TV4bD/5gY2TakTi0F2xEBPQtx8JvxD2MLLroy1P9KA
	7DMfGGHOVUiMHi7wlmvhZ+ppN0khO16ezVl3tfC+oLzF+YdFKmMhpyZavAPfJX15AcLeKwBAple
	mx1/UJPbxBTs0pInfjSYX+NcP6/sej/vcTKpRt62k8snE7iWbotHIqWdR88WKVK/o6cNPCaCGRS
	LNkz5wl9Cl3no6tLL1LvqZcOLxM0qEJ/bTTN6pC28LhkGVnIB3FXJCuqqcriaLm6AqV5TyuN40m
	FQoc5muXVQ9V1Tl51znrAQ==
X-Google-Smtp-Source: AGHT+IFX/3Df8AQRXbgF3uoP6h0ZSX98E/foDuPWt5IdgjLk00IpLZqU8w+lhMMb/JJOCncpjT7B0g==
X-Received: by 2002:a05:6a21:670b:b0:1dc:7907:6d67 with SMTP id adf61e73a8af0-1e5e081c8d0mr60502051637.40.1735549820172;
        Mon, 30 Dec 2024 01:10:20 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:19 -0800 (PST)
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
Subject: [PATCH v4 08/15] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:43 +0800
Message-Id: <955162bfbbcd9fbb3b074e1fe2aef4f64b61d6f9.1735549103.git.zhengqi.arch@bytedance.com>
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/tlb.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..264ab635e807a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,8 +43,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -61,7 +61,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1

