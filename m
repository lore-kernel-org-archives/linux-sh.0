Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC99313E29;
	Tue, 28 Apr 2026 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394078; cv=none; b=L/ovKAyQvJ4hD57M2Ackd2VudgCphk4X60UUc1/tCdSg7ufO+5beYVQycj/+wUPbpWG5dknAA8/BryK78CtGvnjJL+wMtJ2MVOZuqduB+rjeZDA5S0ljwM4MRmJLN9+SZsAm1x9z7lJKt0K2FDYidVA/FoMTcrstJ6PR0P3c3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394078; c=relaxed/simple;
	bh=SSGvX5eori06RTcAd+RFUFXSIFrU8pgQCr6sM0Zzku8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Vpjc0c+XeuUe54MLgdq22qy0tRbeLeZZb2otyMy6YzYMPXWFVJ/DvPYHuXAHUnDroXFawOEjiZxgv4/HdriWyInKds3je17WuUyO2T5ZnQXD2t92YbJsW6w0VxqV1M7nj5+X6WodjGlVCr0EeNx6ec+LX9k8+/W9xiEjCyGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkXNWJ7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXNWJ7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DFBC2BCB5;
	Tue, 28 Apr 2026 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394078;
	bh=SSGvX5eori06RTcAd+RFUFXSIFrU8pgQCr6sM0Zzku8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkXNWJ7/M92XbIIqnCuSwyLr03O6/AkVzdoi51qjOyTquwaczjPVNNy12MGWk6Spy
	 u0ZCafMK5PDn2oPazYAk/LGZJybB3Bd/1QlSHWEnjdpDvRpFnj+Dlx6imHk6kmRj2W
	 GmtdGnpMa40At7JPZUfzH5PbQeT8wxc5sijxivhr9ls2A3CGyX862g2P9luWNVByyz
	 +vcqvRyI/R7zUU4xbykN0lMFXJwa/DBYQWMkhRzJ1Zz0ap1BJpPahRn8CylVj6ZKkJ
	 oN1OFD/eEvVZqaAJtm/5BUCTOuAsmVApZyoJO+2mkrEd0UcXOPjvWARBVm4r3r7+li
	 pSJVprhHvq2jw==
Date: Tue, 28 Apr 2026 18:34:30 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <afDhluTA6ERvGugQ@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
 <42a4c6c1-762f-449f-9d14-3eb0fa02b94f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42a4c6c1-762f-449f-9d14-3eb0fa02b94f@app.fastmail.com>

(oops, missed that earlier)

On Mon, Apr 13, 2026 at 01:14:49PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 13, 2026, at 12:46, Mike Rapoport wrote:
> >
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
> 
> I had looked at it when you asked me about it last year, and I can
> confirm that agree with all your findings and the resulting patches.
> 
> Whole series
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
 
> Two very minor points:
> 
> * It looks like you left the 'config SYS_SUPPORTS_NUMA' symbol
>   in Kconfig, which no longer does anything, so this should probably
>   be removed in patch 9 along with the lines that select it.

I think it better fits patch 1 that removes CONFIG_NUMA, patch 9 is about
SPARSEMEM.
 
> * It appears that after your series, RISC-V is the only remaining
>   architecture that supports NUMA in 32-bit mode, which I think
>   we should not allow as a configuration, given that this would
>   run into untested code and no hardware exists for it.
>   Apparently commit 4f0e8eef772e ("riscv: Add numa support for
>   riscv64 platform") intended this to only be for 64-bit targets
>   but did not add a Kconfig dependency for CONFIG_64BIT (or
>   CONFIG_SMP, which was added later).

I can send a patch to RISC-V for it.
 
>         Arnd

-- 
Sincerely yours,
Mike.
