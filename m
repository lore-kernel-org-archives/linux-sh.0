Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F947F2C6;
	Thu,  2 Jul 2026 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985090; cv=none; b=YEHFQICWitoi7aNIvPkqyVhjkhAQFS/5WVAZ3CppG79RmYURAh396U4dCaQHvm17XG7MdHpi/Xb/Hb9NQUQ9r4eCviK4oiONecU0UbRyW/FSPSPpv94ZshbeQi7xef4b3P/oB6TpdV2sit/b/kbyQXzwnEMi0AXP452rtyJReXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985090; c=relaxed/simple;
	bh=G8H6/PNYuRmZZLBII90fuGJ5O0e+JEkxP8mmo4oAOwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xt/nelP7cHF88tCioq2v19+bX9D1xZVDrNBe1Tg/g3TvPvBRYFMLza6sDBTn2hbBDoVFN/7KTz2/7F76jtjc2Li3T1uRNW6thmw4qeETUqkW7oKPXua2JctBZx7ZtBvIFwfjhsVm68btRXpu5V4DVXcgbVLDoFGW85JA8pXvTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5JNiuf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5JNiuf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB121F000E9;
	Thu,  2 Jul 2026 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985089;
	bh=JpN7yVvQRr2K44P0EZhzTz2q7tFXMEmwB1FjKRtQq+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B5JNiuf+jyNK56XjhCV1lAuM0pEe+K1cITjDTHUpSY++IPTYU5ISr4NU7tp5PUBpw
	 gwRzJWURTB7cWimO0AwPfH85X+BxD5wOPwT9b7YxU89kRgxFmwrQopwL+UeCe0WXRL
	 LaOUb3k3NpjV7RlYTf1nrCADlI/cn2b+gU8KMVaDsuqIuOKjkODt8ZdK7Er6x3IWJG
	 TtGzP+8ZKXJRZmAyHOh/ylYoQYiK26opKg9AxBFbVu7MQ+o06m7nlUdlsLehaPFw8V
	 vAVxMSIkld0EEGOvPEPwgxA773UxkzS2gab1ZnHUQ+4Nfnhp3Ga8O9hej+4aWvirqU
	 RnRz7B7wpj+ug==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:53 +0300
Subject: [PATCH v3 04/10] sh: remove setup_bootmem_node() and
 plat_mem_setup()
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-4-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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
index fb728906a83f..1efc3104a9df 100644
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

