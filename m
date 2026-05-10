Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700C3932DC;
	Sun, 10 May 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421353; cv=none; b=Xcg7evIjBoNaRlEqznbmc8hGwoDgmA4NrqMFJCMu5o3ADSjIf1AYOc2PhGbHtMbhvQhoj9yE+S84w/DzzZHJDfaDo4IhEIq0Kn8v3P/cqmKlIfcpm1LQqZVPKDKMbXXDT1aHaS3MAsDncTAW71sEdO11+HUB/67RuKs8ks/SIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421353; c=relaxed/simple;
	bh=hEp+fB+szWATanm+aPu0c2FIrdulFwPdMHX38v8uO8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spKJEGDRAN4gH51d/qaBpvq69B3T9yYQbv+RZuAPXbBY9KM4trBPoCjCjN4I/YtUnrH51SeY++FKbQf5M3t5oOMncS5W4mmZy/gwyRd/BIcRjz5sLV1CgIqc74sDiR+Lfvti/WS61dEmCX4sygcLx5AvEkj/0NRj7a2nUTWpNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8HWEcGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8HWEcGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF03FC2BCB8;
	Sun, 10 May 2026 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421353;
	bh=hEp+fB+szWATanm+aPu0c2FIrdulFwPdMHX38v8uO8w=;
	h=From:To:Cc:Subject:Date:From;
	b=U8HWEcGC+pnbmDN+tPhdfK8wlGhvesQEeyJR5DtCvsaOx7ArijakhUdvDNKN2a8p+
	 iyQNMau+dfWtmCGn9GaMTNkHNGLo906vPDOQeTpE02rqy3oYJmLCEbM0QxzoxYzcq1
	 e/XfGmmg96G2goDvBjEZXEQPVX2k1GhyIyARYWYRWeF3yF/SYTLsJopPQdJgMQYLX9
	 E9HJvIXzVu9iPXVBAeFDKEfM47gvQaL2aQpKIOFL/PQowMGADpmWuHgLJLVXlX8M+b
	 0jLw03sQuwYlSPA0yJtwXCw+SQPCmjBsZhuid6EsB9BEH3iFV8BJz3luUt1qp5a0DC
	 MEMS3L2DBJleg==
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
Subject: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
Date: Sun, 10 May 2026 16:55:36 +0300
Message-ID: <20260510135546.13554-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

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

v2 changes:
* remove stale SYS_SUPPORTS_NUMA
* add Arnd's Reviewed-by

v1: https://lore.kernel.org/all/20260413104649.852228-1-rppt@kernel.org

Mike Rapoport (Microsoft) (10):
  sh: remove CONFIG_NUMA and realted configuration options
  sh: mm: remove numa.c
  sh: mm: drop allocate_pgdat()
  sh: remove setup_bootmem_node() and plat_mem_setup()
  sh: drop dead code guarded by #ifdef CONFIG_NUMA
  sh: drop include/asm/mmzone.h
  init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
  sh: init: remove call the memblock_set_node()
  sh: remove SPARSEMEM related entries from Kconfig
  sh: drop include/asm/sparsemem.h

 arch/sh/Kconfig                        | 12 ------
 arch/sh/configs/migor_defconfig        |  1 -
 arch/sh/configs/sdk7786_defconfig      |  1 -
 arch/sh/configs/se7722_defconfig       |  1 -
 arch/sh/configs/shx3_defconfig         |  1 -
 arch/sh/configs/ul2_defconfig          |  1 -
 arch/sh/include/asm/mmu.h              |  2 +
 arch/sh/include/asm/mmzone.h           | 42 --------------------
 arch/sh/include/asm/setup.h            |  3 ++
 arch/sh/include/asm/sparsemem.h        | 12 ------
 arch/sh/include/asm/topology.h         | 13 -------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  5 ---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  7 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  5 ---
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  7 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  5 ---
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   | 18 ---------
 arch/sh/kernel/setup.c                 |  7 ----
 arch/sh/kernel/topology.c              | 12 ------
 arch/sh/kernel/vmcore_info.c           |  4 --
 arch/sh/mm/Kconfig                     | 29 --------------
 arch/sh/mm/Makefile                    |  1 -
 arch/sh/mm/init.c                      | 24 ------------
 arch/sh/mm/numa.c                      | 53 --------------------------
 arch/sh/mm/sram.c                      |  3 +-
 init/Kconfig                           |  7 ----
 28 files changed, 6 insertions(+), 272 deletions(-)
 delete mode 100644 arch/sh/include/asm/mmzone.h
 delete mode 100644 arch/sh/include/asm/sparsemem.h
 delete mode 100644 arch/sh/mm/numa.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0

