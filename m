Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44131AA1E0
	for <linux-sh@vger.kernel.org>; Wed,  8 Jan 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319639; cv=none; b=cYOoVl/yUJv6xEDYhE9EX9+riPTZ+DQmRZJCAbLWHOMIKAj6iWu730tAU5FJRVibfdXmaJVH9LHJjH5zVdRgtORKZoSUThkW6iO+ebrzg1XDNIjdws35Ufv2a3jQFM55IHoW5nLefLqhIw0PuhUINtlZCYd1tCGmxXBaAWRLdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319639; c=relaxed/simple;
	bh=8PYWh2+orWwYf6986S1qPEzSyDMn0jEmjPeP/Gs1msM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHhY/NjfO/iIuSxl/Opx5Ny/kWgQn6P2vrMD2iBFj8mHOX5BFSN8cCaAowKoQ7NL9tDctmmiIn6O53kQVRt0QJL6vt/ll1rC0GiE1chC6dQ/T0aHEiqFgPnT/pyO0MbU/Px5FPJFe5afQI4T06XC/5vNWO3lHNInpcuvt/VpYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D36doFD2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D36doFD2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21654fdd5daso225077635ad.1
        for <linux-sh@vger.kernel.org>; Tue, 07 Jan 2025 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319635; x=1736924435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=D36doFD2eeEmR2bn6CJX8f5wpGnEPnzm3By1w8nWkBeMfXzl3kPPwr4mbqOkXEZhov
         VrwoHhOaSlU+az/WyLPiDSwtFodV/d7k98qHBI47BBbBmYjGz7mLnhwnUKtd9lRrnBFi
         bhczabQP8GmoHfwUxnHtM0Vh0K7nIolVZ4keO6qU+QqCEJjqJ1t+1kgiuPAylWLj3lf7
         OYlKkbHZQNSSaIU8ju8jUadGcCbCbdPcu1WPO2WK/TdX0ptilPW+h759vInIarzE90sV
         78hM/2Eyh7svckrSCheuAzoM3IR2SdV33HEvReFeV1KYoQqUzwFE4/vjdTllVFU7wCtY
         0s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319635; x=1736924435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=nOfqkABrBFMopmg/65jZYZV6LHxeDGrQuouRAhJXN5OX9bPQBPnkdEbNX01gZ8Q9FP
         gEvkzraiHae0P1ZV71MLrH2jjgFA2r3ytZzymFNUJriFU5WTzydrNySM6Yr2geh/F0eE
         2VdgfvCGLebZ0qSQ15+D0Dh2FUEPGXLtenwoH8NZA3aHdhGE//wVKootBEf46DMkzlpW
         YclSewdfG4PwCQoUYHCteEC0hUfgjomfdD5FTkwtp6Iy+naYC1YO8h0iTa6htmZwOBz9
         sj7IcFuYt1MNixN4LqZ97JeKxLnOXK0CKwK0pz1UWxfD3BYvis2sHvmZHQ/ZaMVBTt5J
         x4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWjlPrj12HiGTQXGR9vro5Vwnfhur/UZxV6eFLb9QowKIlTHmg+una4wdOy7XnfEzWAQ9Gmpk6eXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0sBNs7Ezevn3vhTlIGdnZhrlN2nCgWyYMDKsEiPpf0AYbWPD
	dTM3sHTErIN8Xpdh7chHS4o61HkpjYjNNTXS3tZz4aGOpcLqlSc1uyCRtobFT/E=
X-Gm-Gg: ASbGncu/Db0wIltRuEWZRv0z/zVpa2SGOpmlPDCtTDncDK1qPqpyHwefpMD63X0wr6d
	oYcwf/ZiqbqIirpVeNtr66V2ZG8TgInQY6125Kh73TKCmMPqPRUSK7ng2cloBZFTeeDsNh4bIhJ
	DbyDeVqLqeLWlbArFp48QZ8mYHiMn2S4A/mhfOjcEMs1YywgdRoGIimZSjMienUSq0BmyH4V89f
	mW3P/KcCsvi010FOkAxUVyCnel8cbw3EJ5zg+11eD+O8e5jQaQO/CoYezaqlMfxNmwj8EFABx8+
	BWW+IyFWnFHMUT4PoJN9DwJ5zT8=
X-Google-Smtp-Source: AGHT+IFQatZJEh1vMaYN2M2lTtxd4TB3DgwS5fDlIHVUeP0cQjVCzCSP2sGAFE7qJT7hKS5hKn1bKA==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr23731385ad.17.1736319635015;
        Tue, 07 Jan 2025 23:00:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:34 -0800 (PST)
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
Subject: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Wed,  8 Jan 2025 14:57:21 +0800
Message-Id: <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
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

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1

