Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4A350A18;
	Mon, 18 May 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104613; cv=none; b=Ukrm1rUZbcBWR0c3fRwHHA6WssRpywWOWUkrYtsNn+aJTMvC0jJY0NC93db8mu5rMsn1x7O0SgIQ4oVSGv6ymrhOVcV24wmWb1jEAb1MAyQ9PFrPBOYwac66K4w7FPZEZAA4hCirESA9fsJV5ixJB7heiqXnUU8dRq5utK2Bhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104613; c=relaxed/simple;
	bh=NwRHLAJsOaN4Dj+muAR6EQyF5lPlAIab8xZkaoNQArs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwQpf1KbWHPZTkTIB8hI3tyt3Gezwm7YJ0z/dfOrh9qxCTndYYSZlsANfndkQR+CZt225AdieiSfhKWfUYjKil5Zf91Mn9zlDA6pUoCIFfAtT9y0/blX3MfeG1sleWP/P5aEn9cQuVQ0nT96bXvWhyOjrMUycuoq3adtqksW4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPJTLxZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPJTLxZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64987C2BCB7;
	Mon, 18 May 2026 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104613;
	bh=NwRHLAJsOaN4Dj+muAR6EQyF5lPlAIab8xZkaoNQArs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPJTLxZg5YCe0QNfd49BMjmAxKT9sopqbynLQlobYFv5iz0hapCYXxrE3+nOeMvbf
	 THbg/Uu529siYkaBgQMfeEiAjMFRQzHvyQbZXX647k0NXtL8W5i1K94MH8d8G5DzhD
	 b+yyyQoZvQePkAVg6riNbFOherT0VXl8SuuzgViWkzkAwQdF9jSpymnJ2u1FRi16rx
	 mp2GBvD9pUOWyfXePS6dFLhnCFir5AXOu83JQand5+rLVGEcOTAA+u4CfGlBugKvDw
	 F6ot2fPHvk7giHcUz+0iky3F3DTv2KJ01QzDcu116hKPO7ftPek5nLOGHdVhTbfN11
	 94i3E8GCW5UTA==
Date: Mon, 18 May 2026 14:43:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <agr7XvoWn_-axX1-@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510135546.13554-1-rppt@kernel.org>

Gentle ping?

On Sun, May 10, 2026 at 04:55:36PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> NUMA support for SuperH was introduced a long time ago by commit
> b241cb0c885e ("sh: Support for multiple nodes.")
> 
> 	"... for boards with many different memory blocks that are
> 	 otherwise unused (SH7722/SH7785 URAM and so forth)"
> 
> In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> shx3 at the expense of all the NUMA related code in the kernel.
> 
> For build of v7.0-rc7 with defconfig and the same configuration with
> CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> overhead in code and static data that does not take into the account data
> structures allocated at run time.
> 
> And all this overhead has been there for nothing for almost 8 years
> because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> those additional "nodes" could not be used by the core MM because the
> maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.
> 
> v2 changes:
> * remove stale SYS_SUPPORTS_NUMA
> * add Arnd's Reviewed-by
> 
> v1: https://lore.kernel.org/all/20260413104649.852228-1-rppt@kernel.org
> 
> Mike Rapoport (Microsoft) (10):
>   sh: remove CONFIG_NUMA and realted configuration options
>   sh: mm: remove numa.c
>   sh: mm: drop allocate_pgdat()
>   sh: remove setup_bootmem_node() and plat_mem_setup()
>   sh: drop dead code guarded by #ifdef CONFIG_NUMA
>   sh: drop include/asm/mmzone.h
>   init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
>   sh: init: remove call the memblock_set_node()
>   sh: remove SPARSEMEM related entries from Kconfig
>   sh: drop include/asm/sparsemem.h
> 
>  arch/sh/Kconfig                        | 12 ------
>  arch/sh/configs/migor_defconfig        |  1 -
>  arch/sh/configs/sdk7786_defconfig      |  1 -
>  arch/sh/configs/se7722_defconfig       |  1 -
>  arch/sh/configs/shx3_defconfig         |  1 -
>  arch/sh/configs/ul2_defconfig          |  1 -
>  arch/sh/include/asm/mmu.h              |  2 +
>  arch/sh/include/asm/mmzone.h           | 42 --------------------
>  arch/sh/include/asm/setup.h            |  3 ++
>  arch/sh/include/asm/sparsemem.h        | 12 ------
>  arch/sh/include/asm/topology.h         | 13 -------
>  arch/sh/kernel/cpu/sh4a/setup-sh7366.c |  5 ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  7 ----
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  1 -
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  1 -
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |  5 ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  7 ----
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  5 ---
>  arch/sh/kernel/cpu/sh4a/setup-shx3.c   | 18 ---------
>  arch/sh/kernel/setup.c                 |  7 ----
>  arch/sh/kernel/topology.c              | 12 ------
>  arch/sh/kernel/vmcore_info.c           |  4 --
>  arch/sh/mm/Kconfig                     | 29 --------------
>  arch/sh/mm/Makefile                    |  1 -
>  arch/sh/mm/init.c                      | 24 ------------
>  arch/sh/mm/numa.c                      | 53 --------------------------
>  arch/sh/mm/sram.c                      |  3 +-
>  init/Kconfig                           |  7 ----
>  28 files changed, 6 insertions(+), 272 deletions(-)
>  delete mode 100644 arch/sh/include/asm/mmzone.h
>  delete mode 100644 arch/sh/include/asm/sparsemem.h
>  delete mode 100644 arch/sh/mm/numa.c
> 
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
