Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E73932DC;
	Sun, 10 May 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421356; cv=none; b=uSiLq4EJFpY3LOD0XQtHtMtvEhFANYyQ76z6/4HB+swPOS5/1GC69e9cT5sg6hR9M5cO5wnxT92a43L6xEbRXPc7CH+KO1ZtEhuqCi13xGW44/OqQ/YvUtP/N6LjM+3GR0IbJATl7MNXQk+q/ZGPM8oZRiQbDqlDaD4iBFcKvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421356; c=relaxed/simple;
	bh=9k0g05iUuWxp09AJbka1ulHptTpb/ZxjRQLmafQLgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWnDTeQu2P2Kc96tznFeK8XpskI/8sExDd7XfdBRlD+eeJ7Eja44ADogu7JP5/COEkytZnGnSQbCQ0IoZYyXelnu9bBqzVlQah1CLd/ym2JU2V+QvOtm00Fq6SEGKUjJlWsrrCHY2IwAPPvOJ37Gudk5/mBtfX6JtPmOeeW0IL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEhGLxDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEhGLxDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C4CC2BCB8;
	Sun, 10 May 2026 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421355;
	bh=9k0g05iUuWxp09AJbka1ulHptTpb/ZxjRQLmafQLgSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEhGLxDbpMUhgEQtSGsOP0KkM0cVqjCKmNJSCSeGWbBUeblNhiOl6zkfH9EqQ47jd
	 MayNaFHLc5OVSYunPiyqa6aG+yHAQOB+/CdeaRkUSOFXy7BMEzIn4Mqbeyj+4UWShK
	 qnJUpf4uVVHcSbAqARd6Tx9XNqFBtxneaFkUmE0G0GZeaC8Fg05tKHWip74ZlIn3yE
	 rsn+q543FTY9H1iwiOsK5mdlNU5DyiwBWm/qkfyWuF72ruuMEECOipfutU3ZjLNmgC
	 YtyJEWeGohId2G3aedgkauGvAFZR3GcBrgMVcglbDQmBM+PWubqBJxiUwIfuJMUPjY
	 Sxi7jv+UPkL7Q==
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
Subject: [PATCH v2 01/10] sh: remove CONFIG_NUMA and realted configuration options
Date: Sun, 10 May 2026 16:55:37 +0300
Message-ID: <20260510135546.13554-2-rppt@kernel.org>
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

NUMA support for SuperH was introduced a long time ago by commit
b241cb0c885e ("sh: Support for multiple nodes.")

	"... for boards with many different memory blocks that are
	 otherwise unused (SH7722/SH7785 URAM and so forth)"

In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
shx3 at the expense of all the NUMA related code in the kernel.

For build of v7.0-rc7 with defconfig and the same configuration with
CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
overhead in code and static data that does not take into the account data
structures allocated at run time.

And all this overhead has been there for nothing for almost 8 years
because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
those additional "nodes" could not be used by the core MM because the
maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.

Start removing NUMA support on sh with removing CONFIG_NUMA and related
configuration options in arch/sh/Kconfig and arch/sh/mm/Kconfig.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/Kconfig                   |  6 ------
 arch/sh/configs/migor_defconfig   |  1 -
 arch/sh/configs/sdk7786_defconfig |  1 -
 arch/sh/configs/se7722_defconfig  |  1 -
 arch/sh/configs/shx3_defconfig    |  1 -
 arch/sh/configs/ul2_defconfig     |  1 -
 arch/sh/mm/Kconfig                | 19 -------------------
 7 files changed, 30 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d5795067befa..d0ba91eba71a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -106,9 +106,6 @@ config SYS_SUPPORTS_APM_EMULATION
 config SYS_SUPPORTS_SMP
 	bool
 
-config SYS_SUPPORTS_NUMA
-	bool
-
 config STACKTRACE_SUPPORT
 	def_bool y
 
@@ -197,7 +194,6 @@ config CPU_SHX3
 	bool
 	select DMA_COHERENT
 	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_NUMA
 
 config ARCH_SHMOBILE
 	bool
@@ -443,7 +439,6 @@ config CPU_SUBTYPE_SH7785
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
-	select SYS_SUPPORTS_NUMA
 	select PINCTRL
 
 config CPU_SUBTYPE_SH7786
@@ -478,7 +473,6 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
-	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
 
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 1d9d543eef4c..db993616f14e 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -9,7 +9,6 @@ CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7722=y
 CONFIG_MEMORY_START=0x0c000000
-CONFIG_NUMA=y
 # CONFIG_MIGRATION is not set
 CONFIG_SH_MIGOR=y
 # CONFIG_SH_TIMER_CMT is not set
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index d6fa3a422e24..36e6dd0622f7 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -41,7 +41,6 @@ CONFIG_CPU_SUBTYPE_SH7786=y
 CONFIG_MEMORY_START=0x40000000
 CONFIG_MEMORY_SIZE=0x20000000
 CONFIG_PMB=y
-CONFIG_NUMA=y
 CONFIG_HUGETLB_PAGE_SIZE_64MB=y
 CONFIG_KSM=y
 CONFIG_SH_STORE_QUEUES=y
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 85b8eb013b79..2908611b118e 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -10,7 +10,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7722=y
 CONFIG_MEMORY_START=0x0c000000
-CONFIG_NUMA=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_7722_SOLUTION_ENGINE=y
 # CONFIG_SH_TIMER_CMT is not set
diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defconfig
index 0cb69a0b92cb..22c242cf89f7 100644
--- a/arch/sh/configs/shx3_defconfig
+++ b/arch/sh/configs/shx3_defconfig
@@ -29,7 +29,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SHX3=y
 CONFIG_MEMORY_START=0x0c000000
-CONFIG_NUMA=y
 CONFIG_PAGE_SIZE_64KB=y
 CONFIG_SH_STORE_QUEUES=y
 CONFIG_SH_X3PROTO=y
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 00a37944b043..1740a6465280 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -10,7 +10,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7366=y
 CONFIG_MEMORY_SIZE=0x01f00000
-CONFIG_NUMA=y
 # CONFIG_MIGRATION is not set
 # CONFIG_SH_DSP is not set
 # CONFIG_SH_TIMER_CMT is not set
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 1862411665ab..71fecbbb080e 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -112,27 +112,8 @@ config VSYSCALL
 	  For systems with an MMU that can afford to give up a page,
 	  (the default value) say Y.
 
-config NUMA
-	bool "Non-Uniform Memory Access (NUMA) Support"
-	depends on MMU && SYS_SUPPORTS_NUMA
-	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	default n
-	help
-	  Some SH systems have many various memories scattered around
-	  the address space, each with varying latencies. This enables
-	  support for these blocks by binding them to nodes and allowing
-	  memory policies to be used for prioritizing and controlling
-	  allocation behaviour.
-
-config NODES_SHIFT
-	int
-	default "3" if CPU_SUBTYPE_SHX3
-	default "1"
-	depends on NUMA
-
 config ARCH_FLATMEM_ENABLE
 	def_bool y
-	depends on !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-- 
2.53.0

