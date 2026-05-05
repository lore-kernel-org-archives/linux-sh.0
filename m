Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF83C0636
	for <linux-sh@vger.kernel.org>; Tue,  5 May 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971591; cv=none; b=i7XSdsafyUETeDDhBdfekaCBO5B4EM+tsbwWx4di0iwAwmcyk39AaMb9SfSY4O3NsJv58f53zh12d4heDjiYaEluKjCNhrnY8c4Jtk70KiqT7Sobo6MEd1uGyDLZFTX6/BLhDB7jr9g9Jsv/DzM2C3rtGGnrjiuPGrodFYskZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971591; c=relaxed/simple;
	bh=al2PppdR14zI02XnxO6jvQ5jQoeFINWkUt0RjWqigJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eD5hor+RXBBmViJsehIIbUDL15oaR5lYdYPR35aICdP4u2y5dp45SiDgvJvCvaR4CeyzIAdUq7W5Tvge3K24Uc0v/S9owSGh5tVkjanjr/7dJcmTDrF+UvYOA45shd46G9364PylOMr41MbHMsb/QLxZbbpGK3bHtzIzItdFJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zcrrq3lm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zcrrq3lm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777971577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eAYPKE7BaXT/QonJtcwzArkebhW+/8md5bn4G5SQnr4=;
	b=Zcrrq3lm5TT2G2/47u0pV9WRwDAZoxa59LRbSBFaKOltrfQXZx0OEP9ARsvxY8LU+KfITQ
	xhGJZAbA521vqPIXnbthXw8KO2oSCH6CK6wia9SNVxd77l1IpbpaawF4RsdkWgmUg6TYNi
	6E5PjyQImPZxYikKEPw5TDFFGdzd0zI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Tim Bird <tim.bird@sony.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH] sh: platform_early: use strscpy in sh_early_platform_driver_register
Date: Tue,  5 May 2026 10:58:15 +0200
Message-ID: <20260505085813.156242-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=thorsten.blum@linux.dev; h=from:subject; bh=al2PppdR14zI02XnxO6jvQ5jQoeFINWkUt0RjWqigJQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/N6ru+Jg9w0jl5c+jEobrNSSNqgU3h9SulTCvuNsYV eiS0ZvYUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABPZUcTwP+EJ06U3GZK9IQVf S5dsj/g6U9Pk38cvM5IC/PN1HWfd2M/IMOvo4+xv+aw+G4IYtK/YTNhtbrry14a/C685yhwLWju nkh8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the early parameter to the destination buffer
instead of using memcpy() followed by a manual NUL termination. This
also makes the explicit ->bufsize guard unnecessary, remove it.

Return early when the parameter is NULL to avoid unnecessarily calling
strlen() on the driver name.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/drivers/platform_early.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index ca73442a03a6..9600787ee181 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -3,6 +3,7 @@
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm.h>
+#include <linux/string.h>
 
 static __initdata LIST_HEAD(sh_early_platform_driver_list);
 static __initdata LIST_HEAD(sh_early_platform_device_list);
@@ -74,12 +75,15 @@ int __init sh_early_platform_driver_register(struct sh_early_platform_driver *ep
 		list_add_tail(&epdrv->list, &sh_early_platform_driver_list);
 	}
 
+	if (!buf)
+		return 0;
+
 	/* If the user has specified device then make sure the driver
 	 * gets prioritized. The driver of the last device specified on
 	 * command line will be put first on the list.
 	 */
 	n = strlen(epdrv->pdrv->driver.name);
-	if (buf && !strncmp(buf, epdrv->pdrv->driver.name, n)) {
+	if (!strncmp(buf, epdrv->pdrv->driver.name, n)) {
 		list_move(&epdrv->list, &sh_early_platform_driver_list);
 
 		/* Allow passing parameters after device name */
@@ -99,11 +103,7 @@ int __init sh_early_platform_driver_register(struct sh_early_platform_driver *ep
 		if (buf[n] == ',')
 			n++;
 
-		if (epdrv->bufsize) {
-			memcpy(epdrv->buffer, &buf[n],
-			       min_t(int, epdrv->bufsize, strlen(&buf[n]) + 1));
-			epdrv->buffer[epdrv->bufsize - 1] = '\0';
-		}
+		strscpy(epdrv->buffer, &buf[n], epdrv->bufsize);
 	}
 
 	return 0;
