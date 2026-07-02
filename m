Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FF47ECCF;
	Thu,  2 Jul 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985087; cv=none; b=TFM5B84JF+/m81I7GhbDbgMOT12TAZOjnpNQpxUIN1Dnj5AqFbnymOYNj0oFLbVV9LU6WDCbrtMPBwlGe2FaCPfnYt2hV1y0Zcc3Zg47AQpndJSw6IqR3gfrAXqbPuDhlM/+Rct4A7DPSrdazpjCHzwM0PYZnPXV6Ec39y7SOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985087; c=relaxed/simple;
	bh=wWcelrpex8MZS1PYfhbg5GLpu0feR4WvREbRE7F0d/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qgtky2pB+BShiZx91FLOnAtMKt/OvnAv0ItBCxR+8HQ90HwUPXw3CuhI31IF6nu3xz8LmkkE9yMnnojGKxm/q3H5VZ0dUGlujkpm+6ANJqAY4ZzBUK6IoW/sdCWmye45CTHE+g+a0J+cFZJ7NG6eJ0vrT09fYMnx+/ZnIGNrx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq43KTtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq43KTtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4671F00A3A;
	Thu,  2 Jul 2026 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985086;
	bh=wZXeAn79cKmdl5LXbKx9qlBHPdx6/mdKPw9evIgJrM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bq43KTtMrktf3DiWqyaK3HJ7eER+U0mKYoZjhRFXDtKD6loPT3Kmtso9AkjpGGGR6
	 y5aFFTA6PR5GbeeVKftOVnPjz7aVqy2pzrSpzr/X+iPnL1vIe2hnj8GiSq9QsLTY39
	 EkBalUd06aP5lZZs+TiHrjz3bDYcY1OgS5t2gfPP0e7u7mY8lJ0/s00WeSLFZwV4qo
	 peCJ4Q8cKSYkKGHrCpQyxQCv2NRLakbe+jY3XdLxtR7szkYPFOULF/fTNkntxZBQDx
	 pLVJlZ5UEU57Vc+pXoVZjmWJ5ff3XhVI64n2fnBQcxCiMjB8aDoaM2shzEPXgOl+V1
	 1dg4UypH3xg3g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:52 +0300
Subject: [PATCH v3 03/10] sh: mm: drop allocate_pgdat()
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-3-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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
index 110308bdef01..fb728906a83f 100644
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

