Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BF2367B8;
	Tue,  6 Oct 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265123; cv=none; b=WTyRaFLJOPL0fs9oNoVHlVLsWuYNxAR74MU9jjjBFdogxs1fIjopZEVjD9R1Bhf/gNIe14RlVJs69yaCbGnfPoNKb3F0+CKsi5WTxWaz5tWVZMoTU448nb3nYOwPard+vhU/XW0HtDfBbfrq9Lx0MLLvL79I84Br0T8pLEZ/RyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265123; c=relaxed/simple;
	bh=d5p5nYYzp9s2zUicZrZ4QerTKE+wYWUicQnOWFwaVqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SiGm5NwQp81aH0mDQ1p2z37aRP9v6v7dHTfiLnQEkFzu4rPVP6yJSp/jXTb673pUmMGWG5OJ5BTfaYwVlM093/WacYUOB/2ZAGe74Cc6c+BgLWEhRxpv3h5yHc8Cmg1V/c88PSENjpN3tGY7qfKNzYvZR8h/m14sATI4cWZp3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FxlY9PtB; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FxlY9PtB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=vSzaOjcWYT0JmIfRI9nKaWn14Ci4flbLqG7QCnYzMx4=; t=1791265120;
	x=1791869920; b=FxlY9PtBbB1qRPW1bJGZM3rGUGxJWwbtQb17n+qgf+PU5nfsDW5AhsVonbJ4p
	9W/P6VpZw1wPxMA7CVyxE/Fj3dyv95Wx69d9SqOSb+RNzn92t/X04mGBYTDk2oLEPvxPJAjYvSGC+
	VPryN4v7QIhuRq1UHnIZt3QhAeh6s2g73bTXrku5IwAN4kRMEM98H9lh8ldkhxqaLTAWceYT0i/4M
	7YSCLM+tYhs7kIym/xhSGPXkJdTkTkZ9Of5dGrZloKTXM+ArmXtf1avFAk78/eILBP3yMQrfHUSfV
	rh1PwqIceeOWXueivM9ZELX+HNfNnZhNn270ZT1v7JBk3K4shw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xDxss-000000005U9-2zKX; Tue, 06 Oct 2026 07:38:38 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xDxss-00000002upe-26nb; Tue, 06 Oct 2026 07:38:38 +0200
Message-ID: <addfdf7bdf5c01706c2859b8f73fa666b00d7032.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: uaccess: Require offsettable operands for 64-bit
 user access
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 06 Oct 2026 07:38:37 +0200
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

Merged into for-next for v7.4.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
