Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F32C3251;
	Thu,  2 Jul 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985080; cv=none; b=GhKK0cD9D4skVlQhlbCMJLezCo2jrOJaTM+Vd9TBybwXWdIn3H9YatBJ/gKCTK+w9TORwJ3uSUydu9CJsLGX7iPgMwpfsMCJFJ911C3qOdSR8F+XI/6j43kKG/05qVJouPMWf5xiH12cHRP2yR5QhZDZ8NnUNxwIAMj3PjMj0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985080; c=relaxed/simple;
	bh=yDCdzmRsBm94G7BcAj5zhHim5FEWFIte9e/nqvCWk+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t2zqSlHfSggWXFsJ7bWmZM2gXJ6JKqdAAQBIb6owuvGm2DLvdj/T2eSUi/Bsdv8dBt9Gjre9iLkBLxgAB94a+ichwPG0h0NJmMI8iUoouZMTGnq8XkssLpzSa2hDLUZfGrZBAYVcW9OZuLp1C6XjG8ZnfilFal5+Mw9MJ6OYXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0TjpYu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0TjpYu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2807C1F000E9;
	Thu,  2 Jul 2026 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985079;
	bh=IEP1okcIZa2gmpJL6sublzBeIdAff9WVYBP7uD2+POM=;
	h=From:Subject:Date:To:Cc;
	b=k0TjpYu6civgnHj1E3YNEIjKJ3z1Cn6dgmNf4mMxcSCeVn8Qj++5+jlMhzsXiOXvv
	 gUoT97ls1dVyBPUziCuuhQ31Q612iS8Xo8kHkeuXmTwu0o9Sof8X9LQH0PwSrN3GU0
	 +s4AMWes5Ijecxa/KfuBe4hlMSylNlwUlZU0aWNTp7+XtjtBS+GeulWqiIO+eojb+S
	 wX33xDGTorol/758UyFEWQXKGvmW9Q9hBwydJ4Fro5xNCPvxFskVZM6IfuWaZegAEs
	 Shtay7eXNDEZiLR+xlru7QX0CeDN5/IZaMu628rszlfNLnPzcPHdkquqYyKf2LsGkA
	 3epe8Qcu2y+Xw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH v3 00/10] sh: remove NUMA and SPARSEMEM support
Date: Thu, 02 Jul 2026 12:37:49 +0300
Message-Id: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0xRmoC/5WOTRKCMAyFr+J0bbEtP4or7+G4aDFCVFomLR0dh
 rtL4QSuMl9e3nuZmAdC8Oy8mxhBRI/OLpDvd6zptG2B431hpoSqxFEo7jtux17zqHgtzamCvBb
 SFGwxDAQP/Kxh19vGfjRPaEJKSBdGe+CGtG26tHKELdpDr30ASnqHPjj6rt9EmXK24lIKmZdlU
 WXr4JLTMITLC8jCO3PUstQX1V+OeZ5/ysHc9v8AAAA=
X-Change-ID: 20260702-sh-numa-v2-91b86e3901b4
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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

---
It's been another few weeks without updates from Adrian and I don't see
why it should wait more.

@Andrew, please take it to the mm tree.

v3 changes:
* rebased on v7.2-rc1

v2: https://patch.msgid.link/20260510135546.13554-1-rppt@kernel.org
* remove stale SYS_SUPPORTS_NUMA
* add Arnd's Reviewed-by

v1: https://patch.msgid.link/20260510135546.13554-1-rppt@kernel.org

---
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

 arch/sh/Kconfig                        | 12 --------
 arch/sh/configs/migor_defconfig        |  1 -
 arch/sh/configs/sdk7786_defconfig      |  1 -
 arch/sh/configs/se7722_defconfig       |  1 -
 arch/sh/configs/shx3_defconfig         |  1 -
 arch/sh/configs/ul2_defconfig          |  1 -
 arch/sh/include/asm/mmu.h              |  2 ++
 arch/sh/include/asm/mmzone.h           | 42 ---------------------------
 arch/sh/include/asm/setup.h            |  3 ++
 arch/sh/include/asm/sparsemem.h        | 12 --------
 arch/sh/include/asm/topology.h         | 13 ---------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  5 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  7 -----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  5 ----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  7 -----
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  5 ----
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   | 18 ------------
 arch/sh/kernel/setup.c                 |  7 -----
 arch/sh/kernel/topology.c              | 12 --------
 arch/sh/kernel/vmcore_info.c           |  4 ---
 arch/sh/mm/Kconfig                     | 29 -------------------
 arch/sh/mm/Makefile                    |  1 -
 arch/sh/mm/init.c                      | 24 ---------------
 arch/sh/mm/numa.c                      | 53 ----------------------------------
 arch/sh/mm/sram.c                      |  3 +-
 init/Kconfig                           |  7 -----
 28 files changed, 6 insertions(+), 272 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-sh-numa-v2-91b86e3901b4

--
Sincerely yours,
Mike.

