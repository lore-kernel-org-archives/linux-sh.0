Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C032139C9
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032636; cv=none; b=OAtyQK84KLjUuin6Oa5qBX71SJYTyWqrN5c1mczz4eUYUgv79mJpGZEkzdzZkYE0ntCEgvWV2Hy9QE8PK8FH0cQsCXw5CA7vku9NCa801cOEi2zs6JMM0l4qxp70gR1SYSH/l8UN5JpY7JhhgTqoxKHO9m6w+CXfLRvXHRwY9YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032636; c=relaxed/simple;
	bh=CGMWvxMKJjMZjsZ1S/8jWASnChtIaPf+gSw8ViKF048=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcHC2Xbalup3qzRYD7gXkaf6mkeUaTBM2T5L3p03Kva24XWLmFt3aFvBF6VSa7RdSaIIDh19VAd9C7sYoKxZgGekXYy2hf6iGamApX3bP9xrs8epnOCh0Su0Y/b87U1S0tb+VLN3XqBa2kRpH99+yuuNlVP7WE7XOrFwFRw5bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hSrb9qQM; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hSrb9qQM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777032631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BxDZb17eB+Sq9Bvxvi/anxwI+VW0zbxTnYIBJjAOS7Q=;
	b=hSrb9qQMwDxHUOXu0UTFAbmVAc/ZNJHGZ0fZgInfkzaqfxTWaEX4WV1stpiHkdxQSSgZK1
	fglKnVBqd/ddNUYzg3AlnnP6usuiyQ4WNuzB8ph+1cu/nApx5wUOksLI7DBPVjRN0lt+O4
	E6pw5mwjj1UTwYXp+ehmfZ8Sehepvng=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 1/2] sh: push-switch: use sysfs_emit() in switch_show
Date: Fri, 24 Apr 2026 14:10:09 +0200
Message-ID: <20260424121007.311797-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=thorsten.blum@linux.dev; h=from:subject; bh=CGMWvxMKJjMZjsZ1S/8jWASnChtIaPf+gSw8ViKF048=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvY+e/3c5x7q+iRGbF20ubIq8rNd1SjpAoKvb7kNF26 n6+qOecjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjI49cMv1lmd726KROU7H/Z f+vM15N+NGwKb9nx/cCexm/OU+q2rv/L8Ffa55KYu8nsuTH+/LM5Hu/Ufi7zaRKvBp8iZ2PkvmR XTh4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in switch_show(). sysfs_emit() is
preferred for formatting sysfs output because it provides safer bounds
checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/push-switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index a39e2edd4dcb..9a60e2e088a8 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include <asm/push-switch.h>
 
 #define DRV_NAME "push-switch"
@@ -19,7 +20,7 @@ static ssize_t switch_show(struct device *dev,
 			   char *buf)
 {
 	struct push_switch_platform_info *psw_info = dev->platform_data;
-	return sprintf(buf, "%s\n", psw_info->name);
+	return sysfs_emit(buf, "%s\n", psw_info->name);
 }
 static DEVICE_ATTR_RO(switch);
 
