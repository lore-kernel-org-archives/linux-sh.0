Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462303E6DDC
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943000; cv=none; b=ZPi5KzpQxdAbOxzf02mTTPfLGpfAL1wCLbusmGPpFebjN46eUckDJFeaYWh2/J2glEBp4Q1cyCB7M6SEyVEY+0X/iTmuyEEsGHlgxr8/oSug4Vv50bxq7UQCoxWT7ujC+qm/Tnc71uGiz0lIuG3A9qGXZchb7YHXmpxhhcBfdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943000; c=relaxed/simple;
	bh=Ueq0r940Oihd4nzENlh3Tk2zLlI7jb9H7hc7KtauWEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThRhJJXQ0giw8xNPcYlNRaYkk4Aid8HImLl+Iv/ilWC/W+RI6iVmrgo67IEJLZ+VqyB1u9cYB8ZHOkdMlk8Ls04dUUPrDQs+53HLIaU3nQXJPqZkiC5k+hG/QmZqGWXSIfAg0tY/hDTY0KV4b/vBjNSXYs25H78wu2DCVcwwD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NhSvKRNA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NhSvKRNA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776942996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G6UzKZ6zBHERTbJS2a2f0v4VBKW+GjIeqyvHJpNQyUw=;
	b=NhSvKRNA1via8dYztbd8YfuoUYUm0+LlsIhXpBIPxOPLaUyhwyuwUpUMKlnflXKqlkg7r+
	J3c1W5A1A1hDzcInq9/PkkbWDRqOyjbxZC9peR4rGyX1lJGoAYFOlSaGpbC4iOWsj17NlE
	a+HhRWrCCs+DAiZIaIo5mY9b+uFgI14=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: machvec: clean up and use strscpy() in early_parse_mv
Date: Thu, 23 Apr 2026 13:15:16 +0200
Message-ID: <20260423111516.211532-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2525; i=thorsten.blum@linux.dev; h=from:subject; bh=Ueq0r940Oihd4nzENlh3Tk2zLlI7jb9H7hc7KtauWEc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkv/7uUbP4qzqfsoWL0IPIiC7vthgVuNzm+OPYmHX+gU bHC8ZpQRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEyE04+R4WvCmooW3ugtz/ym Xnl46e/XKfWbxcv2Mqn4KMz2F9vzMoWRYWLQlm2/zi4yjOYs7Ddf57frRIVOJ7fgUp2fF7pu9TU c5AQA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the NUL-terminated early parameter 'from' to the
destination buffer instead of using memcpy() followed by a manual NUL
termination. If the early parameter contains a space, use min() to copy
only up to that delimiter, otherwise copy the entire string. Drop the
now unused 'mv_len' variable.

Remove the redundant 'mv_name' initialization because it is immediately
populated by strscpy(). Drop 'mv_comma', which has been unused since
commit 9655ad03af2d ("sh: Fixup machvec support."), and remove the dead
'from = mv_end' assignment. Since panic() is a '__noreturn' function,
remove the else branch as well.

Change 'machvec_selected' from unsigned int to bool and move
'__initdata' after the variable name to silence a checkpatch warning.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/kernel/machvec.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index 57efaf5b82ae..d737a5a560cd 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -8,6 +8,7 @@
  *  Copyright (C) 2002 - 2007 Paul Mundt
  */
 #include <linux/init.h>
+#include <linux/minmax.h>
 #include <linux/string.h>
 #include <asm/machvec.h>
 #include <asm/sections.h>
@@ -35,29 +36,21 @@ static struct sh_machine_vector * __init get_mv_byname(const char *name)
 	return NULL;
 }
 
-static unsigned int __initdata machvec_selected;
+static bool machvec_selected __initdata;
 
 static int __init early_parse_mv(char *from)
 {
-	char mv_name[MV_NAME_SIZE] = "";
+	char mv_name[MV_NAME_SIZE];
 	char *mv_end;
-	char *mv_comma;
-	int mv_len;
 	struct sh_machine_vector *mvp;
 
 	mv_end = strchr(from, ' ');
-	if (mv_end == NULL)
-		mv_end = from + strlen(from);
+	if (mv_end)
+		strscpy(mv_name, from, min(mv_end - from + 1, MV_NAME_SIZE));
+	else
+		strscpy(mv_name, from);
 
-	mv_comma = strchr(from, ',');
-	mv_len = mv_end - from;
-	if (mv_len > (MV_NAME_SIZE-1))
-		mv_len = MV_NAME_SIZE-1;
-	memcpy(mv_name, from, mv_len);
-	mv_name[mv_len] = '\0';
-	from = mv_end;
-
-	machvec_selected = 1;
+	machvec_selected = true;
 
 	/* Boot with the generic vector */
 	if (strcmp(mv_name, "generic") == 0)
@@ -71,8 +64,8 @@ static int __init early_parse_mv(char *from)
 		pr_cont("\n\n");
 		panic("Failed to select machvec '%s' -- halting.\n",
 		      mv_name);
-	} else
-		sh_mv = *mvp;
+	}
+	sh_mv = *mvp;
 
 	return 0;
 }
