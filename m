Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5724293C
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124813; cv=none; b=ph4SH9HrPA6CTPu60te4f9ObqHPT2/zRNWVgp/oWdiCH1YzTrHAnEH1/uJw+a95ybBy8NzQXoYv7+SrugM0slL9aIpLf5MZERlkwp6fOW7FBh09hE7NLQFH4yEFdgqu3VWCRVDSCtm7uWja0Urd95Lz8YWN0QQJERyJWpkt/zjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124813; c=relaxed/simple;
	bh=joOFwQZdtduKZdlq6bev0GjTxohlZ1Vf9Dm+tbDszJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=esaNHOg/+C0B7f/GDF443wWNmYcS4g6foET1qzgmG38sbn8+VgbuBIuLTu5G5YERelyY3HWuPHPC0JvK1HGCu5oa+GrZusp5UcRzw2SAskUNAPETkgr5tTY1GM+4hgJquA2C+RaFiqICB9efVjajJCOxbZtVdPZx+sEaIVkE/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpY7YDcl; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpY7YDcl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779124810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2PARzt8Z+JF0o/40UZ5y9n9W0bAsMFPKTctZlcMXSGU=;
	b=vpY7YDcl7mIKYy7FolEpQUz+O7es4w1OdLQPVN52UG+NYDPFBmDtShlTJGEFSftDCuYTHN
	2c5Co4U9HmEG6pLLE8OQPPXnYwlcPxthT4/cS4ZCo7H34+0ZzFAqWaJmY3K5wE2B9qNeLy
	tXUiolrfmS5Yi7Pp8wM7rvxPHiB+QGo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Artur Rojek <contact@artur-rojek.eu>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] gdrom: use strscpy in probe_gdrom_{setupcd,setupdisk}
Date: Mon, 18 May 2026 19:19:42 +0200
Message-ID: <20260518171940.83077-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=thorsten.blum@linux.dev; h=from:subject; bh=joOFwQZdtduKZdlq6bev0GjTxohlZ1Vf9Dm+tbDszJY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFncXjrMq7c36rqc9F3Doay/ZzO384sSs5Dob+98nMMm/ vxxuWpnRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyEfwMjw+qeyof1My9L3kuS P3LwfnXMh6tupk0L6hWcDq/57V79QY+R4f4Skyfcm9YIyN0/altrfi6r5cnszT125r1h77ILEk7 78QIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows.

While the current code works correctly, replace strcpy() with the safer
strscpy() to follow secure coding best practices.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Acked-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
