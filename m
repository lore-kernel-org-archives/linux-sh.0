Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3A1B4156
	for <linux-sh@vger.kernel.org>; Fri, 17 Apr 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434696; cv=none; b=Q06SvuyfHCFC/Uf/hkcS95envdAkxY8pqq0DvwR9QGpVjzTzyuiQgnE2tlcxm9vWYe1eI49KyLxqgYKF3oqrblQ6slq4DMc8ObfVdTfvG4Y+wAc7qWN9E0GOeUZlidY0T/kb2iLPvufUrsiesu3tIib3G6OzpQdF/uhE4jebsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434696; c=relaxed/simple;
	bh=IIQ6nEXJhz2Z1aKBTiSV2PJwfhNHrGNa987GO/xBBuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=frgANtT1EUE48Gu4tImW1E7FAGanP0ScEuUxj8wiiX9JxatdXnecxfNwq2w0ZCysaqpRnYvZTWjARZxOHXAezJGZ51zJ60B0dxr64oqeweIxg6L+UPwiu5wbnmKdMUmT0K00e0F09KYtWp1G2Uxk7JsL3Orl3ix4OM/G+d/qQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rVlsWchv; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rVlsWchv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776434683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GhlHA2ESSNJUFTnm+3/sML/ou4ajVzcsjUumgk/VcU=;
	b=rVlsWchvZeguS/ZqRXug18qPGsdyTK/5b1kqb5SZYt5F4b0I/8OSJSKvgDRkM7lD5MUM62
	X8zfvWumbiPKnv28YjOVJQelt9XSHmrW98+iD4zalD3MgjKmGrt+hUyCPRwyPAJibdgyI8
	YTT5pC7JH4BbUoHUJM4hA5R6wr1Vcu4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gdrom: use strscpy in probe_gdrom_{setupcd,setupdisk}
Date: Fri, 17 Apr 2026 16:03:49 +0200
Message-ID: <20260417140349.554098-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=thorsten.blum@linux.dev; h=from:subject; bh=IIQ6nEXJhz2Z1aKBTiSV2PJwfhNHrGNa987GO/xBBuQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmPbI/unBTkFXbxYRbPEZFsgY2KpxaatWY0OilLHw3Zd ypZ/wV/RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExk8S+GfwpX3pgyui8RCz83 4/F2I/kgf7WMyHW82RkT0gy637jMWcrw3/V22aTy6ZlSkzQfFPkILJbv+TTladV58ce661d9ZZr 1mgcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated¹ because it performs no bounds checking on
the destination buffer, which can lead to buffer overflows.

While the current code works correctly, replace strcpy() with the safer
strscpy() to follow secure coding best practices.

¹ https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Compile-tested only.  Adding arch/sh/ maintainers since that's the only
platform where this driver can be used.
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 drivers/cdrom/gdrom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..5768dc1aebc0 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/dma-mapping.h>
 #include <linux/cdrom.h>
 #include <linux/bio.h>
@@ -708,7 +709,7 @@ static void probe_gdrom_setupcd(void)
 {
 	gd.cd_info->ops = &gdrom_ops;
 	gd.cd_info->capacity = 1;
-	strcpy(gd.cd_info->name, GDROM_DEV_NAME);
+	strscpy(gd.cd_info->name, GDROM_DEV_NAME);
 	gd.cd_info->mask = CDC_CLOSE_TRAY|CDC_OPEN_TRAY|CDC_LOCK|
 		CDC_SELECT_DISC;
 }
@@ -719,7 +720,7 @@ static void probe_gdrom_setupdisk(void)
 	gd.disk->first_minor = 1;
 	gd.disk->minors = 1;
 	gd.disk->flags |= GENHD_FL_NO_PART;
-	strcpy(gd.disk->disk_name, GDROM_DEV_NAME);
+	strscpy(gd.disk->disk_name, GDROM_DEV_NAME);
 }
 
 static int probe_gdrom_setupqueue(void)
