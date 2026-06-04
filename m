Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701A369D7A
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572928; cv=none; b=bNIXlb6YraeuoWlFwYXEUAc1Ftlp+HMpUkFdMoR9cLKyrNiJ45ntka7fOFcg21ZOpvtESk97+EWK0W8kObkw8otC3HskqHwi08HWMozjZBAqLv7f35Sk4U2BCz2Hy6717Cbz4Cks1dZ59dth6Nktj9Eqa74fMtED66qovhSqpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572928; c=relaxed/simple;
	bh=SeKcfERkch3MIxL0SfREoepF4ECbJOM4hmqbK5H4qgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak2QyUgm+0Eh3x6804BfnZNfOYqXqXld2LiOp1YjUChsP6SuNRsr6sxGo6TayUSoe2EGRB01lANzVaZtDDf+tnzk4g6O6Zjv1Z7BUpMA03eBh6RTgjA60lm2HUQ+PK5eRBMLFCx+9WwoSaFdu73kOua5CIcFd6z9lc38WyZ3j6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R/AM5NMv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R/AM5NMv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780572915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NVdIn1312zIn2Dh+8ZMAVv6YrXULTt2aXiisxnqOai8=;
	b=R/AM5NMvAZjz+7Ug9jhyalLWGfH4ubBGkcSlOO4A/u9IcyWbv3S0G7IIZ3vvOf4e15h+H+
	5BvY6liWFQ6aiQA6SPzLn3AUFdrxcnoq1Uo9W/UQsdZmLkFIsNbv+KN/Wu1avDhnSh/9no
	0+dz82grFvXaAQdCNOwHCoaHmMpghlw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: dma: use str_plural helper in register_dmac
Date: Thu,  4 Jun 2026 13:34:42 +0200
Message-ID: <20260604113442.1303771-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=thorsten.blum@linux.dev; h=from:subject; bh=SeKcfERkch3MIxL0SfREoepF4ECbJOM4hmqbK5H4qgc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmKSZck08qm/r7KwaW02v3z/QvV+RX7qo+rJqcHLYzM8 GctuxTRUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABOJvcXwP/vRU++AKV+flVlc Ep4uqqUiemqayHqZ7Id3uKSl58RlWjP84S4qZlvmHKQj5GG/mf9TxYv/PZsfm2hNdN7vp9OdkKb GDAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code. This also corrects the "0 channels" case.

Use pr_info() while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/dma/dma-api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 31b614358270..7c8ee3a0bdf9 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <asm/dma.h>
 
 DEFINE_SPINLOCK(dma_spin_lock);
@@ -200,8 +201,8 @@ int register_dmac(struct dma_info *info)
 
 	INIT_LIST_HEAD(&info->list);
 
-	printk(KERN_INFO "DMA: Registering %s handler (%d channel%s).\n",
-	       info->name, info->nr_channels, info->nr_channels > 1 ? "s" : "");
+	pr_info("DMA: Registering %s handler (%d channel%s).\n",
+		info->name, info->nr_channels, str_plural(info->nr_channels));
 
 	BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);
 
