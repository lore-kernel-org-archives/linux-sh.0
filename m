Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997E393DE9;
	Sun, 10 May 2026 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421365; cv=none; b=QhFvBDiVDsQr5abw/Gz1BpGtBTDht/sfPN4LPAFTC/K8o9neWQYfPa7KjLFNp1H8jv6b89ifTuOqwGrwJHWjEtNVic7pn0Cpo4fD5Cxnvjs53lrvhPXNtMhDtno+ld/QSMBrcfUCUieRN/6xdj8/EreHjiob0yFOgs9kWbAnlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421365; c=relaxed/simple;
	bh=t+0t9hvA3tabF5jUso2oxhF2AbVitxrNZunjEKj5M/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPSC2iiEOtBmzoS4+zp1cSWzoqWTegjzsQsO9kcxVioYhIX9ng5MNP7SuzOl3xEbUTCCk85ibkRQoQddIfzLYKu44Tp9ydTPc6U3PmoQ67AJnZdO9LjcXuXumQ0k+xM8ZL/Dp5OKLTDbMy7w2VPCX4nRPlGST+IHGDHM0/zYxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQT2Wxjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQT2Wxjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E1DC2BCC9;
	Sun, 10 May 2026 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421364;
	bh=t+0t9hvA3tabF5jUso2oxhF2AbVitxrNZunjEKj5M/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQT2Wxjs4v+g/nPjbC7YXF9SenInlURoMPi3uzxYo7W5Le0rVdc9n3EIL1+/cQZUr
	 561KxpXO5Y26QutNzT5arFgo6r6ReQOx2gamBfrrRcn5VnEHddYpCpMZ1LGs8K3UKT
	 cWsNOpCJ8xbFeu8apFhOlUuU9btobZmlBjFnDqG/lUaVAwUxMAZitvKNOBHtzJvi+m
	 nikzGApHg82ZELNIa5YmnCZW/u6AeADKG1ZKulXcnRN7/Pl9X69AigP0Uhsx7KkbJv
	 2bzwkflILNYftHh4qooLcKI02gkezN6m87CY1R4I9wRCvgnCB9Jbf36OYGK44utkAt
	 TJedGoYX6b+OA==
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
Subject: [PATCH v2 04/10] sh: remove setup_bootmem_node() and plat_mem_setup()
Date: Sun, 10 May 2026 16:55:40 +0300
Message-ID: <20260510135546.13554-5-rppt@kernel.org>
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

setup_bootmem_node() and plat_mem_setup() were needed to setup NUMA "nodes"
for URAM memory ranges. Since there is no NUMA support anymore, these
functions are not needed.

Remove them.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  5 -----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  4 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  6 ------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  4 ----
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   | 17 -----------------
 arch/sh/mm/init.c                      |  7 -------
 7 files changed, 49 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 6676beef053e..0a4ceb9785f6 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -381,8 +381,3 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
-
-void __init plat_mem_setup(void)
-{
-	/* TODO: Register Node 1 */
-}
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 0c6757ef63f4..2180819a1455 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -658,9 +658,3 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
-
-void __init plat_mem_setup(void)
-{
-	/* Register the URAM space as Node 1 */
-	setup_bootmem_node(1, 0x055f0000, 0x05610000);
-}
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 2ad19a0c5e04..1f4396da00e5 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -1239,7 +1239,3 @@ void __init plat_irq_setup_pins(int mode)
 		BUG();
 	}
 }
-
-void __init plat_mem_setup(void)
-{
-}
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 3b4a414d60a9..95c3cc15a443 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -600,9 +600,3 @@ void __init plat_irq_setup_pins(int mode)
 		BUG();
 	}
 }
-
-void __init plat_mem_setup(void)
-{
-	/* Register the URAM space as Node 1 */
-	setup_bootmem_node(1, 0xe55f0000, 0xe5610000);
-}
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index c048842d8a58..a46d6c3241a9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -783,10 +783,6 @@ void __init plat_irq_setup_pins(int mode)
 	}
 }
 
-void __init plat_mem_setup(void)
-{
-}
-
 static int __init sh7786_devices_setup(void)
 {
 	int ret, irq;
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index 7014d6d199b3..3197ec2a65cd 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -377,20 +377,3 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
-
-void __init plat_mem_setup(void)
-{
-	unsigned int nid = 1;
-
-	/* Register CPU#0 URAM space as Node 1 */
-	setup_bootmem_node(nid++, 0x145f0000, 0x14610000);	/* CPU0 */
-
-#if 0
-	/* XXX: Not yet.. */
-	setup_bootmem_node(nid++, 0x14df0000, 0x14e10000);	/* CPU1 */
-	setup_bootmem_node(nid++, 0x155f0000, 0x15610000);	/* CPU2 */
-	setup_bootmem_node(nid++, 0x15df0000, 0x15e10000);	/* CPU3 */
-#endif
-
-	setup_bootmem_node(nid++, 0x16000000, 0x16020000);	/* CSM */
-}
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index d73179116184..84dff240b113 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -38,11 +38,6 @@ void __init generic_mem_init(void)
 	memblock_add(__MEMORY_START, __MEMORY_SIZE);
 }
 
-void __init __weak plat_mem_setup(void)
-{
-	/* Nothing to see here, move along. */
-}
-
 #ifdef CONFIG_MMU
 static pte_t *__get_pte_phys(unsigned long addr)
 {
@@ -209,8 +204,6 @@ static void __init do_init_bootmem(void)
 		__add_active_range(0, start_pfn, end_pfn);
 
 	node_set_online(0);
-
-	plat_mem_setup();
 }
 
 static void __init early_reserve_mem(void)
-- 
2.53.0

