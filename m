Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712147;
	b=pMeObCr2C1Ge4HjKIK/h6boHLK0Ql2s/QqKLW1lXG+2UfiyXjqIMvsiArwkH/MIfCrvb
	 OSZcIPmId8o5CkJaglFYFBuxuydXeedx1m2MdE+AJyNKeKvCzlDyVY67JW/4jgRdxOE7L
	 SHY6FdL1X9aoTAL7P9tfSHQ+Xzp6B0K2oNifv1oZmM0MsxWSqauuC07LP0kFJB61TsWZ1
	 MxpINwApjxdU0wj6eBUH6GYwQDeGffBm3RJdyq8LBrBila/MG2sypkup78OBE3zBivULS
	 BA70qOyZkU62Aicsi1GR1mMyRkXIdOcKJnn8Slwudlt5h0nNT/JDaFzTWyEkEy7LjMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=u5djCRBw1nlIHkmvbVmZqRQdrWKvlK7zRXIY63dkgPo=;
	b=ylH8CZES4ocrF871R0IiiuuAUrVzPXK6/6ZRBcj4JeL5mImEaJJ20ilcLc8GQ2apgq15
	 eG84CL2LbooULwO8rc7BO5/YtMXt1rX2QxNjCvBGuLiCM7+Bb0Qsp1ue8Ztd0tFM7QqYn
	 99gxY3DpXiJyTLrRUYXLzTkXDaSluqig+4HtE+X8Pm9mo2WPKAHLNpHlUyTLM7c22zfe/
	 UHHo8J5SK/ccgEEkntiFO3a6PBc4Du7MJjOcCxZp8JIFkQRECBemnrjGMv7QqGtzoYr+U
	 M6+bBVk32pJQyOs4tn0gllMbxJWmCbO5tB2UdpO75w5nz7Up1pAeCrzPzKgEXWftnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DhjJT2MW;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DB606A75A
	for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 23:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023DB606A75A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DhjJT2MW
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df8fe8513so257145f8f.0
        for <linux-sh@vger.kernel.org>; Thu, 22 Oct 2026 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792712145; x=1793316945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5djCRBw1nlIHkmvbVmZqRQdrWKvlK7zRXIY63dkgPo=;
        b=DhjJT2MWXRVWDCuSo23yF3aAPhjqisXmc2rFlQuveTilm7FZ+xcfIQPBAZnu5SS0Ld
         MSJGn1tYiC/03ZlZA6imeo3pTbJkbKU+91u/eF0z0c2cFSQzA9hCWtCkG+cy+Zg0Ck8H
         1sSRsAPRaQJozs2MpuR3RY794B7o1nEaA2Vly/2IJrMnqslVgPqv8YfHyPlbqCTR3hym
         +/KNRBsO9tBQDoeS8oAomxnhhN9tIeBDOIn0kMWqA/sh3EpsWdOQ83/efJQxaDjpe2NB
         z9XSIKP9pN5EGYAn1qLHwG138p4enTiYneYjeutMsQujOSAkqX4Sre8FtmvS5b0sJj9+
         GQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712145; x=1793316945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5djCRBw1nlIHkmvbVmZqRQdrWKvlK7zRXIY63dkgPo=;
        b=dFnkfuWzyvL/6F+O7q+r3NhImkHqyeINb2EZU4l2xB0pIsGVuWfRN789wVTeFUq7Kg
         7AkOVDd9xVLyIxpJXzJ3cspTymJcfn/Vr9DyCuUSw8ta6B68cfdfva48dAo9CKfVrs50
         ApTJ1aLiHKKu05ZWQR/QW3m2myprXQ2R+sOpQPRWngD7Me81aukxFnzWP13yj/r38LlI
         zCj3qlOPJBy11CChIp5WgN12c9CxPanSbbs7hnshnT4IBksm+HuNdBBhEbtzzRQ6ARF/
         qiokhhgA5MBdhfMiRZHXk3u3EEyqn66BgoLoXM996X9OuZmQrUiIUJHXHmpVsuZwwK7D
         aiSA==
