Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669554704A
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554792; cv=none; b=a3dAgmL7ytGRZVwOOt1x7eCwLfP6aelsqmjkLTUoXL1WxJ23Iad236/CH3stbu2PFQUuYw5PdG+1XWu5mdE2EAoTEWtUtuukn32x6ayfNDAW4sjNJiNRS9Hi8WauuAjIHKECLa+TOq36jUJlgMMsFEEtlV6nnIjaHgTqLjLhpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554792; c=relaxed/simple;
	bh=NoPlYYdvriRynUszPSql8w3mlOghDAEFvgvI94lPEmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WVCPHP+Euk2xe7QCwG+jtxs4WZwpdsXPpuu0M162/+aH6GKhcaV99bVgoVrhfo/pjyH5d8DdI2dFJfNd6/Cg2UqcHuAflkg8Xp8rV5oKKDwClat2qdjsaMBXEDMi3AMiGwPKwFGJl5J7dk6j7N3De/tqKcbOwoU6g0KRZF0TkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQF5K2w2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQF5K2w2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so13518885e9.1
        for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790554789; x=1791159589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tIprfReE5iUA2iuf2MpnGwQ14qWaMzX9pXzLu8I3APE=;
        b=FQF5K2w2Kj3IK4CabPCIvYCA2UPPdAYO5UJVETlBDvWjasv4n7vpk7jgaXCs5XZErc
         kZFkTwW2hk++zpRbomCPNZYM4bubQuG8cGWcJFjbxk0IgPLbWtUvMKAj9yD3zJNrpMBX
         Pw1SIwZysc+fZdUlKksAXo+krz2IrGar09xC3Q6c1bquS0zxcJ9fJPSrN/PbUZzlC2qQ
         waVP3O8opjT8lEozdY0Ch9Z0C6y5A2RyZ6vAJC+xMppVkXqFNgS+K8hTi7YVuWNy0YLg
         0X9/1aIbRoGnxIprCwciSfb7MijFTMK4b64JEp9Bmz/VolZ1KebzldBSrQAH8Zbel5XC
         iJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554789; x=1791159589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tIprfReE5iUA2iuf2MpnGwQ14qWaMzX9pXzLu8I3APE=;
        b=PXaDXnCReEzfbIn4Z2LYvsRmyaMxZY1gUAHjuRvVRa1rCx9cT8z01R4s1FeaiXHA0Y
         Ft9BDAkKtrUiFf5PMuDbKzG6ZITspQbbjeb3DKr1Be13aoHP3bP7peExIwAYH9PWnatD
         2Wf6l4fizUNtyasNpf8RwAc4OJw3W/0PioXC9Oku9O7DQqcFLXdELWsnNqcVbsDLwdcV
         30KzS56uM4ykQ4QBBFzTkKS7OZZs5P7AkHwPtGbS6D7ErOnrpunzO2Pqedx0otXRrWe7
         eGZzu6fOso3jbgf8dYJmsZygc6rNUfLlkkOKpM9arBpDMzbfSL9b3BpNo38xt3tXjmvt
         ycaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzOjUbLq49OAbbM39Sx2SIcMBn20yBu1NF1zm9al1SSqfM8iy3PWww7TAV+UlZqM8gXGhq14T9uQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lOc7QgrYMvxEE8ArpzRp4JCP+bSjngb0HRzRs4Ndqw+puFLfI9
	B2h8d9WMmIOjwFS/HMRJILp4s6w1PEbpY5w3vBQF7UIqwQzoawo4/8ax/qD/ZA==
