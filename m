Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792776786;
	b=mbfR28jOezHId/3RDypv5iNlItQreMvB8gwxfmq/VR7mFUBvfKYfNC6DEOYGbEPMQRoc
	 ntGHvPQouzmZOrxfr+xq0THNMIXY4TIkPsTK4FxumpT7zrjINUeDddjOLSTkUomodYmxY
	 B9e5UpFV5gjVquaPXoSQELgYBbtsyTxkY5JNijIh5It2mK8lkCYsnnEBnoVz3OcJYQMj1
	 X3dTQxMhZ3Um8XHDjOH20VARI/Q1+ozy1X81PCtUEEHkzasTSvENJ4T9xy8auT1WT3QiH
	 eTawXC+P3PIZOnI4PMxTRqObsHfwBc15v/I729/Zyw/UEwJSlL4nJs2eF7uCwBrGVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792776786;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=OwQuD11aowvN59Yp8GTn1jvcoj+Fq2ATG5T1g4tSa/0=;
	b=K7dsDUDIIdXTBKuq4hLIpxLw0/IPoi+AnYP2T02JfxKWYPPCGh6sBa0J2Tm8K91FEy6b
	 1IcwxQx1w5brZ16ikCQf+Y+Q/RgHCyisbX9pzmPoeFiJc7wlkealVTEUjuG3k8nJFHrAW
	 9AweDVN23BQrwTXtt6c0rwwTVTMMvVRS2Swk9YhSLcfMD9+kbcYHqOCWbArNRtAcu/QoB
	 9wkUPn7JFWGm/euj9ZWLrt2xV+gn4ltDl0VLD7ML4aX7gD1w0bq66kmhmVl8czqIS+XMS
	 TdHd4/VsDkUO07+QLuZVXgETwAjru/56KqH58B4N6CePhPaeZ9PJfUZSUXPnKRudw/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=Cm73qzHT;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9D606A31D;
	Fri, 23 Oct 2026 17:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=Cm73qzHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792776776;
	bh=vmPziPk2l4fvIsjWAFymEOIM1e+BT3WMm9SVEF/asOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cm73qzHTD4d5wdgAh74ZKXYQTuTlBSYQe4mvETKmBqVBbKXXnLHssCeVy3mFGX/7I
	 Em/AIQY33b+gNl1q3XpDF66OXtIahGj2VpBOBAnoptoKDILEp1dIKtSqH5rHC3WPGU
	 vI2MH0YNNn+TUTbj1F7Mp+saQbwztA91yzhx6ZDs=
Date: Fri, 23 Oct 2026 19:32:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org, 
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <5a82da39-1f60-41b6-9359-f08e6fefdb6d@t-8ch.de>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
 <atrsI4aaq9t4BVra@1wt.eu>
 <81607eb0-596c-4943-a8fe-d272fcd258c4@t-8ch.de>
 <atuJZwT7LIzceQ2c@1wt.eu>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atuJZwT7LIzceQ2c@1wt.eu>

On 2026-10-23 18:20:55+0200, Willy Tarreau wrote:
> On Fri, Oct 23, 2026 at 05:53:51PM +0200, Thomas Weißschuh wrote:
> > On 2026-10-23 07:09:55+0200, Willy Tarreau wrote:
> > (...)
> > > > > Replace bsr with a calculation of the effective address of
> > > > > _start_c and jsr.
> > > > > 
> > > > > Tested on QEMU and real SH4 and SH4a machines.
> > > > > 
> > > > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > > > ---
> > > > > 
> > > > > I'm no SuperH asm expert but this works for me. :)
> > > > > Maybe there is a way in C to get _start and _start_c to always
> > > > > be close together that would avoid this entirely?
> > > > 
> > > > That would be my preference, too.
> > > > 
> > > > Maybe one of these works:
> > > > 
> > > > 1) Put both _start() and _start_c() in a dedicated .text subsection.
> > > > 
> > > > Apparently the default GNU ld linkerscript contains '*(SORT(.text.sorted.*))'.
> > > > So if we use .text.sorted.nolibc_start for both functions they should
> > > > end up next to each other.
> > > > See https://sourceware.org/binutils/docs/ld/Input-Section-Wildcards.html.
> > > > 
> > > > 2) Put _start() *into* _start_c:
> > > > 
> > > > diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> > > > index 714256228914..ebcd0ea2b9f2 100644
> > > > --- a/tools/include/nolibc/crt.h
> > > > +++ b/tools/include/nolibc/crt.h
> > > > @@ -115,6 +115,19 @@ void _start_c(long *sp)
> > > >                 (*--dtor_func)();
> > > > 
> > > >         exit(exitcode);
> > > > +
> > > > +       __asm__ volatile (
> > > > +               ".global _start\n"           /* The C function will have a prologue,         */
> > > > +               ".type _start, @function\n"  /* corrupting "sp"                              */
> > > > +               ".weak _start\n"
> > > > +               "_start:\n"
> > > > +
> > > > +               "mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
> > > > +               "bsr _start_c\n"             /* transfer to c runtime                        */
> > > > +               "nop\n"                      /* delay slot                                   */
> > > > +
> > > > +               ".size _start, .-_start\n"
> > > > +       );
> > > >  }
> > > > 
> > > >  #endif /* NOLIBC_NO_RUNTIME */
> > > > 
> > > > But that for all architectures, using macros etc.
> > > > 
> > > > If the .text.sorted. solution works, I'd prefer that.
> > > 
> > > Do be honest, I think that Daniel's proposal remains the most maintainable
> > > one. We rarely touch the start code, and having only a few do arch-
> > > specific tricks is likely less of a burden for the long term than
> > > relying on linker's ordering of sections, or starting to play macro
> > > games. And it gets a chance that someone more familiar with that arch
> > > improves it later if needed. But I'm not opiniated on this at all :-)
> > 
> > I fear that we will have the same problems in other architectures.
> > And for those we'll also need custom assembly. While the mechanisms
> > above would not need that.
> 
> But all archs support indirect calls one way or another. Normally we
> should be able to do the equivalent of placing an absolute value in a
> storage area, load it in a register and branch to it at least.

Of course it is possible to do. But it differs between architectures and
somebody will have to write and maintain that assembly code.

> For me, sorted sections are most likely meant to be used to group code by
> locality, not to guarantee that branch offsets will always remain
> small enough for all architectures.

Exactly this locality should provide small enough branch offsets.
The section ".text.sorted.nolibc_crt" should only ever have two functions:
Our _start() and _start_c().
While there won't be a formal guarantee that the architecture's branch
offsets will be able to handle those, I find it hard to imagine that
they won't.

> An indirect call on the other hand is well defined, standard and can
> be adopted where needed at the cost of only 4 or 8 bytes in the
> startup code.

Its a few more bytes, not that it really matters.
* 3 additional instructions -> 6 bytes
* The embedded offset -> 4 bytes
* Up to 3 bytes of alignment

The adoption will require additional fiddling with assembly.

Maybe we let Daniel break the tie? :-)


Thomas
