Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BA20F985
	for <linux-sh@vger.kernel.org>; Thu, 23 Jan 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638910; cv=none; b=Q5kx4R6/2PJgrG8Uva8dt+m7+KMpD50Qjh5ZIwZsAvC08HnRBi2Ok6peEAeCUvNsv5gSELpvg0KCDMGOvKbGJ/kYaCvxUnjGzIKd1z1NxnrWax3EbwxAdAiQ64UTGfREsoT9kDSJj6JSfU1+UG+Sgjlm0TCI6RsE1Rm9a1H+hLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638910; c=relaxed/simple;
	bh=FefxEocj4IoJjXKARUpJHCYOj+T2Zg9VgaSRz05BYQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoLnqLEWHb3zse3WutIlLv6qAP6VhG4cOaaE0HpgSa+DfJylZip/BLyQ9ExIl9rH9dc98ZKcCbTIcJRTFkkifiRWz7JUCoBOU8psRcVA6Xj3Cs1kBMzXOGcvXMoGxGzlR92wkykVj2RXtDGSLD22AAKzxtgkI/MRfmVgbtFAX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PebiQot1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PebiQot1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so16873225ad.0
        for <linux-sh@vger.kernel.org>; Thu, 23 Jan 2025 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638908; x=1738243708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=PebiQot1rb6XbHbzslfJsKpQcKPxtVRWfvW44wiTQeZcn+FPb2jW/MNDRjdLx6k8br
         3442zb+LePJbf/eefreQDFW5bpNEpafOYF7xTQDkFXzsr+9Bbcpie1mckFpTKNXbUxAr
         Icdp3NKqYa9Vu8Wy47GHD4CXfEBFbujZ9DFs8y3+Ee7kHhTyn5o/FFBAmrU4zOwkWyZc
         UZMf6AHZ7e+UDvM9vymXCA7cWG/T++ephvUmyUCJnhiL5wmVftKMsdQMTigMvTqGAuvF
         KJdGHNU6mSbcLgett1i/pz5tgCxaiRDhYCZ2Zoc3DkRyqRYo7Vzi3ggEu7/h0YFGZxgr
         qcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638908; x=1738243708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDJpscd5iDH1/vb94JK69W34zwsdKCnkCWvmFoEl4dc=;
        b=dBGM97nktSyaGS32C2E0LRZzJqzPV2aXzlG9Xwp4+q0Jz8Xeyeu6CzU3/hwQDXngLQ
         V7daeGNjeC590ya1/hDfNRfs6mzHm07qUfeK1B4l7A46Jq63SUGZkZjxKDgK4EkBB4qt
         VCr6F0KYK9TnUioMf+yLjgjd4kpqXfD6+dEKx2P6LjdQCS7M9h0CnETxaBN6xLUzEUC8
         1nIefpP2oDbMeKhNmSK+X8Swii/krM/IkQP67eaWwSGjqFwGfoQfav3bGsH5ndEmi+dD
         mgFXI7jmg2SXqVlVtoe0dGjgBxpgyUjSU+UTKSyk+/SVuDUETAdaJay8gDq45gmHlz4h
         GVRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpij9tPPpyD5sljgA5SUawJeOhEaQkmoLXW0kj8J/m5ERZMChdomCWQk4uGNuCKuthXpxcsYhAag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9Kt4Ui6eA13GOSKYkUAnoWi25xPQQggjLZeJBeZI3bfP7f/r
	xcj/gGXnGHE3pcR/C1huptMU8XB431rFTrmEynpBrx6Vz5j6BjLr9p1sfJtcUJk=
X-Gm-Gg: ASbGncsilUUNHTSdsYIX2kmL2GGHf+pmsB+V8mpFWY8a+LxcqFtD/9wd5zNIYMtaBAV
	uNl+LN1yxy0H7S6bYlbEICVuOZ/QlCgpq0W5bdRcN4bewlc+TBc/jrrITO4xL/dVyFHDDLjWZnY
	r8vd531a/hsqVL8edj2tRqIAxnr45OJF2xm7yHIY3BjCy1PhmyY7ttWq20RwZqvOkWpeI5azf6o
	H1zQtgOfow2yBCNIbHnIh3mvkOh2RyrzSmhFRqxBs9m+YwPMoxBT5CzK6AhGG50A+EklH+f3viq
	6pAK+Rm/CG0Lj5o9uu3wiR0opjjd0LbHd0Ouqa1OmHgO
X-Google-Smtp-Source: AGHT+IGvH4jPt9gEk2i8wJlEQCGHtq7Z8F/nhrt9cHdxqXKECEeUfNk2qVC/Ig+lLuwaqRjslO9WHQ==
X-Received: by 2002:a17:902:da8d:b0:216:386e:dd8 with SMTP id d9443c01a7336-21c3540cd05mr367659545ad.17.1737638908563;
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:28:28 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/5] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Thu, 23 Jan 2025 21:26:14 +0800
Message-Id: <e2a1b07eda16eb84bdc51f6227fec02f2c0a54f7.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e402aef79c93e..10cdbe0e7adfe 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -228,10 +228,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1

