Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16E2989BC
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123233; cv=none; b=YCnMruwJcH0tNQiL2Ex26XkaujG/9+Dt5n9PqSCtLPoNbjALLLyk5/JmIP5Ske40yhonWSN0giPaG5+IhbnapgmXnh6WyabLHurHvdKLMihdETS2iQnx2CT8P0+o1zLip9m8mvuUuo4DecOv2OYQ6c/MyOr1O40HWIJCtcPojno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123233; c=relaxed/simple;
	bh=WnJ4gWii6vGIYcblvWHBrztcZBFygJX95R92ZbX9gzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGhJmP1RyuQfwy6kRHXzy/XnSOlwdzCDpaRqyGUx83FPnzQdA/JID+JKQuEt6J/VR1HYplMP4Tj4PiZOwb8xAVfOhsR/pAIc0KCLN/V995Ma5kdxcm/1rPSIiStVIkV1g/Yi79RfxWqKKP1IH14rwxJlawttwjhq+wlnESlt4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rmdk40dc; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rmdk40dc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779123218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dTW70Khpmv4Wv56aPG+Rcr4F5EYvZo6qHkg+0Adldi0=;
	b=Rmdk40dc5ZaNPRkaQongReyUZboX6Q7x5ZV+6QkCCv+2zKgBu7gaw3/yaK2b6pbtPXlhHX
	SHQSr0g2fsR5QRlML3addZ9FiRVL5cfGtyslAvtdW6KepIbI7nx9yqnBibef/PiqOjHrQe
	N1Zq8Firy88d8ikzCmFEhveJ4ui7ST0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sh: machvec: clean up and use strscpy in early_parse_mv
Date: Mon, 18 May 2026 18:53:25 +0200
Message-ID: <20260518165326.81412-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=thorsten.blum@linux.dev; h=from:subject; bh=WnJ4gWii6vGIYcblvWHBrztcZBFygJX95R92ZbX9gzU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFncLmxRT2V6xaeGmH9ZdovV+E7/sY2bQ4sYbz3Qnv1/q v1vaQWnjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiIcwXDP81vH4xcHv47ocYf e+rWJTUG13kvdziYmP4wCWVsvWv2rZyRoV/y1sqp2y2n9Bz0+rzXrY5hG7e+H9+S93L5Ll4NEk/ j+QA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() to copy the NUL-terminated early parameter to the
destination buffer instead of using memcpy() followed by a manual NUL
termination. If the early parameter contains a space, use min() to copy
only up to that delimiter, otherwise copy the entire string. Drop the
now unused mv_len variable.

Remove the redundant mv_name initialization because it is immediately
populated by strscpy(). Drop mv_comma, which has been unused since
commit 9655ad03af2d ("sh: Fixup machvec support."), and remove the dead
from = mv_end assignment. And since panic() is a __noreturn function,
remove the else branch as well.

Change machvec_selected from unsigned int to bool and move __initdata
after the variable name to silence a checkpatch warning.

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
