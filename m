Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDFD2F83B5
	for <linux-sh@vger.kernel.org>; Fri, 24 Apr 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777032651; cv=none; b=fs/qwhW3bwjCaZ7dhPHm3hCycVMH/WAhvcHZZVgawgHFAW9bBNm9oJU1CCjpVVv65ds3XFGToLikEncF7saFZmvE6IRW0HYVCHDhg/U5VJewYgIXgKWGjFHY6q7LU7SK72fUpgDuioPY4MSUwwyTulrRcWDfJfjX8ICmjLs4oFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777032651; c=relaxed/simple;
	bh=DiR2tchzpOBdmiVVmngjlOQAdil/y1mUp7govVD1Coo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOwm96IGFtk2rHgQrP/F5KNHFrrJrPRwrmokNWtmavrQXEAT1dRwzSyY08bsr5rAUZo+NowczOgA58HJIaEw8WorYiP/8LID8pDxCxqrmg1nZfK9/REINocx1phqjQmFsje1IWQSWk3JWa94qOsJ1h8/71MN255cOcQ1vaNU1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZMmf/ha; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZMmf/ha"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777032645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIH7HpTRKnw3R/MixMxgYmi1vEGJhPiJs2BmonboIgU=;
	b=sZMmf/haK9qM7UdywNhi0bgplrd8TVlBV+uMlYaRdHg9AfYmRDmmIROlVSLCFJN0xHXlpj
	mYH/Kfv14tcMffZcVAGb4hyBJ1DlGjq6z5Q+nFWrWMdwfgbTzRREzhq5AWiAJ7ncdU06Ur
	PIFvId+ddjng/f61Cn5caMNBHYdCDEw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: [PATCH 2/2] sh: sq: use sysfs_emit_at() in mapping_show
Date: Fri, 24 Apr 2026 14:10:11 +0200
Message-ID: <20260424121007.311797-6-thorsten.blum@linux.dev>
In-Reply-To: <20260424121007.311797-4-thorsten.blum@linux.dev>
References: <20260424121007.311797-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=thorsten.blum@linux.dev; h=from:subject; bh=DiR2tchzpOBdmiVVmngjlOQAdil/y1mUp7govVD1Coo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmvYxdM1/pRNqFKdjPrhQo1wz9Os9QffJ4+adbalYJby 5t3aAqd6yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJ3LvHyPBsfdW1V4GzVOLF O2yKZqnOD9Wb96Hg70Vbp+R1rvcSvm9i+J+eNO/gkYAdnmq58tsYsqKsjfg4jaT4Z351XhbGJCE RxQEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit_at() in mapping_show().
sysfs_emit_at() is preferred for formatting sysfs output because it
provides safer bounds checking and avoids manual buffer size accounting.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/kernel/cpu/sh4/sq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..50e7df13fcc2 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/io.h>
@@ -289,14 +290,14 @@ static ssize_t sq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 static ssize_t mapping_show(char *buf)
 {
 	struct sq_mapping **list, *entry;
-	char *p = buf;
+	ssize_t len = 0;
 
 	for (list = &sq_mapping_list; (entry = *list); list = &entry->next)
-		p += sprintf(p, "%08lx-%08lx [%08lx]: %s\n",
-			     entry->sq_addr, entry->sq_addr + entry->size,
-			     entry->addr, entry->name);
+		len += sysfs_emit_at(buf, len, "%08lx-%08lx [%08lx]: %s\n",
+				entry->sq_addr, entry->sq_addr + entry->size,
+				entry->addr, entry->name);
 
-	return p - buf;
+	return len;
 }
 
 static ssize_t mapping_store(const char *buf, size_t count)
