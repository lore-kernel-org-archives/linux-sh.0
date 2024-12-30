Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0501A38E4
	for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549835; cv=none; b=pibR4tVQX6xFhHMkG+j1ry5HBUC3nnhZvXLBbRTExnipOFNLudSEVxrWm5sRP+BQ1uCfIurGAf/l5uzuq/6iSxZY7Gh6q3WeETg7DFvQsL3+C5Af7mErvXZWGG6XhXbSdT3WOwq4ysX7RXYNKeZiyTcmB3FkabOIA3tAWaFfixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549835; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSRYFbhFOrx7jK73Q7YrQiqAjkEwR1AGgRzm9lEieXhc6z1y8e9YIhTc1Gh9rPqVwF3iDaVtCSEF29gWIIPzAtmS/2/WvlEMFCucXzrpgF0LLZIboVxOHOT7OGbBHTTTvV4PWBbrSCzIYVTBqcdU9tBv6g0wUobJEIzP24lOvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lpmdJRKR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lpmdJRKR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215770613dbso83815515ad.2
        for <linux-sh@vger.kernel.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549833; x=1736154633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=lpmdJRKRNSjV6jzealahBTbWBkbRefJLZhZvysU1hXvoXIMV6ujKiH8TOkeJeYR0jn
         vt+weg1F53fTu2H67buFBHFnQ7Aw0sKwfjNfo39vDGDENOhy2pNOeE0MgzO208rDj8GJ
         +vRwboC/mFKKNu4NJWYZ2fbkTzZBY2eFpYPCBuBibvTgMofe/hSMFP3MqeDAGDT20Q5l
         xoKD6EkwtzB2udxGv9zAku3XDiJcK7OXnblIDB39BEFQGdhkvy9p+UYtIwapYnx4ACeL
         0xJ8gtWzRxKDQuJW/wRjeaLkGrtQACzSj0SRSrJiF2Ta24jUIsPARuTNR8mP0s63NmQI
         PGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549833; x=1736154633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=RL6+z697nieTQ01XDWEHLHAwHcbBRRqqDYksn+hgWGy/BGPwOCyV5ni4jemo02I7QD
         IoivDqm/R1ss+4l9ZbhWzQ8uDWuLuMd8LlkNKgfpqhkwB5zORJtMG4U+vk+Ljr8vAhqd
         EvUomSRBHq8wd9triyaea/1DsQed4SFLlwQoyR3vPW7x2gLHti5RQ7x3iRzY6kETJsSn
         OA1z/uc8fTgGPVEZC9n5Vn2FIYMjonrTeTfm3oF2yPbNu/DJIwl3TcNVRQwEb5HlRfjd
         1JUGW3lwJiZ1vinsVUp50RDiDQRFe4zMRb6zyahDx1c7+3SIEVfwcaIm49TW9dIFfi6I
         l6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWU1i9BzLVKNZnFPUNRBayhcNgrLj9gytjukinZvaKGMRFIEWP/rxsgyPvgXSSmgk07nQ55YYw09w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqKm2hvAyN3DEOJ4MqNNWZcnp1R+8i2YoT7BZ1e1bJkJcU/MX
	ZG5DNzDzdab1BsxlgmoX9uq+7FapJ8osdHM94VT7SO6mtQR7eyPonbBnyQgoFE4=
X-Gm-Gg: ASbGncuScRLZxZbB94feGTmc9uAbyRHRDNqjf1xDZ1iC7NusoXZpp/JQzcDH0dEb7DC
	ElxMA26UGLNACFna93L48wWO2wh9cY6Xhnqs1dia9SRP4B8AKgbOB6KTfOmyPTYk4w30SHU4mB0
	jwG7K3qTvEahQbepFAVW9+xbF6KxQssNdPV5i1DczLOnnYOJ6WuaMOarLNKP3LqCvK6KRARy3VQ
	yoyqyy7qSgUzRwiChehup2QpX2mLxjjbR4rhZcUwNYI0lHjkRRoz0YR+KDB7Ygd54m27fG8jdTf
	Xkbe/NgJFIfbsV/RoWKMzA==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
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
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
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
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1

