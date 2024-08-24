Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F970156C4D
	for <linux-sh@vger.kernel.org>; Sat, 24 Aug 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724501175; cv=none; b=dw+X0MhBsyDmJNlb2KVvdyqKYqvVqhFrpnVGnf+ryK4ymA029CsWSQnGZFB+hvyiKPiF9TkE4rmML1XEdPKam2PbBetzcrRehJ0AFQkMDb5l3SikXRWXknYS26ISPXKOIvcxRhidrrarjJArAA2C2L3bUyzynBIPbuODvpM58xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724501175; c=relaxed/simple;
	bh=YC7CeQAyISiVbATvguBOIhbny6+oFPQvG21dXssRx8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tXTUswXZ37nahPrfTX7rQktCE2XVCqp7IMTqqmdPnjnqEueCDnp6lrGstina9Vp202kpJm258mYU57yUHwVL8wPMOXotekoM04aRdx0389PVfJzvmbpbxKqtGNqIGZ5tpFsZMNetqn17+MuSoaxuTPBt8wU7x1uGA6abX9Bgwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrbHw096gz1j798;
	Sat, 24 Aug 2024 20:06:04 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 128A714022D;
	Sat, 24 Aug 2024 20:06:10 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:06:09 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <cuigaosheng1@huawei.com>
CC: <linux-sh@vger.kernel.org>
Subject: [PATCH -next] sh: Remove obsoleted declarations for make_maskreg_irq and irq_mask_register
Date: Sat, 24 Aug 2024 20:06:09 +0800
Message-ID: <20240824120609.2519181-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The make_maskreg_irq() and irq_mask_register have been removed since
commit 5a4053b23262 ("sh: Kill off dead boards."), and now they are
useless, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/sh/include/asm/irq.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 0f384b1f45ca..53fc18a3d4c2 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -13,12 +13,6 @@
  */
 #define NO_IRQ_IGNORE		((unsigned int)-1)
 
-/*
- * Simple Mask Register Support
- */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
-
 /*
  * PINT IRQs
  */
-- 
2.25.1