X-Gm-Gg: AYBFou0+DGyoLVNzB+5xp6N961s+Ga+0/z0wel5tdYC40jSEZLjHIRY1O6MIJPn92na
	JhipAbKUagZLGRSMqgmoubwuSTUZSNnXk70Di3+U7Qo2/XpiGE/SVu9Ntac7bcS9ol9nKx2qtxW
	spoIIBxFUNjQ55Rc8S+y5y1QcxD5VOFB/2iVBSdO6NKiiQXnlg4IVg2JdDV+xUrSJGk0LNbO3gz
	D/VcXr8KMotvA0HmiybSG9TQXwp9/Isy2e6mRAxY/Jh3dvZkj/5I9eLwzcRR0XuSZ73yj0s3jha
	gI/mdyCgorBrJ78dM76HVa1zuWkX3VSxCT6fUDRQf84xviArvaUt6pVci2qu2O355Mgafi/cfTD
	6VSaI0GHAlLcDsWESLUapJJCeDQnJM351MP4t3hwYLLTh0VkEPV0foS7I2LVcTjPHBOR/da/JzP
	w2o0UiTraoSQQlCT+6K/N2SyVF5DiRmGFYjef8A/A6QmBN36eZqKFPLZVhQnVFx2bkDQuYZnWCw
	keM8y4LuoBlUH1nwaIDR1cy4tzThN4qIYxTd5P1Hz+S2WsV5oT1Y0M2Ceuffq20cP+TeVIDmbWi
	WkkuXC+/GwfmiYOR4W83d2bR7KwReMe2exQKCH7UIyVQ42qAjq2wawSJnAkU/pJcp8whtXcHu1J
	/CrXujg==
X-Received: by 2002:a05:600c:4685:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-49ffd2d25bcmr81836465e9.27.1790554789143;
        Sun, 27 Sep 2026 17:19:49 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e6-5301-2072-0420-f831-ed4e.310.pool.telefonica.de. [2a02:3100:b2e6:5301:2072:420:f831:ed4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0029203absm79014865e9.6.2026.09.27.17.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 17:19:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <yoshinori.sato@nifty.com>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: mm: fix double mmap_lock release on SIGBUS and SIGSEGV faults
Date: Mon, 28 Sep 2026 02:19:37 +0200
Message-Id: <20260928001937.12793-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit fb027ada051a ("sh/mm: use helper fault_signal_pending()"),
mm_fault_error() releases mmap_lock itself for every fault result
without VM_FAULT_RETRY. Before that, the VM_FAULT_SIGBUS and
VM_FAULT_SIGSEGV branches relied on do_sigbus() and bad_area() to
release it, and both still do. So a fault that ends in SIGBUS or
SIGSEGV releases mmap_lock twice.

A process that survives the signal keeps an mm with a corrupted
mmap_lock. With CONFIG_DEBUG_RWSEMS and lockdep, stress-ng --msync
(which catches SIGBUS) reports within a minute:

  WARNING: bad unlock balance detected!
  stress-ng-msync/54 is trying to release lock (&mm->mmap_lock) at:
  mm_fault_error+0xd0/0x16c
  ...
  DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffff00, ...

and without them, find_vma() warns that mmap_lock is not held right
after it was taken. Seen on a custom QEMU model of the SH7785LCR, in
both 29-bit and 32-bit mode.

Drop the release from do_sigbus(), whose only caller is
mm_fault_error(), and use bad_area_nosemaphore() for VM_FAULT_SIGSEGV.
bad_area() has no users left and goes away.

Fixes: fb027ada051a ("sh/mm: use helper fault_signal_pending()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested in QEMU on a custom SH7785LCR model, not on hardware.
    Reproducer: Debian sh4 stress-ng 0.22.01 --msync

    Unpatched:
    - debug kernel: lockdep "bad unlock balance", DEBUG_RWSEMS count
      0xffffff00
    - 29-bit and 32-bit non-debug kernels: find_vma() mmap_lock warnings

    Patched (debug kernel):
    - stress-ng --msync passes, no lock reports
    - stress-ng run with 48 stressors: no kernel reports

    Testing on real hardware is welcome.

 arch/sh/mm/fault.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 06e6b49529245..138fc577a4c13 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -281,12 +281,6 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	__bad_area_nosemaphore(regs, error_code, address, si_code);
 }
 
-static noinline void
-bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
-{
-	__bad_area(regs, error_code, address, SEGV_MAPERR);
-}
-
 static noinline void
 bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 		      unsigned long address)
@@ -297,11 +291,6 @@ bad_area_access_error(struct pt_regs *regs, unsigned long error_code,
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
-
-	mmap_read_unlock(mm);
-
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs))
 		no_context(regs, error_code, address);
@@ -347,7 +336,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 		if (fault & VM_FAULT_SIGBUS)
 			do_sigbus(regs, error_code, address);
 		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area(regs, error_code, address);
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
-- 
2.53.0

