Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.238.66.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468853;
	b=xb4OOG9rRMDs7L58x0cD3Lm202GRDr6htGjN78Iu9Af1yHPjoyhWCxlKELRY72o7rK4S
	 tmRz7FP3jApgaJHvB2dfC/GK3qoxgThD2vYmtTOltbCta/6S1jhchgONMZ7+4SBerZPjU
	 lMXb3u4CKPxn6LB49SZa/wYCuXT5vIQzPkr1XemaJjwlXjJT4uUsfJBRzF06i9yFRd36r
	 MYWTLoyku5gbSMygl/k0WsNU+zJOv7hRXIhLLYY7OrbPNTmUafEGLozj2mZCfkoKKgIbl
	 9ZDs2HwM6xROoqv3QMI68S1Zy/UTHY0C0FbqRK8xRKiiAFNnxAOB+R6MQXUBWN1+VNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468853;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Operating-System;
	bh=SUG0S33P+8DbYao/7LzsjBfUCnUoIrSOZd6U9zj7lDs=;
	b=G4N31jixYN3XfIn2Ff+T7D6PwDJxOm24aZxdj6M5V57yh5kCMJFJkD+Q9Qn0kemyIlrw
	 2qX/D0byATbMwvZnCtBitqJHqy5exG0aiwQKsZnrAxWkFHNRHbaoLNl43+egWRv67bTCB
	 gAfsA6kf9GBa6DgxiU2PqloWi2WS2GqaCsKa97iIVHUYj1d3RjU43SJz8ImFRwhiu0/g4
	 NTaZ0kRnPaLIr0IrUhSg3IKQMopRl+0I1DULkoYZIDynsh7lAZue40wwcHB8W9Z+57owk
	 Fo7RQRDgDpNyTN2s/v9f9bukXveRnHOMbFMz1y6uGMUXtjKYkn2l1eCq2DEARi/fhUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=openadk.org;
	spf=pass smtp.mailfrom=openadk.org;
	arc=none smtp.remote-ip=89.238.66.15
Received: from helium.openadk.org (helium.openadk.org [89.238.66.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DD606A31A
	for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 04:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C12DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openadk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openadk.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openadk.org; s=2022;
	t=1792468844; bh=3ATkE3o4+BCXYozK4qqoPDKhxY6H6w4AjbE69NORBFM=;
	h=Date:From:To:Cc:Subject:From;
	b=DXfYQHxAxz3OGNAP7A4xmCVztsVBv+6MWrAJBueFTLAG8v9Hy0VscsalzIs8L3eyN
	 GixTiGf6Gwv4uCTZI1Y4N9jlbrLGhrs6lbo4fe/l86F1bSdPQY67EHf80ouF8EJklK
	 Pic90nuxX3yKXK5GqGvHcAlC3O0JxvnQ+euUTfx5GmpjMNoKmtN+oBEAaHQnN25FWP
	 /Q1Bb75EDbfxIA7qvv6Vo5wNdVrEfc8IjYYuOrDjDQE7in9HESqurvIIC0ozMBRjmZ
	 bx2p2jmChHLaiB0J7DzH93OsrJLWEtnI+cpITUD6abXvukz7SW3Dc+BfZFysvKyXLi
	 kQ2zPSLksHwHA==
Received: by helium.openadk.org (Postfix, from userid 1000)
	id 8DAFF31E0A52; Tue, 20 Oct 2026 06:00:44 +0200 (CEST)
Date: Tue, 20 Oct 2026 06:00:44 +0200
From: Waldemar Brodkorb <wbx@openadk.org>
To: linux-sh@vger.kernel.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
Message-ID: <atbnbO68dvPSW5bI@waldemar-brodkorb.de>
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

Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 6.18 and
FLAT binaries built with elf2flt: with this change the data segment starts
exactly at the end of text and init runs.

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
Assisted-by: LLM
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
