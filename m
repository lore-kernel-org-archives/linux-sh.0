Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685557;
	b=CL2AqXWDffXNAp1pdUlTYKdZqMB0V6n+C25fYLYn/2ELMJvb5s2H10hIJS2tv/6Vmqrg
	 dtJxF05CXUod1bXn0WsW8u4lE719O1GXRktnSeQKGJBT3hPEorIGyuO870m2ARtudobwH
	 HFfbTusJggiCbA4E6O8zokz4r6iNZy0Bvc/z28vT0Vb9wepszCcN6bTnnQW43X/Pr2zbB
	 cXbUxU8zv3O3a1Jb5OUrj4BNQK4eLE3iu8FNcBo0c2PcyfQN/WoVYpDJRFQfP0ZJVKzeX
	 L4ilX82+4SGk1RiMf4uAjgl6txQjCbonv0HjNyUUvfcrVWYYxJjolfkItzhA26sGxJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685557;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HDnv1IJIP6oSjhDLM6LlHOM5+fMaByUs67f2+ZyjO6M=;
	b=naK7pFrh53LXhgqfe/tMl4GkH5YPoEGGLK644Hff3FM6BEOuBxRqmJUgWk1LIpnnC7Oq
	 iYtbWiLe3hJFcWA89Wfqfjs7/g2CTe99zOLrwBR41IDVP+EtcEXwDhi5/6qJHspoFRTY6
	 3Fea/OKBkG8Fo+bFBwWyNLYRXAroTj6LX7BKQmwgtGxG6DPG/HN4/eLsS52XZBXeXK1YE
	 WeWngZx+j0PG8KDt69xF6vdG/yD/FhJdu+et4X1JJyfZcJghDY/O5URWOOT+aq/1UzrgX
	 0SX1Iqw3BlVCYRUF8nlfGUEJh63MNwEmuSnBX4nvyH8loHW2NJw9AI3XgF8++dlSNQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=pNzbzt2D;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA0606A319;
	Thu, 22 Oct 2026 16:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CA0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=pNzbzt2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792685548;
	bh=atgxzKoRU5cB/A8AIB23NbE+SMIbC5Zx2XbwRgsiy0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNzbzt2DO6KXWQqyRNCIuCq+gPYyCJQw4G7ivwz51a1bG1oQ8lELCY5qwoeEkn9v0
	 dhHewMnZTdM6SmvzvKloc7Jyh+H/siH7tdHSgE5QZRqRZnuZf3x2kRTVF3D3vBBkNx
	 3vnlYi7QeSdrLtm/++nOFEL0MealwwH+lMGqeCWc=
Date: Thu, 22 Oct 2026 18:12:27 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Palmer <daniel@0x0f.com>
Cc: w@1wt.eu, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: sh: enter _start_c with jsr instead of bsr
Message-ID: <cd8fcccd-aa70-46f9-b497-ec3070b5f8db@t-8ch.de>
References: <20261022100159.525910-1-daniel@0x0f.com>
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
In-Reply-To: <20261022100159.525910-1-daniel@0x0f.com>

Hi Daniel!

On 2026-10-22 19:01:59+0900, Daniel Palmer wrote:
> bsr has limited displacement and cannot reach _start_c if its
> more than +/-4KiB away.
> 
> This starts to show up if you have big programs (static binary
> of the game Quake in my case) and/or use LTO and things get moved
> around.

That is certainly a usecase that justifies making the two other SH4
nolibc users' binaries a bit larger :-)

> Replace bsr with a calculation of the effective address of
> _start_c and jsr.
> 
> Tested on QEMU and real SH4 and SH4a machines.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
> 
> I'm no SuperH asm expert but this works for me. :)
> Maybe there is a way in C to get _start and _start_c to always
> be close together that would avoid this entirely?

That would be my preference, too.

Maybe one of these works:

1) Put both _start() and _start_c() in a dedicated .text subsection.

Apparently the default GNU ld linkerscript contains '*(SORT(.text.sorted.*))'.
So if we use .text.sorted.nolibc_start for both functions they should
end up next to each other.
See https://sourceware.org/binutils/docs/ld/Input-Section-Wildcards.html.

2) Put _start() *into* _start_c:

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 714256228914..ebcd0ea2b9f2 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -115,6 +115,19 @@ void _start_c(long *sp)
                (*--dtor_func)();

        exit(exitcode);
+
+       __asm__ volatile (
+               ".global _start\n"           /* The C function will have a prologue,         */
+               ".type _start, @function\n"  /* corrupting "sp"                              */
+               ".weak _start\n"
+               "_start:\n"
+
+               "mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
+               "bsr _start_c\n"             /* transfer to c runtime                        */
+               "nop\n"                      /* delay slot                                   */
+
+               ".size _start, .-_start\n"
+       );
 }

 #endif /* NOLIBC_NO_RUNTIME */

But that for all architectures, using macros etc.

If the .text.sorted. solution works, I'd prefer that.

>  tools/include/nolibc/arch-sh.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
> index 996cfbe1bee3..7318f52dcba9 100644
> --- a/tools/include/nolibc/arch-sh.h
> +++ b/tools/include/nolibc/arch-sh.h
> @@ -154,8 +154,13 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __nolibc_no_stack_prote
>  		"_start:\n"
>  
>  		"mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
> -		"bsr _start_c\n"             /* transfer to c runtime                        */
> +		"mova 1f, r0\n"              /* load the effective address of 1: into r0     */
> +		"mov.l @r0, r1\n"            /* load the distance to _start_c from 1:        */
> +		"add r0, r1\n"               /* calculate address of _start_c                */
> +		"jsr @r1\n"                  /* transfer to c runtime                        */
>  		"nop\n"                      /* delay slot                                   */
> +		".balign 4\n"
> +		"1: .long _start_c - 1b\n"   /* Distance from here to _start_c               */
>  
>  		".size _start, .-_start\n"
>  	);
> -- 
> 2.55.0
> 
