Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07635E93C;
	Mon, 13 Apr 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077215; cv=none; b=oYu6XvUhpZQukwCrQDO6xoXE544gw0cIn/BQLlCSZE0VFyyDrHQGZ9x8yoPPaFlk0mEC/tvzkJxLWPkyj659EGR7XyVTYwuVPLbWNir90q2dbI4i86zc7qJzm7UUABVqhy/kXPPWjqgbgXIvEMIkfDxqYCjocWfu1EL2xtOgQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077215; c=relaxed/simple;
	bh=EV5PQN4ZcY4YowILqRqfScomjrS3S5Dkp7GHlFqTkl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODtEqMxsEsLOTZQiXUi9p79YgGUkswljXCmUCIxbwagEXyw/GTAnyW3qXQy1BYjVc1KIy/deymJeBbU6rheDP4ei7MorjtChitZfmZ4xnLbhWfE20tH4Lt0LTOAeRRzA6vKePJRKkhqU0k+nw4QO3fJjaN/0pRxG8IM0oFKrBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGjnUYAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGjnUYAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7825C19421;
	Mon, 13 Apr 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077215;
	bh=EV5PQN4ZcY4YowILqRqfScomjrS3S5Dkp7GHlFqTkl8=;
	h=From:To:Cc:Subject:Date:From;
	b=mGjnUYAVdAklmN+5BaaD9L66bnb0uI92gprtqyMm6V45B8YNGskuFNitZQLvqIGEV
	 UMPapzH0LPv14vwdNpEtEHVw0QbFTf+s13E6ON062rKaHF2SBOGhtf+YJgz9OVjztD
	 xtO4riwaKnxs8Bv7M1l+8Ykb4FsZi+dSFeANT1ygnFw7p+VyhVXwUxigQnV/4ZrL+V
	 LtHvgwG/voxJs4qSTHor9TuydqmsOrbZMmBKTUpdf2ZNU8bSgRC5cdDbyPsfjQxy+I
	 +ldlTC+idJ41ttw8V18RmJyjFkyP2vULUDw85Jn009X7k9jqEv8bNZBpu/K6Q4Oxi+
	 aCHflwUP54brA==
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
Subject: [PATCH 00/10] sh: remove NUMA and SPARSEMEM support
Date: Mon, 13 Apr 2026 13:46:38 +0300
Message-ID: <20260413104649.852228-1-rppt@kernel.org>
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

 arch/sh/Kconfig                        |  8 ----
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
 28 files changed, 6 insertions(+), 268 deletions(-)
 delete mode 100644 arch/sh/include/asm/mmzone.h
 delete mode 100644 arch/sh/include/asm/sparsemem.h
 delete mode 100644 arch/sh/mm/numa.c


base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
--
2.53.0
