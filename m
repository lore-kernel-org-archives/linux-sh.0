Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.238.66.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540973;
	b=AkceYDNQOzMDLJvim5bHNZ3ZL1DooNAwnvTpfYkvLyeYjYKnG5S9QvOkpOziYfTUktJh
	 FOgY5gbep1NgMqS5Y9vMnzih3AOftBhgQuMcxvg6EExk/6oatrPMC100NP0lU4d7B6aju
	 OnJIMLPcFxiXvyac+c81Ky2mHQLMkQbytsayQKZHvt+F/mXml/pOtWic+B8sD56h+AAkM
	 UrhSEgiRRu0vuabUiX6xLTfZH0+Fr0VnuLKXdRiZHjvJVEmSD0eEDj8zyvr8inzDPMS27
	 1PQSq2XktYtFusK/AJh/Ng0dQewStMv03ucdp6OecuuRQS4mB0zyDFGRpIYPuTYG/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540973;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Operating-System;
	bh=s7+GjgGOCvnFo1pAfypWWRRal0+3urvFfIlxGG5ZBSI=;
	b=nveOoQ8SiZmhGuxJbjny626cPFAQRgXoIuyitt9mwTMn70hebYUcRR2mNxpmWbUZstbt
	 d/UX0ReROFbWOQGkUp7ouROSmZjiXPfjT29X38BSRuzlqDQTZw4F5Nk6opMFzL00xWhM5
	 Dyyz9e7gP9lMcYOjYZWgxC/YVo2E7h1pqr7OMUPyeQD5PntGU8zb2b51pgg89kTCt3VNS
	 ufQkBKBcHTDwEWCznsbQiyWpAKnab59L7qgQpOZxc5F3MN7hbSJRukmCe/rkjHq+shjoz
	 4YUA4x0MWjwDgi5wdNwxWmSKOMLqY6ztpdzOOZgFiCJWSXwt/sDFkXMRFYofy5Z/4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=openadk.org;
	spf=pass smtp.mailfrom=openadk.org;
	arc=none smtp.remote-ip=89.238.66.15
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B34606A322
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 00:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B34606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1792540970; bh=McVY/TZp/XQ1If/Tow3VD52x4KHVD1ASKuHmG0W00gk=;
	h=Date:From:To:Cc:Subject:From;
	b=du95pYnk59gx488JbTpwvQzrVimAYrkusi2MuHWRFMoVCNQ2v12b7oL8pJqnqDf39
	 w5cgHc9LbhQK1K5fpcBDA6PbC+0vgsdpa+9My6FGiCOiLM1rStPSojn+sQydAGM72R
	 C+vduEgH85fNK9j/DywHqUajl6R2lP51hxI0Mk4yQMM99oi+/bxZmi+iY8y/0M1rpn
	 5WQeSWGeA+qGXWLqSZr/YcOGZni98O/DOpe3K5y4sTIa3yhooJBqsyqYUb1gTqu1sS
	 zWQJd0iwLfzPi60ytm1Sk6noOVsm4qcIwuM79nH0X/9tKalGxjHlDnXbgEEzoaAALB
	 Rsr2deYNLIDPQ==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id AE4F931E0B69; Wed, 21 Oct 2026 02:02:50 +0200 (CEST)
Date: Wed, 21 Oct 2026 02:02:50 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: linux-sh@vger.kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
Message-ID: <atgBKmRydeRteQ0T@waldemar-brodkorb.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 6.12.107+deb13-amd64 x86_64

binfmt_flat offsets the in-memory start of the data segment by
MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
binaries end up with a gap between text and data (commit 2217b9826246
("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).

SH position-independent code finds the GOT with a PC-relative mova of
_GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
lays out the image. With the gap, the GOT register points below the real GOT,
so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
In my case the data was moved up by 0x20 bytes.

Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
as well when building without an MMU.

Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 7.3 and
FLAT binaries built with elf2flt: with this change the data segment starts
exactly at the end of text and init runs.

Without the patch bootup fails with:
[   12.080472] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
[   12.123609] Fixing up unaligned userspace access in "init" pid=1 pc=0x(ptrval) ins=0x6583
[   12.175153] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
Assisted-by: LLM
Fixes: 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")

---
v1->v2:
  - add fixes tag (Geert)
  - tested with 7.3 + Florian's uaccess patch (Geert)
  - added failing bootup messages to commit message
---
 arch/sh/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d60f1d5a94c0..b501153551c0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -15,6 +15,7 @@ config SUPERH
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_NEED_CMPXCHG_1_EMU
+	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
 	select GENERIC_ATOMIC64
-- 
2.47.3

