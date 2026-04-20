Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B028504D
	for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697936; cv=none; b=e9cOEfF2cPcLN5JRMpcOsnrzdRcscAM2dbgb0LCZ9xcGkpD+tgQGf6hrTWxxB/NLr6JGgFuJplVWyIuhID8aPPDaCy+TMmTnPJ7MGZvIEMa3uI4TEG9UC9YjSP4vCeD8Tkhi1Z4u09Vbs/Jj5112kjouRTUUQCXDPuu5miYxx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697936; c=relaxed/simple;
	bh=xYkGMkzXFkFFWgFMr+VMbrIJYJ5B2FEPF095U//kcTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geOrIyxOMl0ot54aWAnrDouitmNX/2tzN8qSXBF6cfTztIBf2Qi6kjYNrRrTd10aNv/C9QF76VZ7aV6suNQt74D/6FkVOgnYvH4mM9LRULITwCxg78udKz3Pj4imZfdFdBikAScopFLt5kg76FYlnTjk2gsZp058XeXEBsA7s4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CS+GW13B; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CS+GW13B"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776697931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e995PwQ9QhBixE6weRT6IyUI3UW9SKU5WUzl8n/Xp8U=;
	b=CS+GW13BkcsJBe3sFs/PyMGNPQ67/2Htt6ajq7GO382bYylaY8ejJ5S1cR6r+tMm7ORQXM
	HR+vSYNkhui+GDG6W1+qMrSR7d+CTs/mQp0wnqcWrL3fyCBGdFCGPKtTmKjiWtQ/Yv0J4N
	Dd9RIAwUaIuVqD4oRpEmObxdYJybwZo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sh: dma-sysfs: use sysfs_emit{_at} in show functions
Date: Mon, 20 Apr 2026 17:09:58 +0200
Message-ID: <20260420150958.17072-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=thorsten.blum@linux.dev; h=from:subject; bh=xYkGMkzXFkFFWgFMr+VMbrIJYJ5B2FEPF095U//kcTk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnPHI8JZ5xOC5jrPfHQBwVx7jtHnz3vjQxtij813ft6v DjzxZ3MHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRJdIM/1T6Dx8XtftySKit 3Kd3ynLdnBZVz1vs868uiQ4/dN1QJ4Thv9PyP4eSHmadD/5z4H5N//7Ur/8Pa0yfsfeN1AOWW0J n37ECAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
functions. sysfs_emit() and sysfs_emit_at() are preferred for formatting
sysfs output because they provide safer bounds checking.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/dma/dma-sysfs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 9f666280d80c..d4e16cfc7a12 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/err.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <asm/dma.h>
 
 static const struct bus_type dma_subsys = {
@@ -33,9 +34,9 @@ static ssize_t dma_show_devices(struct device *dev,
 		if (unlikely(!info) || !channel)
 			continue;
 
-		len += sprintf(buf + len, "%2d: %14s    %s\n",
-			       channel->chan, info->name,
-			       channel->dev_id);
+		len += sysfs_emit_at(buf, len, "%2d: %14s    %s\n",
+				     channel->chan, info->name,
+				     channel->dev_id);
 	}
 
 	return len;
@@ -65,7 +66,7 @@ static ssize_t dma_show_dev_id(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
-	return sprintf(buf, "%s\n", channel->dev_id);
+	return sysfs_emit(buf, "%s\n", channel->dev_id);
 }
 
 static ssize_t dma_store_dev_id(struct device *dev,
@@ -98,7 +99,7 @@ static ssize_t dma_show_mode(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct dma_channel *channel = to_dma_channel(dev);
-	return sprintf(buf, "0x%08x\n", channel->mode);
+	return sysfs_emit(buf, "0x%08x\n", channel->mode);
 }
 
 static ssize_t dma_store_mode(struct device *dev,
@@ -117,7 +118,7 @@ static ssize_t dma_show_##field(struct device *dev,		\
 				struct device_attribute *attr, char *buf)\
 {									\
 	struct dma_channel *channel = to_dma_channel(dev);		\
-	return sprintf(buf, fmt, channel->field);			\
+	return sysfs_emit(buf, fmt, channel->field);			\
 }									\
 static DEVICE_ATTR(field, S_IRUGO, dma_show_##field, NULL);
 
