Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860F393DE9;
	Sun, 10 May 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421367; cv=none; b=l8IYjH/Rh/ERBh7v/1WxC8ZCzuRbhI5OjeAqE0Kgtfjr+OJQd8WY0yXx3LCVXhEvU8UgEPiJhzNto1XZvocw9dCJwTLtfkdV4L3qZIEhRLTJtTXlM+qBpjRAXY/R6e2j+TV1pZrdcPTUROMU5DRpdCi3ySRBc5IhBDO0ZckwwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421367; c=relaxed/simple;
	bh=dCoYxGOmCvzNhzjVc8kfAvk/FtIfCDilY+5h2I/R/so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNNqX2v3ICqQ+D+xqbMP4U2QHzWMX5ZslUOs5qVIG565oHE2Yjiqa/P5HqvldgyXeBtJjEZXvlVDn7Z4Nol8yLbmtPqb9rriw0bkNZ3CS6qRcewTGLTuV8kDgygHL1j8EHlhjjerm8KOlUhzfhwc8ZImBuGoB+3fKwsxXV3UqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJiJvlCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJiJvlCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1742C2BCB8;
	Sun, 10 May 2026 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421367;
	bh=dCoYxGOmCvzNhzjVc8kfAvk/FtIfCDilY+5h2I/R/so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJiJvlCO8M1yDT6WaVcgoIJeHuqMRPpPOUmfiaZrdRiTsYe+YX2GCCv4d1fpVG8GY
	 kjiiB0csgEuGBHXDVfwnizB5RZdeUb+8gXF34ze5wqBpvOZBojAKWJea/7UdakW05V
	 iJ5PTNxuJ2apxYWH+tPz2kYr3xcgufwqPnuYV3N7Zuf2QrPSpTqEhApom3cKSlFUi4
	 IMRgeOOjjhOiU1TMigmEaDREIRrciAuxNDVIzL/cf+/mgjFL+F4gmG6ZSlZtVN0v3I
	 QeKxKII98zvcZsikSgqaZFIVJZBiUWh8bNUyDbLUQB1BsNJujk8unyWBNnJSk3cX0y
	 tLfpWxvPZnzvA==
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
Subject: [PATCH v2 05/10] sh: drop dead code guarded by #ifdef CONFIG_NUMA
Date: Sun, 10 May 2026 16:55:41 +0300
Message-ID: <20260510135546.13554-6-rppt@kernel.org>
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

and NUMA-related comments.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/include/asm/topology.h | 13 -------------
 arch/sh/kernel/setup.c         |  1 -
 arch/sh/kernel/topology.c      | 12 ------------
 arch/sh/kernel/vmcore_info.c   |  4 ----
 arch/sh/mm/sram.c              |  3 +--
 5 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/sh/include/asm/topology.h b/arch/sh/include/asm/topology.h
index 1db470e02456..a3c31754ba5f 100644
--- a/arch/sh/include/asm/topology.h
+++ b/arch/sh/include/asm/topology.h
@@ -2,19 +2,6 @@
 #ifndef _ASM_SH_TOPOLOGY_H
 #define _ASM_SH_TOPOLOGY_H
 
-#ifdef CONFIG_NUMA
-
-#define cpu_to_node(cpu)	((void)(cpu),0)
-
-#define cpumask_of_node(node)	((void)node, cpu_online_mask)
-
-#define pcibus_to_node(bus)	((void)(bus), -1)
-#define cpumask_of_pcibus(bus)	(pcibus_to_node(bus) == -1 ? \
-					cpu_all_mask : \
-					cpumask_of_node(pcibus_to_node(bus)))
-
-#endif
-
 #define mc_capable()    (1)
 
 const struct cpumask *cpu_coregroup_mask(int cpu);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 039a51291002..5e25c1db4d61 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -227,7 +227,6 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 	/*
 	 * Also make sure that there is a PMB mapping that covers this
 	 * range before we attempt to activate it, to avoid reset by MMU.
-	 * We can hit this path with NUMA or memory hot-add.
 	 */
 	pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
 			 PAGE_KERNEL);
diff --git a/arch/sh/kernel/topology.c b/arch/sh/kernel/topology.c
index 2d2a7509b565..906b7b1d5443 100644
--- a/arch/sh/kernel/topology.c
+++ b/arch/sh/kernel/topology.c
@@ -57,18 +57,6 @@ static int __init topology_init(void)
 			       __func__, i, ret);
 	}
 
-#if defined(CONFIG_NUMA) && !defined(CONFIG_SMP)
-	/*
-	 * In the UP case, make sure the CPU association is still
-	 * registered under each node. Without this, sysfs fails
-	 * to make the connection between nodes other than node0
-	 * and cpu0.
-	 */
-	for_each_online_node(i)
-		if (i != numa_node_id())
-			register_cpu_under_node(raw_smp_processor_id(), i);
-#endif
-
 	return 0;
 }
 subsys_initcall(topology_init);
diff --git a/arch/sh/kernel/vmcore_info.c b/arch/sh/kernel/vmcore_info.c
index a244a204a1b1..9f029b4a7e63 100644
--- a/arch/sh/kernel/vmcore_info.c
+++ b/arch/sh/kernel/vmcore_info.c
@@ -5,10 +5,6 @@
 
 void arch_crash_save_vmcoreinfo(void)
 {
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
 #ifdef CONFIG_X2TLB
 	VMCOREINFO_CONFIG(X2TLB);
 #endif
diff --git a/arch/sh/mm/sram.c b/arch/sh/mm/sram.c
index 2d8fa718d55e..208080f072df 100644
--- a/arch/sh/mm/sram.c
+++ b/arch/sh/mm/sram.c
@@ -16,8 +16,7 @@
  * This provides a standard SRAM pool for tiny memories that can be
  * added either by the CPU or the platform code. Typical SRAM sizes
  * to be inserted in to the pool will generally be less than the page
- * size, with anything more reasonably sized handled as a NUMA memory
- * node.
+ * size.
  */
 struct gen_pool *sram_pool;
 
-- 
2.53.0

