Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8536C5B3
	for <linux-sh@vger.kernel.org>; Sat, 21 Mar 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090768; cv=none; b=T3r57SrOJfOFbZ0KTGQtJFNJ0GBE3YbhDGLMzq0147ifFr1PPzYItj/xvkKin7y/pEH4bsFsChZZgXx32PEr8f9ME1r0VbsJFaixhdCPjA9IrJRAHYwjvKI5kpTODa3LH8a8pXAykQuV1lBhtyKpeu9til1DpbHVO3eEHua4im8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090768; c=relaxed/simple;
	bh=Caf6TQDvga2gI14s4bnJtzSZvEQ3Ue62kQfVOs6T/Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBStLei++ryVxzkRXBXhiM1fkaRoFhZG9WmtQJKmFPA6S6Gy3uqKDIoNOFs8QyTUJUV+ecULojG6QoOiPoiM3lQkpTg9RAUsjQheML0fcWeOBKwvMPF1brJd1fgLlgsDiKq1r7M3hkHPvUt/HnaGssRtvCj4h1seQKqblA8ePWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=zhq5Tzme; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="zhq5Tzme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090762;
	bh=OOX7PrBi+MPnA/I/2kiIoL+PzEZ997dSYiKk42mOm9Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=zhq5TzmefVIT+S7d7fFFm4wCy30/QIsDDQTGkhDymXr7oOoR5SXvZ4N+dALxn+t1T
	 00Bzsi0u1eDV4HrdVRBrYzU6cQicub64Ifui+kyE9VYB3Qcf0jTJzkcVAd6C6UZOm+
	 RO40hJwjXlA+ookweuRhjZxC71yLdClcNCOcLCB4=
X-QQ-mid: esmtpsz20t1774090760t50d08972
X-QQ-Originating-IP: lhjHYwalPvcWDH1aePlL6hCiCB08mOFwj1IFl3ymZyM=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:59:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7265402500091038811
EX-QQ-RecipientCnt: 12
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] sh: update outdated reference to init_bootmem()
Date: Sat, 21 Mar 2026 18:59:17 +0800
Message-Id: <20260321105917.7890-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NWbLsQpranWgJeQg4wBc2K7qEJINiAO3nYTxxcuBhoimolYS9jG5yjpG
	GlQFPPmDsjK0dAdPHSvs4UQpe8sUkXnHYnHwOiph8wIqcvAk1V87TDh5nxi4E1Ht9H176RD
	P4LHJeMSuv1TpiWTV54kZr1+u0vfQzCvR9biBy8gA0UPQnbwsjVZgziunUg0m1VvQAGq4qU
	jR2E3MqYehXcZ1ypUHQ12j+fmHCrQAvXl1THYBtRy8gLzeebd/Qyf15WpHb4qnvuTdD7Peb
	sF+phFKyl+VW6hs0s3hD+EFuEUg6vcVhhjFtHdibGB0jHFKWA23mkdzcYSP22KJxLQiWyAe
	/wuTIgrWdggZEKSClnmWxmxOUTNlg3f0wMFbebsWd1MNkiDNERrEL6Lw7q7lHjU4+gDRsxA
	8PCrhlODlgZETQjcBpgOjLtS41Hy16JIf+MGcQ6U8aZgW9vkpz3ZzQd6fb36DAT0qrxgjdg
	jEICrwnPSlC0bIbuksZE27agL4BcNyLVqYSUZNxVYahh3m76tRgXSYWOdDd0KWtNIjkfQ9S
	6Y4fXEWNgd7Kd6idu7Z3UDPD3Zj2v/4Q2YhIyLVLvNMtU+PhXaWlbVzIVZ1k9zvw9LcqxOv
	X1tmoD332PL+M4Og8n/GiMXrKtCeDy0jNIa9BGfjU+gOOyv+vgyKWhPgg1MgQqD9yd5/6HJ
	400spXGP5htEhpDp/hSyoxJS3eeLjSggfG1erxWBtJJhZZcs0HLqycjTcGGKwIDjOO5bhHD
	NH7hRwNizn1ZWTMaBrYUEeik13GbUvDGSUS/WoWUpOLRk2mq4xXcePlD40goxEQmU44Srt8
	ynIH1YIeUU4IKDaxWkPJ1T8kz4Avl3SI3xWyomho3vDWgmA6LP02FFk8/BRuO9mmEkX/wsz
	PZwH9hjyxBJFoCnBatCpupSAOBbQ02AtNiFM7ar+H0AjF8ZwTHSxpy24Igs1x7ScmQEGyQ8
	KS37gIOnSjn+mcs82myqqU+RsF0W3rDVUkFUTzYWXvq469nORbgE09K5hS7h+UhEEX+Fhzx
	MhbpG1v57aGcoooi9rGxK51YrA0RDkDwSexBP5T58daBKliMimbB5NQrsenm7dlIH+noU6k
	LCibNCizsrbYUH9iuKfadc=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

The bootmem allocator was replaced by memblock in commit
355c45affca7 ("mm: remove bootmem allocator implementation.")
and init_bootmem() no longer exists.  The comment in
early_reserve_mem() still describes a two-step bootmem
validation that no longer applies: the reservation is now a
single memblock_reserve() call.  Rewrite the comment to
describe what the reservation actually covers.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 arch/sh/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 464a3a63e2fa..c008db3d422e 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -242,10 +242,10 @@ static void __init early_reserve_mem(void)
 	start_pfn = PFN_UP(__pa(_end));
 
 	/*
-	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
-	 * this in two steps (first step was init_bootmem()), because
-	 * this catches the (definitely buggy) case of us accidentally
-	 * initializing the bootmem allocator with an invalid RAM area.
+	 * Use memblock_reserve() to protect the kernel image (text
+	 * through bss).  The start address accounts for the zero-page
+	 * offset configured by the platform; the size is rounded up
+	 * past _end.
 	 */
 	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - start);
 
-- 
2.25.1

