Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3533537E8;
	Sat,  3 Oct 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018463; cv=none; b=VYbQQSMvjsFo3oU08PE8QI6WvpV5Dv11xLw0UNSRPCrWpbSW7hKK3+x6tTetT0VeBHGBMdh7xI/WlPaQnFR3/yFEvsUu1pQGpGK4jz2ZPOS4YlUtP31l1i0Y9/CXlDuHptEvfSUVJys96PidYC1R6XK/P7WrfpxX//02gSLqmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018463; c=relaxed/simple;
	bh=0gt1fSVZJX4fT+NtPy1lEeMRbuhISpMDqbuv+NmWtBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUp97aTffDk4GeOlcTu2NnNpILMgRfQB2+aHv9ZIbfpnj35EEN02BUqumwG6oHXRNo1RTcIxrbqVwkoFjcl2nMypqTSN5BcV86zgRA8sld9LOeBz+/kbI0qD2VMj++H/3N3iXTfyQ1jztnrThCfz7hI835xxfjP8wa/0f4/juio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=aTG1o/fR; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="aTG1o/fR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Tq7MU4FnyIT9ma2gavTUT1bkJ52908qcG46UwJNCvjs=; t=1791018460;
	x=1791623260; b=aTG1o/fRv9hwZz1Wpw+FiDIiPc8aJRK3sgZlHWmfvRX89ms5q0nJmZ8rhROYc
	cl7vcXqfav/92YhXyF7Bpwh8VZ2ZPDfXEiEFn8Gy6cESgSayO2ZpRhsnp0wA+/jtjG7i8LfLFhbdV
	JKnQCXXuAZmDBIlPg2i6OPBiPJGNvsWp7wKNUgjcPbWMMqrBSH4Ic8H/2cqy8YQ5tBsDzJRHNStA7
	4bWdd9lvkVxKaBXRXaq7MKfGagxSi9DzNStCqHMMI+fyEEOIFWB1XKjZm1OlzBwGPiH0kYtR6Eawn
	p/3m8CN/xn7E6JOHP+HHYmt8B3EEKEkQ7t6mLu1OCw4HBUFD/Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCviU-000000037Qs-1IZK; Sat, 03 Oct 2026 11:07:38 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCviT-00000002Y7H-4An0; Sat, 03 Oct 2026 11:07:38 +0200
Message-ID: <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 11:07:37 +0200
In-Reply-To: <20261003082833.21511-1-kmehltretter@gmail.com>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
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

On Sat, 2026-10-03 at 10:28 +0200, Karl Mehltretter wrote:
> The R2025S/D board information is registered on I2C bus 0. Commit
> 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictly
> specified") changed the PCA9564 platform driver to pass negative platform
> device IDs to the I2C core. The SH7785LCR device uses ID -1, so the core
> assigns it a dynamic bus number. Reserving bus 0 for the board informatio=
n
> makes i2c-1 the first dynamic bus, and the RTC is never instantiated.
>=20
> Set the platform device ID to 0 so the adapter is registered as i2c-0 and
> the RTC board information matches it.
>=20
> Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't exp=
lictly specified")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Tested with 29-bit and 32-bit kernels on a custom QEMU model of the
> SH7785LCR. Both registered the controller as i2c-0 and the R2025S/D as
> rtc0.
> Testing on real hardware is welcome.
>=20
>  arch/sh/boards/board-sh7785lcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh77=
85lcr.c
> index 25c4968f0d8b..b93423df582f 100644
> --- a/arch/sh/boards/board-sh7785lcr.c
> +++ b/arch/sh/boards/board-sh7785lcr.c
> @@ -256,7 +256,7 @@ static struct i2c_pca9564_pf_platform_data i2c_platfo=
rm_data =3D {
> =20
>  static struct platform_device i2c_device =3D {
>  	.name		=3D "i2c-pca-platform",
> -	.id		=3D -1,
> +	.id		=3D 0,
>  	.dev		=3D {
>  		.platform_data	=3D &i2c_platform_data,
>  	},

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
