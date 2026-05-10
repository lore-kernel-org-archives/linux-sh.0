Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFE393DD3;
	Sun, 10 May 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421362; cv=none; b=PciXrFd6DEx4rF00+vbDwbvSOxZqUr0Rk3WU8xWAf1Abwm9tcwRYpTjLZamSgHyWNle2RlOe1ImOjKYcQ59jkADcmXUC8T/9Tkm1bDC+89lATdAB90JA+7dGf6duEHmsu5V1YDiQpKX8Jdf9YJQBqKGGsc7+34yginVuTrftxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421362; c=relaxed/simple;
	bh=WNlS5KGrIJ+SWL3ygZxbK8TC+u2LpU5BV2wDLG+l528=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTjVsSM00cWVEFeZIINP81+ZRwq0rQEaIP1GLByjUyHY2RI1tepHVliQRYjUX11bafx82mGEWaMYWvLI6zCMtw3LKPrPIbrCsFGjRI/TIr/bfUVNTfeBA48kPvbSCpQ/T5UiS36oP0q5ouGMBI0TWo4PTumU2Q/ZTrvzzERIHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSTcgZez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSTcgZez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40020C2BCF6;
	Sun, 10 May 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421361;
	bh=WNlS5KGrIJ+SWL3ygZxbK8TC+u2LpU5BV2wDLG+l528=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSTcgZez3XaeIhho7n2WGZSw5ABZYpJb3CKZ/rAqnXrtO0MIpNrAxyuhKqWOD5Kfv
	 +VgBo46B0FClBf5tp4aMp06e20vNNhdW9oMvJsug9CXmZRVQSQhDwhABqwJfrQfuiV
	 znV3YflG3hryHFJA6hphn5XsLailKa12XTgfUV1c/hzHReDzjiZ8c/xDRAvmhbTWoF
	 TpdOTYkJ9kZoihSll0cZPECdaBxNsB1CzSeBLzzsPJe6jEm0B1CApA7JWpl7i/fRkT
	 MWzgM+qVbSDg0941TFQ4FumG/Ss6VLzWhWy2OhaODhm4wDwpvlOF/CqEd8AMTerhpk
	 +P/4yh9Wyf/Gw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 03/10] sh: mm: drop allocate_pgdat()
Date: Sun, 10 May 2026 16:55:39 +0300
Message-ID: <20260510135546.13554-4-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510135546.13554-1-rppt@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

allocate_pgdat() function used to allocate the node data structure and
initialize its node_start_pfn and node_spanned_pages fields.

Without CONFIG_NUMA there is no need to allocate the node data and
setting node_start_pfn and node_spanned_pages are redundant because they
are anyway overwritten later by core MM.

Remove allocate_pgdat() function.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/mm/init.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e40d5e96be9..d73179116184 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -199,20 +199,6 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 }
 #endif	/* CONFIG_MMU */
 
-void __init allocate_pgdat(unsigned int nid)
-{
-	unsigned long start_pfn, end_pfn;
-
-	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-
-#ifdef CONFIG_NUMA
-	alloc_node_data(nid);
-#endif
-
-	NODE_DATA(nid)->node_start_pfn = start_pfn;
-	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-}
-
 static void __init do_init_bootmem(void)
 {
 	unsigned long start_pfn, end_pfn;
@@ -222,8 +208,6 @@ static void __init do_init_bootmem(void)
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL)
 		__add_active_range(0, start_pfn, end_pfn);
 
-	/* All of system RAM sits in node 0 for the non-NUMA case */
-	allocate_pgdat(0);
 	node_set_online(0);
 
 	plat_mem_setup();
-- 
2.53.0

