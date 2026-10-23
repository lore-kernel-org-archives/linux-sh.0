Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772465;
	b=5eK4UM9TE6/8RfU0XZRa71UPozYM4ok02B649R/pMzCieBHhO4fZ1HzPGm6N7+KTzl/N
	 rs1Pp/mefxyOddikRA/ZmykvAjT4Cgr3ZC3j4hTWDG9w2sZZzLpsWUlosI8EqL5eLQpCR
	 3RJLL7d2GXTIpW3RRueuvxfmnwEEWgdhIvi79zdCTx+gB+MrnZeI9TD7mJQ8g878Amdkm
	 lQ6VlTJM4qRG56dLgBPYqFc0yYvnw060OXtr66G6IWnKDAr9AnHRv5/Vcx5tuu8kFSspm
	 KM3gebSyGDzT1lGsPJz31lMgYHA8DCbrK8J0FvMIpwT3f6t4zuNjBkSw2hGdkabjatA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772465;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=lyLeZAF20jIp1lqB2FYqBLHVimbjVkZy3uUtpYqauec=;
	b=UI2ezhgjDNjsh8Iuoq2SoLlzQRgFktgUhwGbaKsG1uR0dVi0BHA6+dvKWaPlMHpmBtMK
	 TNbSwTToGctJR7plcMKtp/0qCE5pbfMg+5hbGNN1v1zDH8R0vnK676DNYaMb22BBYukcP
	 prkGMTLl10kgI/DAO61IfNeSZsWSeKQtdjqpai6p0KY3ZCqSSUA0zbOfHMZlw3LSOQzkM
	 3XOPQQ7e6ZPDa8JAKD0yPV557XylDejHIKPH1djZUjY3qgPc9ZjydmGk1+7I4Wy9lnMN7
	 pTRY56bs5L8VxIWxNIMNMARF0hcY6FTlwf7id1roXSWAhLSgX9vX/2qeWR66IgKKtWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=rTUPrbpU;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C2606A31A;
	Fri, 23 Oct 2026 16:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B46C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=rTUPrbpU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792772456; bh=lyLeZAF20jIp1lqB2FYqBLHVimbjVkZy3uUtpYqauec=;
	h=From:Message-ID:From;
	b=rTUPrbpUNIbT7N5M7A87YK2q3VBrsCSAIX5kHh2IypIyCZnf24G7XMY6bGdWFRRZX
	 Co8JQ7mlq+pI9wFrxRDgyEsicuOMq5iLEp/M9XXjb7Y+zNMNGs7RsCdUw+G5n+DdAk
	 o+a58MDxerJ/cPXRItRcBefLawsjOmgj0s9fr7nk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id F1A71C0943;
	Fri, 23 Oct 2026 18:20:55 +0200 (CEST)
Date: Fri, 23 Oct 2026 18:20:55 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <atuJZwT7LIzceQ2c@1wt.eu>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu>
 <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>

On Fri, Oct 23, 2026 at 05:53:51PM +0200, Thomas Weißschuh wrote:
> On 2026-10-23 07:09:55+0200, Willy Tarreau wrote:
> (...)
> > > > Replace bsr with a calculation of the effective address of
> > > > _start_c and jsr.
> > > > 
> > > > Tested on QEMU and real SH4 and SH4a machines.
> > > > 
> > > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > > ---
> > > > 
> > > > I'm no SuperH asm expert but this works for me. :)
> > > > Maybe there is a way in C to get _start and _start_c to always
> > > > be close together that would avoid this entirely?
> > > 
> > > That would be my preference, too.
> > > 
> > > Maybe one of these works:
> > > 
> > > 1) Put both _start() and _start_c() in a dedicated .text subsection.
> > > 
> > > Apparently the default GNU ld linkerscript contains '*(SORT(.text.sorted.*))'.
> > > So if we use .text.sorted.nolibc_start for both functions they should
> > > end up next to each other.
> > > See https://sourceware.org/binutils/docs/ld/Input-Section-Wildcards.html.
> > > 
> > > 2) Put _start() *into* _start_c:
> > > 
> > > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > > index 714256228914..ebcd0ea2b9f2 100644
> > > --- a/tools/include/nolibc/crt.h
> > > +++ b/tools/include/nolibc/crt.h
> > > @@ -115,6 +115,19 @@ void _start_c(long *sp)
> > >                 (*--dtor_func)();
> > > 
> > >         exit(exitcode);
> > > +
> > > +       __asm__ volatile (
> > > +               ".global _start\n"           /* The C function will have a prologue,         */
> > > +               ".type _start, @function\n"  /* corrupting "sp"                              */
> > > +               ".weak _start\n"
> > > +               "_start:\n"
> > > +
> > > +               "mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
> > > +               "bsr _start_c\n"             /* transfer to c runtime                        */
> > > +               "nop\n"                      /* delay slot                                   */
> > > +
> > > +               ".size _start, .-_start\n"
> > > +       );
> > >  }
> > > 
> > >  #endif /* NOLIBC_NO_RUNTIME */
> > > 
> > > But that for all architectures, using macros etc.
> > > 
> > > If the .text.sorted. solution works, I'd prefer that.
> > 
> > Do be honest, I think that Daniel's proposal remains the most maintainable
> > one. We rarely touch the start code, and having only a few do arch-
> > specific tricks is likely less of a burden for the long term than
> > relying on linker's ordering of sections, or starting to play macro
> > games. And it gets a chance that someone more familiar with that arch
> > improves it later if needed. But I'm not opiniated on this at all :-)
> 
> I fear that we will have the same problems in other architectures.
> And for those we'll also need custom assembly. While the mechanisms
> above would not need that.

But all archs support indirect calls one way or another. Normally we
should be able to do the equivalent of placing an absolute value in a
storage area, load it in a register and branch to it at least. For me,
sorted sections are most likely meant to be used to group code by
locality, not to guarantee that branch offsets will always remain
small enough for all architectures. An indirect call on the other
hand is well defined, standard and can be adopted where needed at the
cost of only 4 or 8 bytes in the startup code.

Willy
