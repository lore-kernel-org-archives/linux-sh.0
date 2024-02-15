Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D536984FC2
	for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015632; cv=none; b=O/8rzQ8uKWbazSFW34QxdHnfXRnLhz6WMJImM38xTvnLn6FgAkQC0mVaYv5nkeZQuwpynUakXbPAUVj8Pb4uVEmsic55CerCTtAPYj85dZUmm4TpE0w9MfugLUNQVKW4ZG9TUwoX8dIpKzTK08ekGwgkz+PvjBOX5S7vbUWm08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015632; c=relaxed/simple;
	bh=ET1dw5ce/7VUO6cFSBj5MxRp0DGgjDhfIrLn7+nLOIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOkCegOJGfJnSz6DqCXP8HeMNzJaNLKO80xWZdg03Hn8NwBBRreLgyQV1Kp+DMlq+8JXiI2qYqK7MCy4EwXP6jLpT1gU1EgD0OYWHpz7SE6Uw44idKzgYr3K0Y9iNvHl3IEeLbfNY1H+fzYR4YTabaisK5xFUibWgedUgFm6hOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Thu, 15 Feb 2024 11:47:23 -0500
From: Rich Felker <dalias@libc.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Landley <rob@landley.net>, Linux-sh list <linux-sh@vger.kernel.org>,
	musl <musl@lists.openwall.com>
Subject: Re: [musl] FDPIC on sh4?
Message-ID: <20240215164723.GG4163@brightrain.aerifal.cx>
References: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
 <20240215134941.GE4163@brightrain.aerifal.cx>
 <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Feb 15, 2024 at 03:53:53PM +0100, Geert Uytterhoeven wrote:
> Hi Rich,
> 
> On Thu, Feb 15, 2024 at 2:49 PM Rich Felker <dalias@libc.org> wrote:
> > On Thu, Feb 15, 2024 at 04:31:00AM -0600, Rob Landley wrote:
> > > Is there any easy way to build FDPIC support for sh4 with-mmu? In theory ARM can
> >
> > On the userspace toolchain and musl side, yes, I see no reason you
> > shouldn't be able to build musl for sh4 with fdpic ABI or build a
> > toolchain for sh4 that defaults to fdpic and has fdpic target-libs. I
> > just tested passing -mfdpic to sh4-linux-musl-gcc and it seems to
> > produce correct fdpic code.
> >
> > On the kernel side, I'm not sure, but the normal ELF loader should be
> > able to load fdpic binaries on a system with mmu. It will not float
> > the data segment separately from text, but doesn't need to because it
> > has an mmu. If this is no longer working it's a kernel regression;
> > that's how I always tested sh2eb fdpic binaries on qemu-system-sh4eb.
> >
> > > do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
> > > fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next to ARM,
> > > switched on the FDPIC loader, and the build broke with:
> > >
> > > fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
> > > binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
> > > `elf_fdpic_arch_lay_out_mm'
> >
> > It looks like there's an arch-provided function that's conditional on
> > !MMU in arch/sh but that, now that fdpic loader is intended to be
> > supported on mmu-ful systems, should be changed to be conditional on
> > fdpic support (or maybe even unconditional if fdpic can be loaded as a
> > module). Just look for where it's defined in arch/sh. If it's in a
> > nommu-specific file it might need to be moved somewhere more
> > appropriate, or an mmu-ful variant may need to be written and placed
> > somewhere more appropriate.
> 
> ARM is the sole architecture that provides elf_fdpic_arch_lay_out_mm().

Ah, I missed that this was a new mmu-ful only function. So I guess
something like the ARM one is needed. I'm not clear why this is
expected to be arch-specific, so it would probably be nice for the
kernel to provide a generic version that archs can use unless they
need specific behaviors here, or just make it conditional whether it's
called at all (only if the arch declares its presence) and use
defaults otherwise.

Rich
