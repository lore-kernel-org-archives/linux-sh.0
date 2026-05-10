Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6635E922
	for <linux-sh@vger.kernel.org>; Sun, 10 May 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429493; cv=none; b=Z9m6UDNvWEvTASoyRBsGLmZ2wCX/l1gwEIci8V5WERRwksqeT8YcNVP46Zzxh0QWg62/SXXEle1ZVYNaBcckuHjvcBCp16J2Zm4Hh/4M7LsxlT8RQo1dDRZV+gJzrdjzqSgokLoHKVe5Qd+RB8nRZ5GrnA7ct/S3WyFHs1hOfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429493; c=relaxed/simple;
	bh=VpyAswRNrKpzlIHyzQ9ryez1EEih2VW31tPTZt5Y6Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO2QzHO1nlc/VDuoAgs6xVxTLe/DjZlx05cmbwDzLNzVXcA6rv4QrfktVFBiHJcZt7UMF1gmDObgcvBMfb3aod1IR7UtiFvDE9zlfEak91BvDWpnqsmnj1tp0r7GxPVFEABRgaQuhtRWuRxT9NFBd9ZGfKp79i1jbD5ajgaFkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cW3/pW3g; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cW3/pW3g"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778429479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B5O2D0CT4paGTJSdYTWUHa8jV0uQ6X+6YdoC97f8yJc=;
	b=cW3/pW3gYHc3bm4wbc/koM0NzKgdf+kqJbzJNlp+WZ5Q3LGkTmbyQEQl/2V2ZXHMznm6uj
	emJBupdXoIeuEaj9KA10YYIMCKKQSPTb9Kj7WFF+nloFb1A9b3Xf9GCDjhn2V2m862QWg9
	uqEwvMaJzMPwc6fNfHauOBanIZ0IqmY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] sh: dma: use strscpy in register_dmac
Date: Sun, 10 May 2026 18:10:14 +0200
Message-ID: <20260510161012.108731-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=thorsten.blum@linux.dev; h=from:subject; bh=EDeF8BLm2ABpziHqAng8eLQUqCfqSBG4zcHuaKEioOU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkMa5/4RanGms7Z/lTMne8hZ1rc4ikb3zNNZ+V//C8n9 fri0P1+HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR6WSG/7HXWKfemCLrzrnE av9b0c+XLLon38mY7li8vizR3PSQ2EmG/3FvE1atiT3onqxffeubc0ggW/br5aceTj/CX3VATqz xPBcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memcpy() and the hard-coded string length with strscpy() to
improve register_dmac().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/dma/dma-api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 87e5a8928873..31b614358270 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <asm/dma.h>
 
 DEFINE_SPINLOCK(dma_spin_lock);
@@ -232,7 +233,7 @@ int register_dmac(struct dma_info *info)
 		chan->chan  = info->first_channel_nr + i;
 		chan->vchan = info->first_channel_nr + i + total_channels;
 
-		memcpy(chan->dev_id, "Unused", 7);
+		strscpy(chan->dev_id, "Unused");
 
 		if (info->flags & DMAC_CHANNELS_TEI_CAPABLE)
 			chan->flags |= DMA_TEI_CAPABLE;
