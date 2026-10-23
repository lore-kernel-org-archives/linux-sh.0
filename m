Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770835;
	b=tA34OenMyAZt1HGz3xgOgtDJFYtdEqx/xKx4h8PhL4ALhu3CqZMK6nzXybjlVPZ9X3Lk
	 n6jZzjvkUSron+u7aITjjFCguhgZECjxm641o/82p5T7kRKW+w8rksKzRgC5UFyMU/tf3
	 ZSxrv4CqW2vslsoKD7jeLAHt3dbzliLE8uxKJG2NhPPSpSKP6/kvSBNquncNNx5pBei5Q
	 v49wGJMS8joy8DKl+VltYLay68Kg6Iv6NvlFIcCHyX6bwJnbMWji3HTU5ozOhcCSBOgND
	 jKSNXFX9VCQtopoCq+S2RSkM6YV/Hbyvx0rBFHAyRQb7JcvbQgGlh6tzrQiyaJ0zo8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770835;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dMxwYbSvRsHTfk7bLz8g6fZdxZRm9492hnH1upXb7MA=;
	b=vFlzp/sLJ96ewnEWh/7j0YdEVEFbsGIuV6MkpWH8nqibySRa89A+Z/Y+DvWyizXROhFr
	 EXD4jcTPMWhlEK+RIfD+oMvBRHY1GS4WHCNjE0unGOyUjW2SwPzpcd8PmmwfTQGysu8wo
	 J/kbirmXnXY3hBbJU1B4cUSV6ieCxxnsNMot0KhkMNfQmiwnqw/3vVUeB3cPn6d9goHyc
	 OivEyEJlFF6inIlqXaAPxHBNkzezs7byYkfOfyhPDwuTq3Q+JhZymsez1BjcDBes82fcC
	 co7udQBDGbgfcYr5x9CSSeRrS06PxWbfYyp5IJMxl4gtCVNGu01tOnKFU9K5yNw+5EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=sJPEdQ37;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E569606A31A;
	Fri, 23 Oct 2026 15:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E569606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=sJPEdQ37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792770832;
	bh=1SpE5EQehZFMiwtffVjidJtlUu0cnm5tYlpd9u0cBtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJPEdQ37JEz8sagQ+NHe9DdUZvVeE3K3x/yz3cKS76CqmPz0U0+Dj6wiczj3PaDft
	 liGLszJxrLd9HCAWbH3SLGolehY37Sj19SRfgRCs+IV3dp0G/mJfzqaR8cb6BvPgWa
	 Wrsf0Uo4emESm3hGBbJUhIb02V8gX+8AqMyk354s=
Date: Fri, 23 Oct 2026 17:53:51 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atrsI4aaq9t4BVra@1wt.eu>

On 2026-10-23 07:09:55+0200, Willy Tarreau wrote:
(...)
> > > Replace bsr with a calculation of the effective address of
> > > _start_c and jsr.
> > > 
> > > Tested on QEMU and real SH4 and SH4a machines.
> > > 
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > ---
> > > 
> > > I'm no SuperH asm expert but this works for me. :)
> > > Maybe there is a way in C to get _start and _start_c to always
> > > be close together that would avoid this entirely?
> > 
> > That would be my preference, too.
> > 
> > Maybe one of these works:
> > 
> > 1) Put both _start() and _start_c() in a dedicated .text subsection.
> > 
> > Apparently the default GNU ld linkerscript contains '*(SORT(.text.sorted.*))'.
> > So if we use .text.sorted.nolibc_start for both functions they should
> > end up next to each other.
> > See https://sourceware.org/binutils/docs/ld/Input-Section-Wildcards.html.
> > 
> > 2) Put _start() *into* _start_c:
> > 
> > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > index 714256228914..ebcd0ea2b9f2 100644
> > --- a/tools/include/nolibc/crt.h
> > +++ b/tools/include/nolibc/crt.h
> > @@ -115,6 +115,19 @@ void _start_c(long *sp)
> >                 (*--dtor_func)();
> > 
> >         exit(exitcode);
> > +
> > +       __asm__ volatile (
> > +               ".global _start\n"           /* The C function will have a prologue,         */
> > +               ".type _start, @function\n"  /* corrupting "sp"                              */
> > +               ".weak _start\n"
> > +               "_start:\n"
> > +
> > +               "mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
> > +               "bsr _start_c\n"             /* transfer to c runtime                        */
> > +               "nop\n"                      /* delay slot                                   */
> > +
> > +               ".size _start, .-_start\n"
> > +       );
> >  }
> > 
> >  #endif /* NOLIBC_NO_RUNTIME */
> > 
> > But that for all architectures, using macros etc.
> > 
> > If the .text.sorted. solution works, I'd prefer that.
> 
> Do be honest, I think that Daniel's proposal remains the most maintainable
> one. We rarely touch the start code, and having only a few do arch-
> specific tricks is likely less of a burden for the long term than
> relying on linker's ordering of sections, or starting to play macro
> games. And it gets a chance that someone more familiar with that arch
> improves it later if needed. But I'm not opiniated on this at all :-)

I fear that we will have the same problems in other architectures.
And for those we'll also need custom assembly. While the mechanisms
above would not need that.

The sorted linker sections should be stable. They have been introduced
as an explicit feature by GNU ld. They are fairly new (2019), but they
should fall back to non-sorted linking just fine for older linkers.
