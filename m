Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBE192D91
	for <linux-sh@vger.kernel.org>; Mon, 23 Dec 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947000; cv=none; b=k4rUKBUsGb/3xxsR3kngbIESW0yUIKYxysBe0oIRwP18YvFdowIZjOZRSO+x5yyh85B3vEOJEdd73ZAHvEo9p/+tUV0eSKbPkDF7V5WP2tv/qg7+XyTl/NyjxQrokXyjHeHIZRMKOqN3OPhTwg4iF45dfOiai/TQU2Xjquw2+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947000; c=relaxed/simple;
	bh=eSQ1cqjI0k4SQFzb/dlIm3hCd3v5CZjZJpupq9IDdtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9l8+ovXt7GFJo1hsENEkjAAezRZrph2geMRJlWMiTI3vPt6uhYd3nwIBC1Ot6FDVf6DWCbTOliS6tPfLeqaeArptEHokzMZPMM5l1IRQdCuv/NGhZYdspDPMz2rXG7KNyj2iqvF99LLlBqkKCr8LCdirgO5mpZDrIHqUMmiEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ht+5ilzY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ht+5ilzY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-8019338c2b2so2381103a12.3
        for <linux-sh@vger.kernel.org>; Mon, 23 Dec 2024 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734946997; x=1735551797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=Ht+5ilzY8Y8XYLiW9Ff0M8w9C2lLtWgJAwin0q+DBGggZW9G8x1NeFvrT/DmYzaP+s
         V8FxEkne/FTfG96izndxnklHmrQpys3F8suSdWDww+RgViN+fX1c3x3Rvx+hy18rFHRP
         hFBZD+UIP+jCH9ra+z6AVokYgAUUePp/+G2cuUFsrqxPYsEXDFWjHoIzUktjv8G5ZPsd
         BMNsPCOBLoV5KtXFLs6pxcAbbdEiatpbkDk2k/6kERUHvpCHIuzXQrEzCXxhuMWt+vm7
         LMeKU7bPIJ7SV0VDUfI3A8h6v7wScr/YWW51ipUwNNfD9r2yDFi0LRCNC0IdqacYpltN
         G5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946997; x=1735551797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyzxI6H4ZAISLyWZ1lhQ49SW3wSD1SDR6GIh5AHA3wQ=;
        b=xAfPWIlvo+DIYcMZIe7iD5/3+ojbDk1hKQD3sWLuRSubPEnPxVtkbWvCgT6Pii06sr
         PQDmylgJA4qS16TVirXnxKaQKBIdHq7WrHh8lu7WLT2Scv8If0O2Yqn4Ijp5h5kyjP8a
         IDAJjK7e/KuOZyGVBQ9PfvTFPuKs6ypB3gYm41iwsyToTbMF175B1vkeWGp1ScSCLC/c
         uWOJNeoUnx1zZzFnnq4Oke8UYQ7ce0zAMfndv52HvazIJqwM0c15BpDjp88HCCVY/SUc
         TIl+ied58zmUl98FtVfCyFzsVtsCLIVr9MywTUMhwp7VQBPaG1Bv5YKCnn4gTB4iMUiE
         8p9g==
X-Forwarded-Encrypted: i=1; AJvYcCU0PqHnPplhti4xgS7XxSr9FhOpG/rJpD1Hceg/xQwSsrl4wHF1GxU+erwcEF0YWCdUfr/hGbEjqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJhts/1z4Zz1JvWApC/gYewjveyI24TwSaTpgh3wg66KbbKKS
	cL4GedFRegaWdUQj9pBdsnTKLZivoPDBckd08lkxg9AtiRij5+HXjDhHBra4iSo=
X-Gm-Gg: ASbGncvK9wbnxirqJTbmluJjEOmaKRILywusdionq0xR3w5Au1kPl3+R59kGhp0zPHw
	0ZVX7TMN13aPMteSvinnjkv6Uj9ZbOvxMjWPzBYMzTJRgFuBt1jwelLBXOJLPwB3OPvYhbHfEo1
	IUU+FOYgkXSuxG0VXf5E8vl30SwwFH5xwMzuXrsJ59kjWK0nhNFXF5iu/wx7WXdwjj1pg2MBa1K
	3Vk7Vt1WUfZ7OsbATXtRYEpIxfVLDjQVvYHDDCuQ/vsQcMm9uA4sH22pjzrx6sIQXsgkCSMIutu
	HMbEmoFYc9YWfS+wShB7Uw==
X-Google-Smtp-Source: AGHT+IETS5CqVMOZwuklYBKyw2d6q7hBKdfBjuJ9ZQ+tZcvMnTE5pZk49SgpvcM01OaAXbZV7hq4vg==
X-Received: by 2002:a05:6a21:6da9:b0:1db:e338:ab0a with SMTP id adf61e73a8af0-1e5e0447f5bmr22664720637.8.1734946996090;
        Mon, 23 Dec 2024 01:43:16 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:15 -0800 (PST)
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
Subject: [PATCH v3 01/17] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Mon, 23 Dec 2024 17:40:47 +0800
Message-Id: <b59adb960b2075822a6e57efc7a52e7eb7780068.1734945104.git.zhengqi.arch@bytedance.com>
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

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d61b9c7a3a7b0..c49bc7b764535 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,7 +2925,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 90ab8293d714a..6b27db7f94963 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -489,7 +482,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index b9b05c3f93f11..9423967b24180 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7034,34 +7034,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1

