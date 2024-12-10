Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD331BA89B
	for <linux-sh@vger.kernel.org>; Tue, 10 Dec 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798493; cv=none; b=jNR7D8HOsHl07faTr0+RjLikekNQzQD9nMywUNIxoBnTXxrZmfmywPilBo5cSXr89qGxq9C22kG7hJMo7xqyLAdOQElSEHMwh3Id1Xh+RAzAr5wfO9U6s6IgqsQp9PYuV71rUSsjXX71owcJI4QeymjMtTharcCBVIPaEb3T37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798493; c=relaxed/simple;
	bh=XV1LugKdz2DpbBeuplWv0YYTqCyV+/pUJf+iX2EDwnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CqlnqgTMiy5MY8q/oJNowLpY2MlcHOtXlOFacodcwXq3kwGfQ0gvLlRL+lJp2vPPdYNlIv75iqVsQbKsduc5fbIpk1BOAbxe6zH0JHCQOCEkEgKcFmTG2GWzqzbq5QQ3v2UfSjL9f1JG2OfGkO+i9AsbyzoJc02B25dYsDrwwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDcER2k5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDcER2k5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-726047a4bd1so1678766b3a.3
        for <linux-sh@vger.kernel.org>; Mon, 09 Dec 2024 18:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798491; x=1734403291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=fDcER2k5i55JkEtmoMN7JjD21fhpKrJ/WuN4OLRK7RrQyWUhggG167Da3/G5knqten
         ZNxYsEIHxZPQzJ5cnNEg3An+JYtxenP0d5CoVGAC2ElJlcEwsBqqB+fT7S5aFVj6ONCd
         aERbnDRlphBZYTeH5uXIS6O8cY1fXhrg431RNuFfTsc9vCrjLClTnzA3+xghq9cKHIAI
         95Cmt4gVmGHS/qgBF8FnPUiWC3BVubSS9MyerdKbsQfinUcQY7eziRmzKp3IOJZ7GC3o
         qEMwY8Mf6ATkz6hBuAEE9xeFw4gV2nIrzTItDh9f1yyeFiHFJ5x0bRrOqHdGZc9M/D1I
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798491; x=1734403291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=DFZqDRhIt6FX11oUTU90sdgoTEOvMoQjFA6k12W4JGMU1B41tqZlsmi6LuMkiXRiel
         Htk+ARHOg0v2t16vFfFWJv2McuHPwqKWIN4o7qeVuW8gG085JRmr65Jue0RdMYNbY6qB
         5V0bMMAwOp+1R7qjH18Kz5oQ1JoJrDWVk6+8Fq/zMdVLCQDgqL2mC1KYMAMhd2o1r4dX
         epPFGTWUJadX6GhucP5dfcSeSCjnE85amX+XP200fHFLDYFXxH1LIvdnlhEViHelOhkN
         6IYsuOqVUN1D+/3fZa7UiTcgLrpuOk9NaA4s7xfbJCYRlG0OAp7gHDLsMTNLRAmK5ABt
         726A==
X-Forwarded-Encrypted: i=1; AJvYcCXY+IV3Ify7lRPLQmKCZNyRxQo/8/4UApPFe4KjRpZmBa3FLchhyiaJN7fpl6LLDbrkgJqNIftYAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i/gxQSOS3Zjif/czzhsxjPJEVR4m8AonHo/2iAdlbas0avVX
	m0kuKfWqrHZ2qaQk8Qd5gCQ6p6hoWTwupvjg2RmiAryJo1mJT0bfVxABKfG2O+l59effLiBxt7A
	FnmHJW4zs3vdBDKFEy8Dj7A==
X-Google-Smtp-Source: AGHT+IEtrC2iviCeXWAtkatWkkbrcoIFQnKfltvUj9wZA43T/YasMAjSbDISIyM+Y3e/Wy24hv9IDhoi1rtLFpgStA==
X-Received: from pfbcn3.prod.google.com ([2002:a05:6a00:3403:b0:725:db2d:370e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c5:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e1b1b5c646mr3881670637.36.1733798490862;
 Mon, 09 Dec 2024 18:41:30 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:06 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-5-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 04/17] mm: alpha: Introduce arch_mmap_hint()
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

Introduce alpha arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/alpha/include/asm/pgtable.h |  1 +
 arch/alpha/kernel/osf_sys.c      | 29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 635f0a5f5bbd..372885a01abd 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -362,5 +362,6 @@ extern void paging_init(void);
 
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 86185021f75a..68e61dece537 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1225,6 +1225,27 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	return vm_unmapped_area(&info);
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned long limit;
+
+	if (!addr)
+		return 0;
+
+	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
+	if (current->personality & ADDR_LIMIT_32BIT)
+		limit = 0x80000000;
+	else
+		limit = TASK_SIZE;
+
+	if (limit - len < addr)
+		return 0;
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
@@ -1254,11 +1275,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	   merely specific addresses, but regions of memory -- perhaps
 	   this feature should be incorporated into all ports?  */
 
-	if (addr) {
-		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
-		if (addr != (unsigned long) -ENOMEM)
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return hint;
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
-- 
2.47.0.338.g60cca15819-goog

