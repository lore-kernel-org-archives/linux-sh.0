Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A214812;
	Mon, 28 Sep 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602857; cv=none; b=LKcW+qHxb6VF7Ez9P0V4M4GyEp1HCpD4pItiaXqxlp4yQCbdHNm+UOWTLi4ssL69ThkWWBLbPUVwPuFIKKGnuvqUmZP7iPCLCJ5+xxKlvNGu21hCb0HLZg74L9n2iH8OySirbiI8WIf1x0cNTyY5sfbRmcWKiBUTKfTu/oWDm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602857; c=relaxed/simple;
	bh=AyEQUNFzGVG3v1QC2gd/Jejdh/wwpRbMgUUXybHlNAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0yiruILW7+efij9tlb9Ts40qqNSPQ938D35vJUq2KcQ51tro12rHIPGcow4Oojw4YCbq5xkEbZC5hs9e3JnKI3w6cz+446SiYLc2XaZfYz84zMr84Meq35682U88DYo1DhPWpaHpCmAJtcpz+taKwa5KPyJSSKc6jZpvTWPSGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CRxEqUGW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CRxEqUGW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ubVjlN3WVXmRTCS3GorW+ViEnBshXa04RKr4r58KOUw=; t=1790602855;
	x=1791207655; b=CRxEqUGWnAa4HOOKo0wi8MIAzUXgGlOoe4Bt7qWTzbYO/qqYB5lVyGsOoHq0F
	nIdSoHIEgxi7QzsIX+V0gIciDBnQsWcBloPae4nJAKOhONAyVdJnylnB6ZUI9Z9fH0dfJfpb/712Q
	qSxmvevPUpjTdNgWO5M+H0Fs1I4Z56NYn2ZwL9azN7dGrEZsFsFYVr3dRyCVCLdZqbpBmBSmM6uyr
	9j1mId3jxMx8Zq4Y5l8mAhPFpH1EWkMq9/swnjPQkFA5fQHzS3qRSBRtiSJyd8bdCpOM9OH3y2xUc
	A9nYmYeQId56bt6D/DCl1Y13jrvOEEYVzHptE6vttsZtcNSrww==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBBbA-0000000073n-1jYz; Mon, 28 Sep 2026 15:40:52 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBBbA-000000020Fb-0ld7; Mon, 28 Sep 2026 15:40:52 +0200
Message-ID: <78fd8ec13658259036e32f36814270a242e5eca6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>, Radu
 Rendec <radu@rendec.net>, Artur Rojek <contact@artur-rojek.eu>, Rich Felker
 <dalias@libc.org>, 	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 15:40:51 +0200
In-Reply-To: <aroDuGZBLsAw7tMS@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
	 <92e110eef6dac0c6ddceb6ddda1658aeeaf1f0ec.camel@physik.fu-berlin.de>
	 <aroDuGZBLsAw7tMS@gmail.com>
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

Hi Karl,

On Mon, 2026-09-28 at 08:07 +0200, Karl Mehltretter wrote:
> On Mon, Sep 28, 2026 at 07:57:27AM +0100, John Paul Adrian Glaubitz wrote=
:
> > Can you tell me what toolchain you used to build the kernel for J2?
> >=20
> > Last time I tried to use the one provided by Rob Landley, the build
> > failed due to an internal compiler error so I couldn't actually build
> > a kernel to test it on my J2 Turtleboard.
> >=20
>=20
> Hi Adrian,
>=20
> musl.cc's sh2eb-linux-muslfdpic toolchain (GCC 11.2.1, binutils 2.37):
>=20
>   https://musl.cc/sh2eb-linux-muslfdpic-cross.tgz
>=20
> Your ICE is probably the one in kernel/nstree.c. Since listns() went in
> (v6.19), every GCC I tried ICEs there with j2_defconfig. The 64-bit
> put_user() asm prints %T (address + 4) of an "m" operand, and GCC can
> pick an indexed address that cannot be offset. The asm needs "o".
> GCC should still error out instead of crashing, so I filed a GCC bug
> too:
>=20
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D127639
>=20
> Fix below, formal patch follows. With it, j2_defconfig with SMP=3Dy
> builds fine with the musl.cc toolchain.
>=20
> Would be great if you could test on your Turtleboard!
>=20
> Karl
>=20
> -- >8 --
> diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uacce=
ss_32.h
> index 5d7ddc092afd7..879d262489219 100644
> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -92,7 +92,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	: "o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>  #else
>  #define __get_user_u64(x, addr, err) \
>  ({ \
> @@ -116,7 +116,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	: "o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
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

That patch indeed fixes the build issue and the ICE and I can finally
build a kernel image using Toybox for my J2 board again. Let me see
if the kernel also boots.

Unless your patch is identical to Florian's, you can post yours later.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
