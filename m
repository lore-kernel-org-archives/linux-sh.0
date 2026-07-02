Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2B480948;
	Thu,  2 Jul 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985092; cv=none; b=FCNgmvHxxZoP+rV0Z68lp5ldwd1WQrvAGB5uNjGhh75Ka5ZMaF/4SaD5yz9sTqj/X8Yb+Ba8xokWE1RLafN3WIE066BMc5FdVpXOucyD/iADpwL8tUGK7nHWSLYfe/kYFAAybpOIfGueDRR83zuXb2KNhDBWk/r7TR2VuRoiij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985092; c=relaxed/simple;
	bh=2XrTEAir9aCoEtLxNGRLa0Aiyp8tcmHHd8OF568m3Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obstiKCbX5kHiYxWvu78GImUDUX9H7rt6/ah1A1gnhpA2xi1SNdbvs5mhRNeKnAnvVP0oRSxJk4aYTuHZNVkIX8VVfWqrATFFQLZdbL0uYrlm/bUkRq83t80dBL673MYsvtZOQS9E/lPvNsPmu9lsqU+6s6dhYuMEUCXFP4S6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqCmYmD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqCmYmD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFC91F00A3A;
	Thu,  2 Jul 2026 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985091;
	bh=EF9L+GgI/33Pz9hodVkKykvSIQhT5HiffP4Kh4e1uS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PqCmYmD0DafeHWDBv/S60jwlb724MmiCfeyHD/us1Y/WeeFBGakg5wT/Ivh3guNIN
	 uT5p3IHjndR3fhajTsBw4PdVjZt2f8JVncahzeUfeDjgnMqeJVj64IExcPA068GvZ7
	 br2xHQVcB5rlkKGDRLttyTZ8dDd25/tuqyDSKb3H60wO2X8Yn+QJqDcVMtnuA4wl9d
	 kR5xmsfr63eB2TnS/E4WEPYhZV1pOJoD/6LzcrKYufY6pQ8IJExQByMDlQPBFzW3HS
	 n5VIFqfQgG3FiAZBDGkhC4WgPUkn4km446lh8MZZ3VqQ2GECdFuov2gDjRBljgGkv4
	 qdIYKRgr/e3iw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:54 +0300
Subject: [PATCH v3 05/10] sh: drop dead code guarded by #ifdef CONFIG_NUMA
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-5-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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