X-Gm-Message-State: AFq9FYLCLn/thTishwXoD50sXYz1my9s7qI7WMjWoKDRHi5y6YHx0JDu
	dIgImdmcFRIM8mhKwOJBRsdAgZ/FOhMpuF4rvQLOEX7HxfnuPtWLwlR8hXwdwwY=
X-Gm-Gg: AYBFou3166/WmZWuAGUi3BXZJsE9+A6UMSOPBYVINJNIuN1++i6qEQx4zocF5k7FxQO
	A9bouBllAww9s2xyKmLr3mZsIofDsMWv3+xs/X3QwOlBfG7gjFXvGHIkUhybwUsDw1F6WH4FfkX
	ErmbUB1f8uO03M8leLwLtWxrgf6mjH074MVg8+jtlagxF19SKxbjIHDiunjaqUP2jnvkajXPX3q
	5Cxn9yu44xGxpZT5jF1CWalmJtYTZ9h5etMW0yG+E1m9vkNOveqlCYoRsq4bn0yFss4BeWKBSjp
	1e5nk/Ll5LyPNxbeVT6LL1lwJCuLWKt3RZnHAN2skixe+nAj0LRYqCtS5XQmMUMfj1yeX1KZGL5
	BIDeTm83IButXcEkJoPvdiCMl0enwvrkgWcHYhQdtydOGkeO4zWDJHs+XH8XANogrlCukb10qEV
	ZCZt+TUpJDXMiY/1scCOcxcj/QVfcHgBZT6bTweQp5hLnY5hiWg3EUgc9EMYhLfhFyd/Gfge9Q2
	T1nA35I2jq/mxVw5og2cDkwPzVtcNlgYJ4AJ+gAuDfiOw9EzMNih/TuuAn7CAIiPHJzCx+MfoNv
	Pucofxj6SS6hly/2gdG55PdKKGqMiC6TaTFn
X-Received: by 2002:a05:6000:22c3:b0:48e:bf0:35c with SMTP id ffacd0b85a97d-48e3859f5b2mr538813f8f.13.1792712145207;
        Thu, 22 Oct 2026 16:35:45 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:7204:b73f:b5ab:d041])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e38061f41sm1073123f8f.53.2026.10.22.16.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 16:35:44 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: traps: Fix kernel unaligned access fixup in branch delay slots
Date: Fri, 23 Oct 2026 01:34:10 +0200
Message-ID: <20261022233410.2959823-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 75d4d29549e5 ("sh: remove CONFIG_SET_FS support") converted the
callers' set_fs(KERNEL_DS) sections, but missed copy_from_user() in
handle_delayslot() which relied on the caller's address limit. This also
broke delay slot instruction fetching through handle_trapped_io().

Since the removal of set_fs(), access_ok() rejects kernel addresses, so
the fetch always fails for kernel code and the kernel dies with:

  delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]

The initial instruction fetch in do_address_error() already uses
copy_from_kernel_nofault() for kernel mode. So choose the matching
instruction-fetch accessor from user_mode(regs) and fetch the
instruction.

Fixes: 75d4d29549e5 ("sh: remove CONFIG_SET_FS support")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
The issue was hit while using PPP with VJ header compression, where gcc
placed an unaligned checksum store in slhc_compress() into the delay
slot, which panicked the system e.g. using ssh over this line.

 arch/sh/kernel/traps_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 1271b839a107..a7f20fead5f4 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -287,8 +287,10 @@ static inline int handle_delayslot(struct pt_regs *regs,
 	insn_size_t instruction;
 	void __user *addr = (void __user *)(regs->pc +
 		instruction_size(old_instruction));
+	struct mem_access *insn_ma = user_mode(regs) ?
+		&user_mem_access : &kernel_mem_access;
 
-	if (copy_from_user(&instruction, addr, sizeof(instruction))) {
+	if (insn_ma->from(&instruction, addr, sizeof(instruction))) {
 		/* the instruction-fetch faulted */
 		if (user_mode(regs))
 			return -EFAULT;

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

