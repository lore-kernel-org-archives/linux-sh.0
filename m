Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205703B9DAA;
	Mon, 13 Apr 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077226; cv=none; b=oadClEpSpqoPnMoUSFYZzSCZdbarU/Rxm2jIJqtw32/pYZgqK6xN84gwjMxefIuUAiNsayQewErWwcnzEKdiMd0MJ6aZYoO4+ywWCrd5qw2rSd23vwudhz6IT9i+LokIcrRBZMgQEE4DZAo0p+wuaKPd3XUqO/fKVOhsCMaGOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077226; c=relaxed/simple;
	bh=NTx/BlRB94FmVGy5XD+EGk+9lfiA/foFvPvF3Gh8bjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4gdEyHTcohFlC/UfEuB9GZZi+lyaZkbQUp6/AMMdnC5NqTONIaqTVJye3/aNB8W5mHbi9qBKCB4ZJBEi2vrWb0K63ZPznxD9Ji4BeZqgmK5rKq5H2+3ckMrxW9zA8F32vngukOXEW1+fe3McNBcti2yZDmB0liMst4smbL6+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+F5Z2nG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+F5Z2nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9EC19421;
	Mon, 13 Apr 2026 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077226;
	bh=NTx/BlRB94FmVGy5XD+EGk+9lfiA/foFvPvF3Gh8bjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+F5Z2nGhLm5eUA+/YoN+Dn4qQW+AkyGZP0kCoDy+JOdVppgzGlrkv10Mp2EX2VqT
	 o0cC7LlQIac4TUoCUQq3XxKiGQkfF2JUmSKlROxBD/KZLPgT6DoGJHk5sdq7sg9VT0
	 5rkt8E0i7lhguHm6lk0BSNttMd9y+UpGmVR6qNZ2gJtIkwnWuA3kUemklLFYo4npFr
	 /QzgdaEQpF84w+WV7I+b9em7dOY7ne/yN7CVUbCeoxUgKWK+dOL3W4ojruVSARks6D
	 y2sgQ9EDu08KAUVsUP/GNZFql/dInKz0VS0yv0Gk/2+ziSxivgvsHn565ZEza0HUvl
	 CcQI1da6DWTEQ==
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
Subject: [PATCH 04/10] sh: remove setup_bootmem_node() and plat_mem_setup()
Date: Mon, 13 Apr 2026 13:46:42 +0300
Message-ID: <20260413104649.852228-5-rppt@kernel.org>
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

setup_bootmem_node() and plat_mem_setup() were needed to setup NUMA "nodes"
for URAM memory ranges. Since there is no NUMA support anymore, these
functions are not needed.

Remove them.

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
index 977392b478b3..b34ba42d1e18 100644
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

