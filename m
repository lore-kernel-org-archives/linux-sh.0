Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFE3BB9E0;
	Mon, 13 Apr 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077223; cv=none; b=dLFZ+qzfV0PAVv3S0dz1/OE+Ia0ldaoaLpfkPwi4ABDDzp4gkni1lKWvx9FR5pEXkSaDLdDuCeaZaRwRdIazx1FnbCm0hKwOc+YCbddVZZ2XdVVw3KlJnGvV8Zr847BZKVekGtlA4RP/AJd6Wev5rkfYb3B/emJb97FEgUYFBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077223; c=relaxed/simple;
	bh=7BjG2iui+OOkytqZRFgX73f96pAwpD0HBcDk3D+4z8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEKzZLrt8Jj3QhygGgiOcHuIn3ImEb7LhBk7RagZGuZIWeML4PMfNGBHEbf9FAo7zZeOb1Pb4WNDY5eofpf1JJNw5zWw8raeu9MlinrWhaGMAjDEZ4in//fuEjzrtMAc/x4XrSpHLoa/i4Ke+bjHHmBZvYQJpC0Zw2TVfHFbhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGpqAMZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGpqAMZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBA1C116C6;
	Mon, 13 Apr 2026 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077223;
	bh=7BjG2iui+OOkytqZRFgX73f96pAwpD0HBcDk3D+4z8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGpqAMZwqLk55Is2eL0eB1vwScZ3SQzfPptc0tEa8YnuxOBvqK65DmblEZFWTFUls
	 BAZsmbz4EwZnRjINLzmf6p4vQA+g6H1HCXtcRNir7/ziXHSBjjxdT/GitpWpfrgmlJ
	 F/Q7Q6N+6BN5EadXsfECMVTtel1Eci3z//R6Yz+w1J9Xj7l+O0I2jps7H+urDFTKVb
	 F2MAspwFUMtBEl08yUiymrX2HVgZYURM/kCxKxCgvR1GQuICN8y6r3cSAw1l3EgqiC
	 4gQtAVkNN6Dge8uqFoVA5zzJ0d9vgj/ROCfcXfwr/qng/RG21jtSoiAqAcpsDYvUwE
	 CORrZMuUKWTuw==
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
Subject: [PATCH 03/10] sh: mm: drop allocate_pgdat()
Date: Mon, 13 Apr 2026 13:46:41 +0300
Message-ID: <20260413104649.852228-4-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
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

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/mm/init.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 464a3a63e2fa..977392b478b3 100644
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

