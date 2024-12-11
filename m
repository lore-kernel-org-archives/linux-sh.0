Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C41F4E3C
	for <linux-sh@vger.kernel.org>; Wed, 11 Dec 2024 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959689; cv=none; b=A8UtRvjqZedLBjJlGHAkGWD/Zn6QWLhWAUDx0SO08DGbqHiu/BT2Qmp9kW4cbPacMPxT7/vO3BgkbBd52GbLNMlSMZskSrtlueBhrVwIduArrhTBYkkMdFufe8yt41ZUwCooh1WGWFE9SRF7M/TN8rDXxA4M0Y4lK1agp8vvs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959689; c=relaxed/simple;
	bh=yEE7Rr9UWrNi0Mgc9EzqgQ6AB6dGlFOT3/O0VBhmQmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S3uNGwsENZY+HCc3RJIDqdbxb+SYZGYINnGoElPKUeFUo2rvt+5zBh2+WeG1XoPKohAzz1hGzazeYEBHilHsNKUKiqXh1Bus0s0rio/oI7vZuHM/8Gfv6q1KltAcqrusmjv2cqSv7ZDI9eSV4fC1uxz77WoR1lVSwZrmcgBLJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t80zD1iX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t80zD1iX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd482c8de2so48529a12.0
        for <linux-sh@vger.kernel.org>; Wed, 11 Dec 2024 15:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959688; x=1734564488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qH5hFVlZb/xpQlMxAKu7QZtletX8CELYGGCCA+g77Tw=;
        b=t80zD1iXHmUYdb1jKPlQBspv/0XyfAvo+kMO8LweKY0eObELOG63CyGR5qCg3kJO+S
         DjQQyeydqPuBnm06jfoyCa+FPL/YGkF7JI07DO0EguvbChMH0hyY3Fslh0XZ3gWPKaaK
         4A8FVfAW/R+sdzO9eKBLRbFFb87HOh493htqRQSQUzYZTzt1dgjbNsMnTsO9K9+xQhJY
         Ir0ripXawa9/ezxrLSZy2uoVmcZgna/Oj6tKn8ZeGVobrt9uuIzasmVMYH9XRNBcpZSl
         6q28gTQ0PQDPf20ywkG/bgAM/r1v1tF/wLvY5tkzUGIG9LEP8Zg3uGt731T8lX7H0BiA
         hBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959688; x=1734564488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH5hFVlZb/xpQlMxAKu7QZtletX8CELYGGCCA+g77Tw=;
        b=VJ1l/tCRiGjQ8lTDL2qXYII6+WDx71IDQTaDIdYSEXHV43zFN6QtqHlN3OgQmyhaVF
         3U4lnZVvIKtSM6yitYvj26VrFiFNoppzbhVowgtd1wri3nX2cL+zI0C3HaePK7Uvy2dX
         sZgX8UP9XpjotDmAhrzVj/TlCMF+E6q06702LcoizfJdXbyLP9z5GktLRwIKzT/lLKvC
         3n+YdwW5FQQAEfTn2E0Q82brqYiwY7/u9oRfqPGx3biVCq6O+OXqFO5WC7bYztZQVjJn
         DijLcQNnJytuCfvsnMEhraRSSS0L6DdmJTmBONk8sRqRnYokbeBY2tyPhLVSar/pZQcb
         alYw==
X-Forwarded-Encrypted: i=1; AJvYcCU+fFiCkga6CS6ANITSt6tlvTN2S6n8ddl5uU1QGyebXBit+kZPUcYDSxpX+3UjEViFoasl7esB6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5x3IpMtfRY+F3ID4v7WESOftuRUtXmB9LrFWUVlJvB9slz/V
	MJoMmqxRf1NwJOI7X3IzZzFyiUyhpDevj1kCijwVIeJnssXknruftFMRPNKS6tJ/YgyMlxdaAqe
	o7PzvoBTGHndqSOWHcXKkNQ==
X-Google-Smtp-Source: AGHT+IE2HKYkuc89mtKU0bTUEVS1IdL7Se1Uvka0+Ku7HObHaGYamVyFYxuD0miLaBxiy9U265ART8wkxAXV/hrgFQ==
X-Received: from pgbct5.prod.google.com ([2002:a05:6a02:2105:b0:7fd:356a:ef35])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7288:b0:1e0:d848:9e83 with SMTP id adf61e73a8af0-1e1ceb1006dmr1536938637.25.1733959687513;
 Wed, 11 Dec 2024 15:28:07 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:43 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-6-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 05/16] mm: arc: Use generic_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
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

Introduce arc arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 arch/arc/include/asm/pgtable.h |  1 +
 arch/arc/mm/mmap.c             | 43 +++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 4cf45a99fd79..af3210ea4888 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -28,6 +28,7 @@ extern pgd_t swapper_pg_dir[] __aligned(PAGE_SIZE);
 
 /* to cope with aliasing VIPT cache */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 2185afe8d59f..df01d4d9964b 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -14,6 +14,26 @@
 
 #include <asm/cacheflush.h>
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * We enforce the MAP_FIXED case.
+	 */
+	if (flags & MAP_FIXED) {
+		if (flags & MAP_SHARED &&
+		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
+			return -EINVAL;
+		return addr;
+	}
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 /*
  * Ensure that shared mappings are correctly aligned to
  * avoid aliasing issues with VIPT caches.
@@ -27,30 +47,11 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info = {};
 
-	/*
-	 * We enforce the MAP_FIXED case.
-	 */
-	if (flags & MAP_FIXED) {
-		if (flags & MAP_SHARED &&
-		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
-			return -EINVAL;
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
 		return addr;
-	}
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
 
 	info.length = len;
 	info.low_limit = mm->mmap_base;
-- 
2.47.0.338.g60cca15819-goog

