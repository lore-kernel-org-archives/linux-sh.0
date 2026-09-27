Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170704349B7
	for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 19:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536453; cv=none; b=bIVBbg+KUUW4I+etTqpX4B+/juyiUYxofxnXTrlS5KL/YD2u+CayF8yekEvNfHFG4m5lwjIwITsQo99Ydpp9p3Ht72YZUx8ycW92lkOY/JkMJ44P2OyIbddmvKFmvhmVlihVkcgkB85hEFViWSdUfv/J9qRmTzS+LhuzCrdSwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536453; c=relaxed/simple;
	bh=huH3z/otBMatTKw01bpo1hxPY4/B+otQqB638hIXXmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FCDlpRbMNPJswBk21vMyxrZjpN4qJh2cf9B2i8uKEsSOiZN9oO2FKBE07okHfl+0kVNK2R5cW9VGVpN/3BVjmKlvwnuFC7mwe29+WYx2PFbHL8eFZIG3FJxYK0yZi5HOs2RLJlSogwn/x0sXco5mNz71hR0uDiQ5U6iDrJSxdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkiSJKVe; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkiSJKVe"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso17012445e9.2
        for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790536450; x=1791141250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R7ZbDsxBKqvOhL656Ve4BDXMNH+w5ltqPH0IQmusM7k=;
        b=IkiSJKVeBeYalHfrN47S6XZ+T+o/eOKzTn0OaG6Id53uMwdCxUTy08hXFjQDuxI5DG
         BGEHURKx8EEJ2iHPoWfStwmpMwfDv493hio7ANur/y+9XNW/1cN4D6W8kWsTUsYb3kC9
         vOx7DxFqktGLRwT7nmnfgQL7Uw0Uae80k2FotkRXf9x7gFbFepwHAIALZI+VES7tbBO6
         zPRYYhwvpNgYvzYD7pdr1wJczMOaxRGybLtvRriDskE+BmPWQX8uDNlQoeI9G+2Dxya5
         UXMygERcc4YROEj0s6nrvB4585wLat0EjLhRPahzkHw4NxY/D3znhEzkOvRKKM241hxH
         K1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790536450; x=1791141250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R7ZbDsxBKqvOhL656Ve4BDXMNH+w5ltqPH0IQmusM7k=;
        b=DbwifrdvkS0mXnV4WUrFikA2JyHMiWENQMHhX99hLtm/ZUSbyrsWYXDvF77yFZYm5r
         geAyUljNKbL4qERi65twzBOwxUOjw6nDKyWdCxBQJgDwnhxQj7ImFQcp4hAcWa1+WOlh
         piapQG0slv5B/08Ufzas2v3K30FnVcKeQdKGX2edYvqCYOSeMeywBK6riPoVP4L1SnQl
         kGMoRPn25ikh5wcVR8hGe4vVANdVSB4keeQ0+NZIOkk2UoJQKq4rZdcCalWj1Fv2pXuk
         Ypi28z08245s5uPjA1i4xns2EpvlD1pPlAsF/vV4BgxWsNu1ZPZsblbnpO+inYCLuMPp
         ZhdA==
X-Forwarded-Encrypted: i=1; AKwUvBxMm47kdR+5c8BA2lutrf2Vuh9uEYmSU7eQ3Z8+TinnriziUe+0611ffeuWx/xVCNU+MMzvX0ygwA==@vger.kernel.org
X-Gm-Message-State: AFuF++mJH+9rmecNUYbY4PGxqGRSXyV9JUxp6icnbivYyhwtirFURGT1
	9TY5efJVIN1ZUBl+mCB2ryrhfo7cs7/xl+fvnLxKSl56gvKUN+mOEbgM
X-Gm-Gg: AYBFou1Ot+wj0Mvu3eomcR21UbNzUbYF7conms2XkMPv8/4wKmadfcerb6M/cfmdEFs
	W7a9OAJfhWc9N1kgHvOt3+KE2wDBkrS7W6RcjusnOpoJXzseRPwM1KRCZkCajmy/y5bQ3UKh0YJ
	hVaeK8f/B8krOp/t0k2oGZ8d2aOI3mv3gpHYulNea/LwCEE1g4WZ2OhoZxmGYpF59qRnBnoEakk
	ZuomaIh0ZXRVbNTxFoUn1Z6qV32/MkjywkAKYf+tfWUVqjZRRdkxZrl31CUodaJ3/O6w5DY4D2f
	66ZL7ls2xGXyqTczkYJvv83aQUgA1LLJioCqMTJbLQEP+Q/WWM8N1d+oMQ3MwRq4lnS7hdDfpEw
	m/K6LM6MwXIKe9SJCd6AquGK8eUSROBsv9uF88izsfgAOGY4s5aZJDm0nqcgiJQ2nbrnYTBq39I
	517XDD7wOuXPV4pZaNIOYkFcDfCoEXX9IhcN9zw6hMZxTJkO5A/7Ac5ps8Hq33hj0SiLDFplA0c
	oDs/CqiS9SqYwBvJZxuUDJ1mQjA+wm7klicJCswQtMA0UkNdTv5mJJNRmNtbHHlmA75vyS6UjwG
	SheXDARPc67eHIMgmCeNefJWHwpwRjFKov7dvOZ8/ksnBxd0nHfG9MbGbsCalBaevMdIaYykopc
	4RRdODg==
