Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42742D74D;
	Thu, 16 Jul 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221517; cv=none; b=iA1OVMNabSfKTWZcpN7VBh7uLdc5KCTGHbneX/E8zR0DJHTN5ge4JVkoba82cKOCVpw1y95EoM5bL4f19j2irkjhLDxd9RQkBTexfhxRdVfQngDe8E2BMv6Ns5HgswU3bQp3EGMW/8sht1AX2SoENRpwT9ZDK9UjlvDZnfSqaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221517; c=relaxed/simple;
	bh=EMZSHhUc+YunHSTZZcowO/4q90CmY0vTHxDeMpviXEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/YHQc3r56zmsylh0zon/lcXUa5GqGU7y7C4u+yQKbCKZCSAgPbz7USFkGgiQejOyyKfPSYuHvnV2C+6NfuBr3aIK/rsPSX2t+7YIR2X1B+7b2FtV00catM230WjIZnXl5JLdbg6KbJx5V4CQW0RUmMoogxLl2ekmiEKQ6b2bi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=h0DgAXrF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="h0DgAXrF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G8gFY350Tuhiq3xDoixGEqr0Bd8U2Cik1qGMaPjrd94=; t=1784221512;
	x=1784826312; b=h0DgAXrF1XIpgrQMjyJ7NQJcdzNxnSk26V/JPxLp4W20G3xRLzgaTdGQhQW6L
	VPrAd2CAJm6lkG1YTIi77ZLzYm8H8U1EeOIlnRwP89Otkg8b602XxrNxoSZ3CgwTUP5zvl24faTVd
	nLzNWn2p0PkP4dE3CaW9XeEh+9e6ZcUKDdOQovOtBVBw0irVs1xcJyuVOOCycKESHLOWJxXqV9mor
	h2YD5h0bVM/5k1EiPojcXXyMIiujrIEhoODnWP02bsfPntolIITKNIgZeDC+bPPeXwndZYXMaTm1a
	EQBv8Nn8Cj0yq39/FMtpkYEWBXDD9xI/Ty1q4W1hi5EqfLBhWg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wkPWC-000000043N1-1X6R; Thu, 16 Jul 2026 19:05:04 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wkPWC-00000000Eep-0SiY; Thu, 16 Jul 2026 19:05:04 +0200
Message-ID: <c4177b44450a909ae8dad60da39523f14b5f2005.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: uaccess: Require offsettable operands for 64-bit
 user access
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 16 Jul 2026 19:05:03 +0200
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

Nice catch, thanks a lot for fixing this!

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
