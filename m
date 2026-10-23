Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.59.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732199;
	b=KhUMzJN0L44rQ2j6n9ihKCYATFE6/nLVQq3Lai/tCUE4BTcRT/rjrttgepgtM3/uOdy4
	 SU/bw65zdk8RQcRyLXDtpdFBHQ5ohMEGPWYU3F8he2M+7ktDhEfmaZ9lfSsLpOQ6yBYG2
	 +wwwz+GItziG7zcqumNLCGsrgvbW8VJMGm7MNj5tBSRwS0sznE2haPAXVt30V/TYCmu79
	 9p5V98X8+m2kTPeBFYnS+11OEIMAAAlSQKqQacozWNmawxIdrqOvonlAss86Yd5kKB0Fx
	 89eIo2kb4RcYuOKbU9BhlZHfkXuVXgEmBGu5vcAwyNnu13H7ZVpmgKHMwIfSa9pJ2KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732199;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=C8NxeL0gcEEIMqlUlw2aZTEmQq+FvYVszdFw30Ir44Q=;
	b=sjhYflp2X1VtpUhBQ6jT1mCSb4QzNSZ/G1gLM0INH7mz3mnaN2JbzCI1jnKhkIblTxcg
	 1wm/Q/hP/izunZ/knXPcnehnU4B/WWFBtW6WrbebYBLplwCZtAct/YDOFEbupL6nUUSNI
	 Ffq9c4lw9lpXTbSUW/fdVBAMw6st7LBCO5pnSbXrjufMS3kl4TpN2hbwjlzJDp//UW7TP
	 nn5koUyJhgiYS6j9p58iDW6cu+r8h/MpYnNeH5bLpwhSsJ3GKdLokAJreJH2/Tp9nlibE
	 KZW+QFY8h3V9mamTfTGhKQfCmiChuO7pOvGENDNsRZexcZ2+2IE5NcExA+mdkyaybgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1wt.eu;
	spf=pass smtp.mailfrom=1wt.eu;
	dkim=pass header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ZX1BzRwc;
	arc=none smtp.remote-ip=51.159.59.229
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA6606A31A;
	Fri, 23 Oct 2026 05:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=1wt.eu header.i=@1wt.eu header.a=rsa-sha256 header.s=mail header.b=ZX1BzRwc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1792732196; bh=C8NxeL0gcEEIMqlUlw2aZTEmQq+FvYVszdFw30Ir44Q=;
	h=From:Message-ID:From;
	b=ZX1BzRwcMw5PSNbkTv57b2HR01excLveEXE29LY9tKt0lbGNjF6a0vHXB9a7PzeGC
	 +hehxVJ8nai1IeWtT1SX+bGOcJHVyQiMLiYQb5Tscc0faOlsH5G0jDPryxi+/g6U2T
	 eEVmgw8W3dw1HtWdV6Kh+K57Z2jTQqyd99BC7QhM=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 11018C0943;
	Fri, 23 Oct 2026 07:09:56 +0200 (CEST)
Date: Fri, 23 Oct 2026 07:09:55 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Daniel Palmer <daniel@0x0f.com>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <atrsI4aaq9t4BVra@1wt.eu>
References: <20261022100159.525910-1-daniel@0x0f.com>
 <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
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
In-Reply-To: <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>

Hi guys,

On Thu, Oct 22, 2026 at 06:12:27PM +0200, Thomas Weißschuh wrote:
> Hi Daniel!
> 
> On 2026-10-22 19:01:59+0900, Daniel Palmer wrote:
> > bsr has limited displacement and cannot reach _start_c if its
> > more than +/-4KiB away.
> > 
> > This starts to show up if you have big programs (static binary
> > of the game Quake in my case) and/or use LTO and things get moved
> > around.
> 
> That is certainly a usecase that justifies making the two other SH4
> nolibc users' binaries a bit larger :-)

Indeed!

> > Replace bsr with a calculation of the effective address of
> > _start_c and jsr.
> > 
> > Tested on QEMU and real SH4 and SH4a machines.
> > 
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > ---
> > 
> > I'm no SuperH asm expert but this works for me. :)
> > Maybe there is a way in C to get _start and _start_c to always
> > be close together that would avoid this entirely?
> 
> That would be my preference, too.
> 
> Maybe one of these works:
> 
> 1) Put both _start() and _start_c() in a dedicated .text subsection.
> 
> Apparently the default GNU ld linkerscript contains '*(SORT(.text.sorted.*))'.
> So if we use .text.sorted.nolibc_start for both functions they should
> end up next to each other.
> See https://sourceware.org/binutils/docs/ld/Input-Section-Wildcards.html.
> 
> 2) Put _start() *into* _start_c:
> 
> diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
> index 714256228914..ebcd0ea2b9f2 100644
> --- a/tools/include/nolibc/crt.h
> +++ b/tools/include/nolibc/crt.h
> @@ -115,6 +115,19 @@ void _start_c(long *sp)
>                 (*--dtor_func)();
> 
>         exit(exitcode);
> +
> +       __asm__ volatile (
> +               ".global _start\n"           /* The C function will have a prologue,         */
> +               ".type _start, @function\n"  /* corrupting "sp"                              */
> +               ".weak _start\n"
> +               "_start:\n"
> +
> +               "mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
> +               "bsr _start_c\n"             /* transfer to c runtime                        */
> +               "nop\n"                      /* delay slot                                   */
> +
> +               ".size _start, .-_start\n"
> +       );
>  }
> 
>  #endif /* NOLIBC_NO_RUNTIME */
> 
> But that for all architectures, using macros etc.
> 
> If the .text.sorted. solution works, I'd prefer that.

Do be honest, I think that Daniel's proposal remains the most maintainable
one. We rarely touch the start code, and having only a few do arch-
specific tricks is likely less of a burden for the long term than
relying on linker's ordering of sections, or starting to play macro
games. And it gets a chance that someone more familiar with that arch
improves it later if needed. But I'm not opiniated on this at all :-)

Thanks,
Willy
