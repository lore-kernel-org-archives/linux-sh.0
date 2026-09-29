Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751D517BDF;
	Tue, 29 Sep 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682535; cv=none; b=B6rAXoLYR+3hGfQ+iGbdwB9oYhMdP0OL583T2U4Mp1qH9Mwb+i4zo49j9FNt1fbBXbZRVuersr5v0mxD/bIA0nfYhq4kwcrLl+5rOc286XBGEYLdQ6sYVWkuwDcWQbai0cIcCbpKYEJwX2dgMMJ90HRzM9MPtEP9g9OGNg2N1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682535; c=relaxed/simple;
	bh=n0dF8zOddsST9wnNuwpu27rajyV0FrgfgPKmpjFwDHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5nRcS2KGj0OrWXxQDtdBWrwi3lp4JejmhSP7K8mQApY48xUAnXQ8Y4JJThVNk2S+Z+bY9ROztu6ut8XWCz7Vo5GS5JpBiuKvghdSk0JN/04oFkF/nBz5qjxjHsoK3M4gKonVZ9cqx5BkcvQnNmH2H04AyMhH80d+vBV0B48tQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eIKXjp+X; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eIKXjp+X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=De3y5TNZxx3DE47NDKXzPPx5OwqzIwsKNhJ19JUUHlo=; t=1790682532;
	x=1791287332; b=eIKXjp+XDwehUnNxdIMfQ4r6cHwjRFg5XgNdFZuErrvjm1qdUa6LVgSrFHrAE
	35md8yVBVAdpKYnNStHBot1Wa+gsc9Gu5VOpRIhsajWeiYthBFK9OzkJUMpKNS+kolVuCUJpFbX5B
	xuj9d3aqm9hco5YFbz8wumEtXG29+g+Rap4R5Xukvjj1MxPQqU6ZqZAdAPJFzCY95K5bns/xWpVha
	YezAro6mrnKJbI+2L9m1Bb4PeXcVdHQbjCCNmIb/n3h8q1v0VleqoybXVO70mc98ol9buFqlAUS/N
	YT3byfyKcWpj0wb5g3IlMHDvXkp6llOvPjoc9w9kEgwPQcQzhQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBWKI-00000001HVa-1zUP; Tue, 29 Sep 2026 13:48:50 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBWKI-00000002TeY-10ML; Tue, 29 Sep 2026 13:48:50 +0200
Message-ID: <d8dd8c56c09e00b85cc3ba379c99a2b52c77c5ec.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: uaccess: Require offsettable operands for 64-bit
 user access
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 13:48:49 +0200
In-Reply-To: <20260716165329.3418962-1-fuchsfl@gmail.com>
References: <20260716165329.3418962-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Thu, 2026-07-16 at 18:53 +0200, Florian Fuchs wrote:
> The 64-bit __get_user_u64()/__put_user_u64() paths address the memory
> operand as %T2 (base+4). This base+4 requires an offsettable address,
> but "m" also allows the indexed mode @(R0,Rn) (e.g. for a variable-
> indexed array element), which has no displacement field for the +4.
> Depending on optimization this build fails with "invalid 'asm'" or an
> ICE in GCC's change_address_1.
>=20
> Require an offsettable memory operand, allowing GCC to reload an
> unsuitable indexed address into an appropriate form.
>=20
> Fixes: 2d2b308a8b7d ("sh: Implement __get_user_u64() required for 64-bit =
get_user()")
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> The patch was verified on the J2 core on the Mimas v2 board. And booted
> on the Dreamcast SH4. checkpatch doesn't like the missing whitespaces
> around : I preferred not to touch the other unrelated lines, so I kept
> the local style.
>=20
> The original GCC ICE, without this patch can be seen here:
> https://lore.kernel.org/linux-sh/ef22a5de-d945-4080-9f4a-f5a1ab9de1dc@lan=
dley.net/
>=20
>  arch/sh/include/asm/uaccess_32.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uacce=
ss_32.h
> index 5d7ddc092afd..cef40414bfb1 100644
> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -92,7 +92,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>  #else
>  #define __get_user_u64(x, addr, err) \
>  ({ \
> @@ -116,7 +116,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>  #endif
> =20
>  #define __put_user_size(x,ptr,size,retval)		\
> @@ -196,7 +196,7 @@ __asm__ __volatile__( \
>  	".long	1b, 3b\n\t" \
>  	".previous" \
>  	: "=3Dr" (retval) \
> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>          : "memory"); })
>  #else
>  #define __put_user_u64(val,addr,retval) \
> @@ -218,7 +218,7 @@ __asm__ __volatile__( \
>  	".long	1b, 3b\n\t" \
>  	".previous" \
>  	: "=3Dr" (retval) \
> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>          : "memory"); })
>  #endif
> =20

I have now also tested the patch and I can confirm that it unbreaks the J2
kernel build for me and GCC no longer fails with an internal compiler error=
.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
