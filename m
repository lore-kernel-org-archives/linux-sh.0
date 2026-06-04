Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B0478E47
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577152; cv=none; b=lWJ+qTCSxnA/tR9D3iwFo4TPO1v+cISZ+oaUcKEI0YcWylk5rbnI8zvoXkWB8WqOjGMZ4/yg4Du0Y3kDD0seeiQVWIgQPot7ogZQsZQiq5mO3KTrdlZXreXU/BOiKCJgdbT7hclihQDZFtCQlDd0utvD5CEgqjb9v8OTm6Tt3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577152; c=relaxed/simple;
	bh=DW+mOZlQxORZaRZJnIWsQwQOhxmfC3TF3MsIB0sEKXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cf63x2DVRXW6/Sykw7Kr1YDQh4ILJRS2UWE92f2gcz/HaQlMzSqY5E2kgrqYKoKw3AaZX3Re2Vg9elZcjNCJt4z3//b2UVNJgTN68W1DDLO4+TmAFVtUfWQEklmFA3oxlEq0BfcTR6QYmpva7NqmHL8FkMgFGTE8p/+d8RcuU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgXvH6ih; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgXvH6ih"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gJxNaijZfZLfkFrTUFqHTWXgf+SsPd36DLSVLNeUcjo=;
	b=vgXvH6ihenSG4ddzUulbFPF14axUcpcF6oFsrGeG+ZphpuLq5U5i0XShr5+7dm/Sj4fgwh
	/lJkccDnzAS9kZHFRAqz2HVaW6V2ACzkV0uc4zoKFKQNNHfNHBTT3H7QVs7j0TFOH7XZj0
	U1KZPCbuXqb/SX7aZK4SZpP5BLqq5aA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sh: dma: use str_plural helper in register_dmac
Date: Thu,  4 Jun 2026 14:44:53 +0200
Message-ID: <20260604124453.1306372-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=thorsten.blum@linux.dev; h=from:subject; bh=DW+mOZlQxORZaRZJnIWsQwQOhxmfC3TF3MsIB0sEKXw=; b=kA0DAAoWXqtxINjMdS4ByyZiAGohc0Wh3QJfxzHUxm0ntCy3bB2+N213ryvxPABx/nExxR4nw Ih1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmohc0UACgkQXqtxINjMdS4SpAEAxnrc RKOijUcdDCgyufVGoXb3e7M8Ve1TqEe4/ZCDYsMBAKqNwui+yKyqOklcoJX3hTCD/E0/4CZaIEx jsvmagRAK
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code. This also corrects the "0 channels" case.

Use pr_info() and %u for ->nr_channels while at it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Replace %d with %u for unsigned int ->nr_channels while at it (Geert)
- v1: https://lore.kernel.org/lkml/20260604113442.1303771-3-thorsten.blum@linux.dev/
---
 arch/sh/drivers/dma/dma-api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 31b614358270..7b18bd81ab61 100644
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
+	pr_info("DMA: Registering %s handler (%u channel%s).\n",
+		info->name, info->nr_channels, str_plural(info->nr_channels));
 
 	BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);
 
