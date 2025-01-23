Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEEE20F985
	for <linux-sh@vger.kernel.org>; Thu, 23 Jan 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638950; cv=none; b=mt7q8Mxt3sK/oud9xe2Zdtej01/Zc5Dvp6ZB10WWdcFiu3d/iGNuDdA6d4WWAE9by0C0Xa7tdCmv35unJwjCauyhOFmTKifHEYhCICxD4JbgFFLcyVLqMzHSBb916RJrMEauiZBjfiOUtPhb7hz8bInICjQoW76Xnxpgtlt7v8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638950; c=relaxed/simple;
	bh=xyoxab241Xbf++2pkWevGXAMdg+Lltm4zD7nrlxitWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEXZVi4nMXXb2O4J2T1zUWzezF1yD4ItrRzDyVSqR1WKgN5yAYj0WzRiVE3tE/uNraohprJUDFOk7W8LNkuGhjN75O9jpM0DaRECuOflMDx5Z0CmK51nhg9F1SzdIr9Mw7yVTkxJcS46FKtkQNXiAOmBkdDxbweu155+d7TGv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M/dznGMi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/dznGMi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so13931605ad.0
        for <linux-sh@vger.kernel.org>; Thu, 23 Jan 2025 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638948; x=1738243748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=M/dznGMiy55gDN4Bz8oivIoQTni4ET1ZdrZPukL3yR3sGAC7Cvy+xQhynQvdI9/yh/
         ZQhlAxWVub1c7f2ZbaFFGvnfuvRkZb9H503JbCXZ9Vwkj9KLUpJs858s5RNnYjaiIaUw
         lI+tSM14c88PHsh54pfbFBxD5Suu8dOiyPSrV0KN+iVRZYm9Cm7ppVSRLoIHQSBzDtdz
         Jsh/HsULJhEJkCcTSeINtQcE8kD55A6TDD3zUx8V22bZSdALpxtluCsNKwjK4/IFZG5q
         ocjAsy04352y4mPBGnCbJBzRQ0CcXjQltc3ceT0KbJtw9ZluGYhD3Nex0Q5FhRZl2RLm
         rHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638948; x=1738243748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=KHKKE6nd7b2XWRYJB7qZuxLw7YBft8eNnrj23kevC9oS04dIITT/SsUeETxRpWdMiy
         ePq1hNY/n37nNGMk6XKsR/TFu0mo7s+E5PDAhiLlGHZ6opG2ap2cKnGeU1/l4NBZVKbW
         JY3h9Ty8KEUE2vvPj4K8mGeTqASzugV9KKQcjmqKNkxyILEgDzrHynHiMEYS+fg4R0+U
         u+Eokexz024ppQhTvnA74xLMsgbouJ0Y96ENFL/dJpQ4nWGRRDsWFJN5ZnGZZuTIUDRB
         uqSAZjLgKCypx+6lrEPkh46pOuApZqIxIXflaYx1CJi2rD/DAPO56m6/hFl/7MqGT8LK
         JY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmAnp3dlj1Uk5yXbKzVP/peDNLvqja8ZzZ7tVuszwUI44qXqD5xmXkFsNiEkT3AWmRtjEz3GXIzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GpNJtBmrYvpesuQ9z4V6QLg6V2IuzFG94qwSzjz6O/qAF8yE
	Xevx+HuntVPkkXO/4xPXQ+kRnh2zrhk19BhWvMAz5hwPlMoeXm40ZE/0Cn5fOD4=
X-Gm-Gg: ASbGncuiyCAvYUmkNsA9eAKFSNh44UOOn6qki9YoSTPJ5YKaBcoeEeKWQSgR9u4Mjp2
	V/ux1gwsy1/le5mcCuLzc+pK3vW2Afzv8Qd9K27JVii+B0QVcDxCPvHYPpKfvWH2SKI3mblSSA6
	x9RjjiOBt76E7kzH9N2Uas9AObHU5G0clhBsXgno2DPnBWLoL6Y5nOJZBJDPDTtIi3iuGBxn0Sf
	m/vD85XrLLIK6DcuUBi5Ef7835VrSWSoNTpZqWj7nLTYq8ZeQe1v4GYOqRIBEvypierTsXVO2Ql
	RHIqd/Tj+aTwBHF+5RgV1ZIrKpnXL5u0AzxNG5IcYhlD
X-Google-Smtp-Source: AGHT+IFkSdO3UtmG5jKkAJtanqQZSHufZoNoVtMFPHl42HZUz79kP6iB5Pw4LWGczfrtYHtt4kZUXA==
X-Received: by 2002:a17:902:f54f:b0:215:b468:1a33 with SMTP id d9443c01a7336-21c351c67acmr376126085ad.4.1737638948337;
        Thu, 23 Jan 2025 05:29:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:29:07 -0800 (PST)
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
Subject: [PATCH 5/5] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Thu, 23 Jan 2025 21:26:18 +0800
Message-Id: <62d6a04c3a0e70efd435cc2c8a4d9d07d94e7ece.1737637631.git.zhengqi.arch@bytedance.com>
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

The tlb_remove_ptdesc()/tlb_remove_table() is specially designed for page
table pages, and now all architectures have been converted to use it to
remove page table pages. So let's remove tlb_remove_page_ptdesc(), it
currently has no users and should not be used for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 10cdbe0e7adfe..dec030cb12108 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -509,12 +509,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1

