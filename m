Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718FD1DD539
	for <linux-sh@vger.kernel.org>; Tue, 10 Dec 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798507; cv=none; b=nsZ03/7QeuWv6msqe5W0R/7lXXBeUmvN16DJ/yW94l09rZRNGLSuaSueihryo5jk1tTX1gnwaruzrKPsuhp53BQafO6DAhvM5O0xRqRfP3ZjgIJHvPr3dwgstylZtGa7frhPGcJR8Tm+Yxz4Z87sbP9Ssgfp0oiPf7Qe60r5u9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798507; c=relaxed/simple;
	bh=ywTAJIfLhhOWC1guj1Sw9xqYCRfd/ndCzXCmqX8LzRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8jECKYgAJpvQ48Jeg7h1vMJ9kFqgMr8somjYakATwFP3xtTQtQoE5RR3Kbel5x8/HXNAuZfcVaCeIMqyZsK7XMLXld2SKGB/g5cPnJ7wMX/XjzqlRyCoF2CLhzdfrU5bkOl6g/Bl86nhW16dLm+nktQYii1JhTIHw+GJLEwi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/kuIXz6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/kuIXz6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee86953aeaso4931208a91.2
        for <linux-sh@vger.kernel.org>; Mon, 09 Dec 2024 18:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798503; x=1734403303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aDg6t/gxrjVFwoXlm7hf8uYmo33EMje8zgxFnq8ex8=;
        b=q/kuIXz6293aqrSp2ZHIA6tGs68PDbfSyjTaZyhSOrR4t1wfDbv9oNBDv0detqA9ex
         rQE20GXsxesvyi+nMfvLpmYqVUpJBueYFPz1aUgVu5/RcbgqLXchEbJWHsi+P9Fjws+A
         whV96d3vye2We1p/Fuw91FdnJxqqofX8g/a/XuteNF07beHZxJTsNA3XYBFIlDW8RGJ9
         YQkFH8fL9SS6o0zVefn5rk7sYkE9vsvTZOowCpfs1GjUWda60k8N7wRsRCO0HUB3t99P
         l5Jkhe+ljs1fQqhp7+n3bQTgQ+ErQeL/GfKfJip6NZuSZV/dlwISH5EAJTTDmq5FH2QA
         ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798503; x=1734403303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aDg6t/gxrjVFwoXlm7hf8uYmo33EMje8zgxFnq8ex8=;
        b=Hu0StVW+zqcfUwpTvnTbABTcH4ejmojcfWJncg8Zb2FWv7qEltuBJRKf4UKSRyo5vQ
         j+qzwuA75vGRvJ89XE4G3d/6tUtOOfZ/yC6Kut8ymjyepqchoidSwVgB858vbkAC4KOs
         8m0xQq12AMMQZxJ9wm6tahUh8Cqwbo/XtjybSXesy/xcelo1niWR7p231LOOgqX2HM8W
         A3E7I9d+CUYFsf+IUpU9pRrCE+AqFoiHAKQCF55P52K/F0UhyIT2ILi45yjobwbCh66n
         5W52I25HX/AXgqFc+DZ/YszdBOq2zFEmpt2EA7FvKHGj5w8R2CsFKt9v8hJ5BQy8QlS1
         N8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWLO5hWCHBp5HIKu+JoImNagDdmixCKkEQqJA8X9c2gYKRdnJeMe4uxyLo+wvYAMe06y1AS0hoKVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtE9l3LnZan3GKIIqU9l4Y+mtS71Xi5QIS+OO0lTVihNfiPt1
	GhzioVPvYkzXsWwVkaM/uyuxd4dflW+85bEbeD65GU9i5MyXbzpZrPZkWEtgRG6q9KbArc/oMvW
	APlMeDP9zAErHTgoILz7aPg==
X-Google-Smtp-Source: AGHT+IH7F6srMqCW64XkYJ4oxpvOqe9MgKa694plvhzavfksbdoDji5OgmDgGGH75PkB/XQatr5z5MeghIRL5RnGbg==
X-Received: from pjbqc18.prod.google.com ([2002:a17:90b:2892:b0:2ee:4826:cae3])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:50:b0:2ee:c797:e27f with SMTP id 98e67ed59e1d1-2ef6ab296e5mr20079147a91.36.1733798503563;
 Mon, 09 Dec 2024 18:41:43 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:13 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-12-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 11/17] mm: sh: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce sh arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/sh/include/asm/pgtable.h |  1 +
 arch/sh/mm/mmap.c             | 48 +++++++++++++++++++----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 729f5c6225fb..072dbe038808 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -149,5 +149,6 @@ static inline bool pte_access_permitted(pte_t pte, bool write)
 /* arch/sh/mm/mmap.c */
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* __ASM_SH_PGTABLE_H */
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index c442734d9b0c..5c96055dd5f5 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -51,6 +51,26 @@ static inline unsigned long COLOUR_ALIGN(unsigned long addr,
 	return base + off;
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	int do_color_align = 0;
+
+	if (!addr)
+		return 0;
+
+	if (filp || (flags & MAP_SHARED))
+		do_color_align = 1;
+
+	if (do_color_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long len, unsigned long pgoff, unsigned long flags,
 	vm_flags_t vm_flags)
@@ -77,17 +97,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (filp || (flags & MAP_SHARED))
 		do_colour_align = 1;
 
-	if (addr) {
-		if (do_colour_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
@@ -126,17 +138,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		do_colour_align = 1;
 
 	/* requesting a specific address */
-	if (addr) {
-		if (do_colour_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-- 
2.47.0.338.g60cca15819-goog

