Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F71A8F6D
	for <linux-sh@vger.kernel.org>; Mon, 23 Dec 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947100; cv=none; b=oBx1vF/xgVDmI/Xy0cBAbgbzuf0PuBolxG+SFkWC0NiXPpJ/+QGIp7wf9JAla3urMz33Swq0dOvfew3JsvgsKt9lHznvYfJYYLHTq1oFYwTcpBmKw9iPsd4ITCVqs6HgG9ZFsmMBGgRqpA9HwOFOvT0dwveQ2wUrLzhcwBDx+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947100; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4n1J2Jg9HPAH7v1thKXXRBuEMKsjfQdpGxgi/azZOjVVX0fbfR2KyMpLf8npA/e9Pg3tiBn7Iv/EKgTAfU2FP9HpdGsAmo9WcJoRNvSTRdKPQU9BubcNJ0ghyRk8W4TM7MpVt3TiaZ8EnbPR7qSoWDhT6zT3bu2blT78AQBKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IZ3BPeGq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IZ3BPeGq"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728f1e66418so3210250b3a.2
        for <linux-sh@vger.kernel.org>; Mon, 23 Dec 2024 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947098; x=1735551898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=IZ3BPeGqREjYEkMakR8CC2iUnHDDNsFV+SUiQ5Rh+kKC1Voz/zW3kW1AqvJIQr96Pv
         Pn4vAaQAOdSAN2DwUNM621Wc+nd9U2bHTPDBu7o7MWSd8JcT9Ts8XoPEmWGH86KaQoKP
         IDr3ALL5a6oA+2iVxE1gqf+cd3Rv7qurRyGZjqj+tAT8FJlNgdyf3GRRbq665CN4Nnkg
         cdW6OUjO73QBCBhhlKu+9ZAwtkxylw4V8mRXYT53HMP719GfPweSgNPj2yBXG4orTfaS
         Uj+Gn8qfWjOwXlFS+kJjdbs8jY9SOhOWOZD6mcRzI6kZHuLiYpTq4cWbSXeQFCFdB9y9
         zPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947098; x=1735551898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=Ns0gJbfwfVznYrJnmXxvdZI/PR4PiilhjIvs9OIRgijohavqAlnxzfBXjSFlDSuc/N
         XDSnCkpc0m9Ru+zP5wCtLmVz9HKJpiHAUgwwZ3hSB+3SUGxfI4Az29BnQedscMl+2vQ7
         sWsOZo+m0ZuRHdPFxbt5M9GOQkJsjRUg0ly0OVJfLWZsm70yd139IVBjKRmLGKiUV+VV
         RBv3ThzleC5SGweaPuuIc1N3cMjl4T8wJzup5HBROjkomZLC/gwVS4xmi/GP2XcePibO
         iYOXKVSnRfkOk+WwR7SLaS3BmB/JRQp0+annBi3de4AgueGOpnYC843DMy8kux+khtZj
         xFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXwMeJePg3lDtfr6EJH33bPzvOZGAgdSGdI6ogsP8no4agciLlwVUxniHeNQBTcEgAm+elIvGumQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBO8aTqda8SxCzc2xR6iO6hSr1LtYlvssgANqYCu+jIpnydb/5
	I7+hTazt2BXFJ/9jp+CJkBpToMP376hLYpuzqiTLLScAJE4+UhkLtcVabqLY96U=
X-Gm-Gg: ASbGncviyPAsQk+kuSbkBidZNlVENZw7mnMRyXqtfJnmTdWbnlwQzUC5wcCLPbiTi2j
	BYrSdhm2EpXvVNRyEZuP5lXcSKMJzPD4BQZU4GmxmrQF/5WkhxFzoMS3va8CmluOTpKynszQqK3
	vYf1Ut5A6y1l9s8U4oLC2QTvnllU6FjwdyPNa5JySiM5ImIhiY9UC38K3Z6bb+bp+HHJD0+g+9A
	T0NA4AhWR68VYnR2WcD9sFUZEV3YRYC0Bru2Qi6KlPcA3Op2RWg8oA4kSjVLQ2o3FVvSDRYVcTx
	5h02Sl20AKGgJEapG+8YWQ==
X-Google-Smtp-Source: AGHT+IH27a1l8kT42WYYi2KTFhW6smXjjCcrkYYj/EF7HLDGUXcMfllZ3ayHCCSFU+IsHMUxZvkRwQ==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1e5e044b1c1mr19165305637.2.1734947098042;
        Mon, 23 Dec 2024 01:44:58 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:57 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
Subject: [PATCH v3 09/17] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:55 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
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

