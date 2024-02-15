Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E2A131736
	for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004976; cv=none; b=c4XP12IMnvCQG3iowzDElbEN1XZWLV8FFhDnx5L2fJoAGcyr1jsn1/LWZylj3rw97BjOYs5qwUHTgmMkDyQ7/A1eHIHDsJRuFu3UfjsVYa0Bk0HdK4sCpz6eRl/400/p1OSQ8//mKEHrJz+Ossak8eTvOIYfQFs/fzPYdc4S1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004976; c=relaxed/simple;
	bh=ixeMAz8/YO5YHYRHptRZ6G+Isv1q3IpBkGoy6i8mzN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h60GT8owm92dQta8tzGpEKXURY9SWZeYjAgnL50iSK9nyVePQgXktkzX/IzENe2XGq8YQqrtDQTMgmtIVsEoll0NFVwSxsnvU64NDEJ44cMoJINLXchmqBc9JBfA/GM71adOhjoAMvw4pV07X6JTOyfH7x2+85W7UPMVAnegLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Thu, 15 Feb 2024 08:49:41 -0500
From: Rich Felker <dalias@libc.org>
To: Rob Landley <rob@landley.net>
Cc: Linux-sh list <linux-sh@vger.kernel.org>,
	musl <musl@lists.openwall.com>
Subject: Re: [musl] FDPIC on sh4?
Message-ID: <20240215134941.GE4163@brightrain.aerifal.cx>
References: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Feb 15, 2024 at 04:31:00AM -0600, Rob Landley wrote:
> Is there any easy way to build FDPIC support for sh4 with-mmu? In theory ARM can

On the userspace toolchain and musl side, yes, I see no reason you
shouldn't be able to build musl for sh4 with fdpic ABI or build a
toolchain for sh4 that defaults to fdpic and has fdpic target-libs. I
just tested passing -mfdpic to sh4-linux-musl-gcc and it seems to
produce correct fdpic code.

On the kernel side, I'm not sure, but the normal ELF loader should be
able to load fdpic binaries on a system with mmu. It will not float
the data segment separately from text, but doesn't need to because it
has an mmu. If this is no longer working it's a kernel regression;
that's how I always tested sh2eb fdpic binaries on qemu-system-sh4eb.

> do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
> fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next to ARM,
> switched on the FDPIC loader, and the build broke with:
> 
> fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
> binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
> `elf_fdpic_arch_lay_out_mm'

It looks like there's an arch-provided function that's conditional on
!MMU in arch/sh but that, now that fdpic loader is intended to be
supported on mmu-ful systems, should be changed to be conditional on
fdpic support (or maybe even unconditional if fdpic can be loaded as a
module). Just look for where it's defined in arch/sh. If it's in a
nommu-specific file it might need to be moved somewhere more
appropriate, or an mmu-ful variant may need to be written and placed
somewhere more appropriate.

> Backstory: I want to test nommu under qemu, and my existing tests are all using
> qemu-system-$TARGET builds with musl-libc toolchains built by musl-cross-make.
> 
> I have a nommu test environment on real (FPGA) hardware, using an sh2 fdpic
> toolchain built from musl-cross-make using gcc 9.4.0, but that's not part of my
> normal "cursor up and hit enter" fully automated regression testing that builds
> and launches qemu instances with a prepared filesystem that launches tests from
> the init script and does "expect" style processing on the serial console
> connected to qemu's stdin/stdout.
> 
> Testing on the FPGA board requires repeatedly removing and inserting sd cards,
> so I don't do it nearly as often, and right now that's my ONLY nommu test
> environment.
> 
> I want to get a qemu-system-something running nommu. Since musl-libc only
> supports fdpic, this limits my choices to the intersection of Linux's FDPIC support:

musl also supports non-fdpic ELF just fine on nommu, but it has to be
fully position independent (PIE) and of course does not get shareable
text. But this is usable for testing.

> $ grep FDPIC -m1 -A3 fs/Kconfig.binfmt
> config BINFMT_ELF_FDPIC
> 	bool "Kernel support for FDPIC ELF binaries"
> 	default y if !BINFMT_ELF
> 	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> 
> And gcc's FDPIC support:
> 
> $ dirname $(grep -irl fdpic gcc/config) | sort -u
> gcc/config/arm
> gcc/config/bfin
> gcc/config/frv
> gcc/config/sh
> 
> Ever since linux threw blackfin and frv overboard to lighten the load, this
> means gcc can produce fdpic output for exactly two targets that Linux supports:
> arm and superh. (No, riscv is not joining them. I emailed about
> https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/QnTEfur4BwAJ
> yesterday and was told "Sadly that project didn't go beyond the ABI design
> phase." so riscv-fdpic is _not_ currently in development.)
> 
> In theory arm can use the FDPIC loader on a with-mmu kernel, but the arm
> configure doesn't have a way to combine "musl" with the magic
> "uclinuxfdpiceabidoodahdoodah" blob because their matches keep looking like:
> "arm*-*-uclinuxfdpiceabi" and "*-linux-musl*" which aren't compatible. (If that
> first one didn't have the extra dash...) Alas arm-unknown-musl-uclinuxfdpiceabi
> makes binutils go "checking target system type... Invalid configuration
> `armv7m-linux-musl-uclinuxfdpiceabi': machine `armv7m-linux-musl' not recognized".
> 
> So I was thinking "maybe I can build an sh4 kernel with an sh4 compiler, and
> build a userspace with the sh2eb compiler" (this is unlikely to work because
> every sh4 system I've ever used is little endian and the j-core guys
> inexplicably chose big endian, but I can burn that bridge when I come to it...)
> But that's how I hit the "enabling FDPIC on with-mmu only works with arm,
> nothing else" issue above. And that's incompatible with selecting musl support.
> 
> Rob
> 
> PS. the sh2 fdpic toolchain in musl-cross-make doesn't reproduce with the newest
> "supported" gcc (11.2.0) because:
> 
> In file included from libstdc++-v3/libsupc++/eh_call.cc:32:
> libstdc++-v3/../libgcc/unwind-pe.h: In function 'const unsigned char*
> read_encoded_value_with_base(unsigned char, _Unwind_Ptr, const unsigned char*,
> _Unwind_Ptr*)':
> libstdc++-v3/../libgcc/unwind-pe.h:270:25: error: '_Unwind_gnu_Find_got' was not
> declared in this scope
>   270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);
> 
> Which has been broken ever since musl-cross-make's newest last commit almost 2
> years ago.

Could you file a bug report for this? I think it's actually a GCC
regression but I'm not sure, so there probably needs to be a report on
the GCC tracker.

Rich