X-Received: by 2002:a05:600c:3150:b0:49f:fd2d:23d1 with SMTP id 5b1f17b1804b1-49ffd2d2627mr69934935e9.27.1790536450093;
        Sun, 27 Sep 2026 12:14:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e6-5301-2072-0420-f831-ed4e.310.pool.telefonica.de. [2a02:3100:b2e6:5301:2072:420:f831:ed4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001904513sm113458955e9.10.2026.09.27.12.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 12:14:09 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: intc: sort the prio and sense lists after filling them
Date: Sun, 27 Sep 2026 21:13:59 +0200
Message-Id: <20260927191359.6144-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_intc_controller() sorts d->prio and d->sense right after
allocating them, with hw->nr_prio_regs and hw->nr_sense_regs as the
element count. The lists hold hw->nr_vectors entries and are only
filled later, by intc_register_irq().

On SH7785, sh7785-irq0123 and sh7785-irq4567 have four vectors but the
SoC's eleven priority registers, so sort() swaps 88 bytes in a 32 byte
kmalloc object at boot. slub_debug=FZPU reports "Right Redzone
overwritten" in kmalloc-32, and v6.5 and v6.6 panic in
__kmem_cache_alloc_node() while registering sh7785-irq0123.

Found with a custom QEMU model of the SH7785LCR. On it, v6.4
sh7785lcr_defconfig boots with SLAB, the defconfig default before v6.5,
and hangs before the console is up when built with SLUB.

Sort the lists once all vectors are registered, with the number of
entries that were added.

Fixes: b59f9f9775e6 ("sh: intc: optimize intc IRQ lookup")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Testing, all in QEMU on a custom SH7785LCR model, not on hardware:
    - v6.5 and v6.6 sh7785lcr_defconfig hang before the console is up
      (gcc 8 and gcc 14). With slub_debug=FZPU they boot and validating
      kmalloc-32 reports "Right Redzone overwritten" after the object
      holding the entries of sh7785-irq4567. With this patch they boot
      and the report is gone.
    - v6.4 sh7785lcr_defconfig (SLAB) boots. The same v6.4 built with SLUB
      hangs, reports the overflow with slub_debug=FZPU, and boots with
      this patch.
    - Current mainline boots with or without the patch, but reports the
      overflow with slub_debug=FZPU unless patched.
    Testing on real hardware is welcome.

 drivers/sh/intc/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index aa68fe190865d..ffbe60234eefc 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -275,9 +275,6 @@ int __init register_intc_controller(struct intc_desc *desc)
 			k += save_reg(d, k, hw->prio_regs[i].set_reg, smp);
 			k += save_reg(d, k, hw->prio_regs[i].clr_reg, smp);
 		}
-
-		sort(d->prio, hw->nr_prio_regs, sizeof(*d->prio),
-		     intc_handle_int_cmp, NULL);
 	}
 
 	if (hw->sense_regs) {
@@ -287,9 +284,6 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 		for (i = 0; i < hw->nr_sense_regs; i++)
 			k += save_reg(d, k, hw->sense_regs[i].reg, 0);
-
-		sort(d->sense, hw->nr_sense_regs, sizeof(*d->sense),
-		     intc_handle_int_cmp, NULL);
 	}
 
 	if (hw->subgroups)
@@ -357,6 +351,11 @@ int __init register_intc_controller(struct intc_desc *desc)
 		}
 	}
 
+	sort(d->prio, d->nr_prio, sizeof(*d->prio),
+	     intc_handle_int_cmp, NULL);
+	sort(d->sense, d->nr_sense, sizeof(*d->sense),
+	     intc_handle_int_cmp, NULL);
+
 	intc_subgroup_init(desc, d);
 
 	/* enable bits matching force_enable after registering irqs */
-- 
2.53.0

