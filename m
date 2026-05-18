Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BA352C4E
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124269; cv=none; b=a0oWCZiFJBcxa5QI+RlHFSLhZakeAdjuNt1jsrQJJlN3aLiNU7qxbUcTVlUMpOOYStzaf3zrpAskgezjeru4C3YYkYRQOh/TYgxeDDHxL9mNo0VeDxG/rLxPQ/OSzQu2mnyGi0J6I9gANKwIsaP4wZGVHL5hHrOqKQPLJPZbAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124269; c=relaxed/simple;
	bh=I96PgfcPXN7Ly/rkmJePY/JqnQuC5xNCFqcCv6AvDvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3l99tr9ZrtVdXN9SjSvnI796UdCpxGnARSy9NyhxSwhH02NQZF8CPFcSGvJorbd2DG8qtK3L0qFMFQFtA7l+LJnPGyqxK76a8R/CO/AiuUyzow8Rcjlx/OpmboPAGz5MhwLoLUZKZgk2O4rvYDerC9O8RKhXk2vqnAwgK/UthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WwIVs4vE; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WwIVs4vE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779124266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xS+JM+1x3eBvGek01LnGWaTp4Ros+kcGa4uWyIIGVLI=;
	b=WwIVs4vES7ihRPiiiAs4N0c+77nUsVbHzdcXHK25qQls/hMFzOVD6UV37InUFMoVo7MdKo
	zF12hv9528gqinuZ2J63xv2CvzPHTFlRVvUNdbpAd6yjItRnkO2zxeKJU2OyOm4IMeCzkL
	BOuXWwDe57aZn9e0kykNALqoqJD1eYU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] sh: dma-sysfs: use sysfs_emit{_at} in show functions
Date: Mon, 18 May 2026 19:10:41 +0200
Message-ID: <20260518171040.81917-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=thorsten.blum@linux.dev; h=from:subject; bh=I96PgfcPXN7Ly/rkmJePY/JqnQuC5xNCFqcCv6AvDvM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFncHgIx7yrKhF5mNW0QkjHYVTv5RMrdfQ9UplyO/Nap+ euQiUJaRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzk4Q1Ghh38eht3yDtPWVze F8zY46qWd/ZH8eKd73/GK8bMlTsSE8nwP91zW8ffhM6pC34dEF36aFHw3M0yh7t32jX43QioX9r gyg0A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
functions. sysfs_emit() and sysfs_emit_at() are preferred for formatting
sysfs output because they provide safer bounds checking.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
 
