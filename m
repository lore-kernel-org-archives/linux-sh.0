Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900789;
	b=vQaUrfItvSHXg7xRfq0OA2//tY96qsGWvmPgKBq06VLgw280M1rz7TOksO6oXLq2DFZl
	 EIh4g3TrXGBIvInaXDAnVvoNqqOUXV0wICDRxbGV+htFccWpYQIR5Nrs2MCzF6mxpbz5g
	 PXf/vj/dnWPm9FIhgLhVrRJugu0LpPk3aVhIzepdyJLav7OrKAAiApf9L2ThzWyZOEyth
	 jTTHbFjX3lXXx84sWokVV3X22+GPz+YurRFgxYC/koswSv9SnHzzt1ryd3+UXT9Whv/8E
	 qzx09Rby7etUIj1kcNTfM9ETmQBwK4LEwX/lDIy/CmROdS0cavrUBWdE/x+sl4FRUFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900789;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/56n4+j5+1UyvRvIFXIBssoxwv85e0FEOJsHJTToNfw=;
	b=XRupOTYGGmFI5KJ0e6/erG9cgdA8uZhVDOaY0cAG6escVtO2ZHdE/FRrSuKe+h7YC9kI
	 pmbhwcGZMvNkOLjUs2idGdCXu7TGuEk9CCJQzeYA+GY57ErXws6NescgIegCaqloOtIHS
	 OOqcWfytgyT2EQ4pfPbIYEA+pr3peyvr8DNVQofwlWmJafdMQq+TkJjSuGFr9F1WoZ2Bi
	 U10p1oPOpKH0HVW/ksmQUmHxVofXD9KyCdWOkJFrSfqVWzCO5X09YIgHKePT0DC/JW4gA
	 +ApCE98ssKHUUtpy9+bPi8/VbJrjsOR6I9fCzKw6FaSF4bTmMpkuUV/mz5idw/x4iqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kwElYU0V;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112C606A31C;
	Tue, 17 Nov 2026 07:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0112C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kwElYU0V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/5
	6n4+j5+1UyvRvIFXIBssoxwv85e0FEOJsHJTToNfw=; b=kwElYU0ViUCs2AYECg
	yr33YkDRtB8k8JrY0QAOdcPRm/ychYs6TcIPeosyFG3DHS1xhlNWdfhk/IExZCOf
	uofw6zU7WnDao/rWSldZWpVGQ9RC7gZP/XPW0JxNYdHkh41VPTbhDgc9ruZOt/qQ
	pQC4ZVpcSambAlN4Ggg96u80A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3v0TnAvxqvuozIQ--.53240S2;
	Tue, 17 Nov 2026 15:31:52 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] sh: dma: Fix missing IRQ cleanup on initialization failure
Date: Tue, 17 Nov 2026 15:31:50 +0800
Message-Id: <20261117073150.1199848-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3v0TnAvxqvuozIQ--.53240S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4DGFWxKFyxJw13ArWxtFb_yoWDAwb_Gr
	43X34xXr1vkayrGF1YkFyavry7Ca4YgF4fWF10g3ZIk343Xr13GrWkXrs5Jr18WFW7uF97
	GayUZrWIyr47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiNBM7UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7QmUA2r8AunssgAA3Q

When dmaor_reset() or register_dmac() fails after dmae_irq_init()
succeeds, sh_dmac_init() returns without calling dmae_irq_free().

Route both failure paths through a common cleanup label that calls
dmae_irq_free() before returning the original error code.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/sh/drivers/dma/dma-sh.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 306fba1564e5..fc4986679308 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -405,10 +405,18 @@ static int __init sh_dmac_init(void)
 	for (i = 0; i < NR_DMAOR; i++) {
 		rc = dmaor_reset(i);
 		if (unlikely(rc != 0))
-			return rc;
+			goto free_irq;
 	}
 
-	return register_dmac(info);
+	rc = register_dmac(info);
+	if (unlikely(rc != 0))
+		goto free_irq;
+
+	return 0;
+
+free_irq:
+	dmae_irq_free();
+	return rc;
 }
 
 static void __exit sh_dmac_exit(void)
-- 
2.25.1

