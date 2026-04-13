Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207133BE16C;
	Mon, 13 Apr 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078630; cv=none; b=GIj6LW7zbE5ujLLzH+MA5rAKrXutTyJqc91pRwvi9dAFJPCtk2breRH8JdYl7IN64RO/g+HUsZ+VuYC5HDzitOsbRw3rIIEa3MVIOnpgh6FL9t7mWDe+Np+04LuF4Ft/dptn957VDZXiJe0PXB4BFB7GWDtTEtHPBiG0KCttHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078630; c=relaxed/simple;
	bh=MFlOW9kk8rHsg880s203lGteCMK1NJb5PGM+St9apqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk9RxlzWFhFzbc+yx3qsNUKsU32tXYkqHNhl4WFP3ZLG8uWua/rPyPpLoRSElduO+y1zXi4B49aKGJ+l8n4qwiVOGiKQiMBR09pdXSv859q+UuN5AYkwzwMDnomt+7G8EMxpuNOnv/4g+YKz3eGSxa1EXSUbhGVp+AA0yYRbDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+P5yW7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+P5yW7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14520C116C6;
	Mon, 13 Apr 2026 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776078629;
	bh=MFlOW9kk8rHsg880s203lGteCMK1NJb5PGM+St9apqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+P5yW7ZfVumqiEtEcWKY2d5RUkwq4jBgocf5pz5YZ01HKI8ljG1+OJMdlY8zn78L
	 yWKXnuuI0KII/tV6nF4Xq6IhBbAPEZLo0nNQBIxPicVHiHgC7EsqW4QDoWbG3c6ddO
	 CvKryvqJdm0WFPctMj/mAjekbnacJMkidRBNd9t2u3yABCd8oSgbuN+IaBiKvRMpiX
	 rm6ytyCXoFbsfGQqH44TyxnSThdrwKXZ/f1VELFcuDsVHvLs901g8o/iHabKIgPaZz
	 v8nmiCgh77b/JoydqMgnHIOThmeopSh6MipKBTe9GqMtadPOMP/BcNiDxW3+C+Y+7c
	 2dUDJ2gZJOM7A==
Date: Mon, 13 Apr 2026 14:10:23 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <adzPH3XAAzek7Ue5@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
 <44fcae62f14a4020483b8a2f867c94045155fdb9.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fcae62f14a4020483b8a2f867c94045155fdb9.camel@physik.fu-berlin.de>

Hi Adrian,

On Mon, Apr 13, 2026 at 12:57:49PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Mike,
> 
> On Mon, 2026-04-13 at 13:46 +0300, Mike Rapoport wrote:
> > NUMA support for SuperH was introduced a long time ago by commit
> > b241cb0c885e ("sh: Support for multiple nodes.")
> > 
> > 	"... for boards with many different memory blocks that are
> > 	 otherwise unused (SH7722/SH7785 URAM and so forth)"
> > 
> > In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> > shx3 at the expense of all the NUMA related code in the kernel.
> > 
> > For build of v7.0-rc7 with defconfig and the same configuration with
> > CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> > CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> > overhead in code and static data that does not take into the account data
> > structures allocated at run time.
> > 
> > And all this overhead has been there for nothing for almost 8 years
> > because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> > those additional "nodes" could not be used by the core MM because the
> > maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.
> > 
> > Mike Rapoport (Microsoft) (10):
> >   sh: remove CONFIG_NUMA and realted configuration options
> >   sh: mm: remove numa.c
> >   sh: mm: drop allocate_pgdat()
> >   sh: remove setup_bootmem_node() and plat_mem_setup()
> >   sh: drop dead code guarded by #ifdef CONFIG_NUMA
> >   sh: drop include/asm/mmzone.h
> >   init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
> >   sh: init: remove call the memblock_set_node()
> >   sh: remove SPARSEMEM related entries from Kconfig
> >   sh: drop include/asm/sparsemem.h
> 
> Thanks a lot for the series. It will take me some time to review and I expect
> it to be taken for v7.2.

Yes, this for v7.2.

> FWIW, I actually own several boards using the SH-7785LCR CPU and I issues
> booting kernels newer than 6.5 on these so I'm wondering whether this
> broken feature might be to blame?

If 6.5 boots successfully, I don't think this is related.
 
> Adrian

-- 
Sincerely yours,
Mike.
