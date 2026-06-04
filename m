Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788640B6DB
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571577; cv=none; b=UsKaW3uXjyboS2LUeKuIIsf6PpweBw1zKfIhIu4zIQ7EG4McNBDPaq9eaR9gPItNDBpAuNV4x7XrD9rOgY6knrfflxIWTgNijE/DtARnjSxrHbfj+mcDiV37GzzM4H3IYWPaKixR7VjC0fkPc2IWfueRX8Rlef8Ko4T4cDB6CMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571577; c=relaxed/simple;
	bh=ytdeCiJdNll6wjnMF7+8t1je0hArLGIcQuy8rAoL66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSen+4BPqn5okKzmWbtRdq7ZCZIc0YnEotN1z04vDlVkIDyliGXQVhHx2bPJ2sSLR8pjNEEp/tv/iPWV9va/n7jtlDl/jCvk+6iSQ6XzS3PBhVf5SmgeTwIU7JvD6aC4FXxdDwq/y6EceHqBxj17Yo2rXg6SGLVeD7XIwnvY1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mk2doaQo; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mk2doaQo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780571563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6YzdzQqy1dyCmwGKMsad+62QDYi8eL8H4CsEyEO05H8=;
	b=Mk2doaQowS7y76ySBf0cQG2deK8ECYpoNUjpW6+xA3VQ0iFz7POL1SAmGE9AbowB5UwEVF
	PYsl/MCydLh/OfMP9+ErrsfxL/cs9NzqsBOEyBYGtiXN9ffqYox6uUzHYPNuOMICfhQCCn
	3le06Dl42wRdSzafKf1HK+l0q1piqHM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: sq: use str_plural helper in sq_remap
Date: Thu,  4 Jun 2026 13:12:36 +0200
Message-ID: <20260604111237.1297783-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=thorsten.blum@linux.dev; h=from:subject; bh=ytdeCiJdNll6wjnMF7+8t1je0hArLGIcQuy8rAoL66Q=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmKsUtfizhM+VTxuZ1p9QHu46ZWaXE/b8yUTq7+9cR+Y 6/4vWNTOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi1c8ZGZ6taFp5dfmZXRrp J1tLWnTKAjJeJle1FVcv+vt1/0veqVEM/5QUjL8Izpjq9yz2JdvkAP1bJw/V+tUo+22cp1x1IDz 3ERcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code. Use the format specifier %-1s to preserve the
whitespace alignment.

Simplify the map->name ternary expression while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..0f9244be6dcc 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/io.h>
@@ -181,9 +182,8 @@ unsigned long sq_remap(unsigned long phys, unsigned int size,
 		goto out;
 
 	psz = (size + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
-	pr_info("sqremap: %15s  [%4d page%s]  va 0x%08lx   pa 0x%08lx\n",
-		likely(map->name) ? map->name : "???",
-		psz, psz == 1 ? " " : "s",
+	pr_info("sqremap: %15s  [%4d page%-1s]  va 0x%08lx   pa 0x%08lx\n",
+		map->name ?: "???", psz, str_plural(psz),
 		map->sq_addr, map->addr);
 
 	sq_mapping_list_add(map);
