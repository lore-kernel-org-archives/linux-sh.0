Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324243D7D77;
	Sat,  3 Oct 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020329; cv=none; b=SqqMheMIkHwdM1AWS3Yab61L62Uiw6SrvfoHza4gXlMImCK6rMiGocCljQlVuIZWHOMeZO9UND3wZ3eeECvD+DtwX35RSrjX2djRoEgKFCyqKm5Bl3X13AzblAd6gfh/Tet3jXZ4uVJ+csyCVdqXGwIjJSXtcgmZLqUSZyY8RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020329; c=relaxed/simple;
	bh=RkG9oefzrWW3XEDuNicpYBVsDXmYsVnZX4edx7Y4vrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ki3xerREY2t8HSbGa7ZKFEHLE5i7MdfcW1cMCWz6+dCpmOgiCljZWXsHKI7CB8sVzWiavuGq1j+tB3WY3auaOXpU9dzXsVHeBYM0XeIQ1D/pEBnJJhaMBEPI69J2clsGUt5hstqaE9HEoKBuxXV5bl3atftppk7KtHwN7In/xkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oF7EqNcM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oF7EqNcM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=JintpsPHd20DDEfqoyj3VVZW6KvS9UZHZ6NMUTmUqu8=; t=1791020327;
	x=1791625127; b=oF7EqNcMe+Z+ozDTUPlZ9mrBuuTfyON6BmcKbXJ93gmGzVgZM4SSqN1e4vRhD
	w0mTYrbMLDLVuNdOOrKg8sXvvTxCfNwjwazv/0XdvN8wweEEOdvSOHMKkDvfgLBMNZBzmVMcrQhVG
	fONN3Y8uCGoPe3Ytz4L6yO2i361GDOWD5/HMbneftEdYYvtDd4RvW1baD0+F/Zzkwrr0VJBX30V0s
	o4d0vgpXbrzOdrJIEapYayrHnJG0aKc9OdSdC9aa6IppetTGTv43Rwm5SXzTCKtBbZ3rpx0ALQr+o
	UL2LAJl3B7JT4q2Ho7i6A3MPKHnTNbsSKP9ZH/kIbTMz1JPInA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCwCa-00000003C5N-36qd; Sat, 03 Oct 2026 11:38:44 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCwCa-00000002hOU-2CvY; Sat, 03 Oct 2026 11:38:44 +0200
Message-ID: <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 11:38:43 +0200
In-Reply-To: <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
	 <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
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

On Sat, 2026-10-03 at 11:07 +0200, John Paul Adrian Glaubitz wrote:
> On Sat, 2026-10-03 at 10:28 +0200, Karl Mehltretter wrote:
> > The R2025S/D board information is registered on I2C bus 0. Commit
> > 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't explictl=
y
> > specified") changed the PCA9564 platform driver to pass negative platfo=
rm
> > device IDs to the I2C core. The SH7785LCR device uses ID -1, so the cor=
e
> > assigns it a dynamic bus number. Reserving bus 0 for the board informat=
ion
> > makes i2c-1 the first dynamic bus, and the RTC is never instantiated.
> >=20
> > Set the platform device ID to 0 so the adapter is registered as i2c-0 a=
nd
> > the RTC board information matches it.
> >=20
> > Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't e=
xplictly specified")
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> >=20
> > Tested with 29-bit and 32-bit kernels on a custom QEMU model of the
> > SH7785LCR. Both registered the controller as i2c-0 and the R2025S/D as
> > rtc0.
> > Testing on real hardware is welcome.
> >=20
> >  arch/sh/boards/board-sh7785lcr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh=
7785lcr.c
> > index 25c4968f0d8b..b93423df582f 100644
> > --- a/arch/sh/boards/board-sh7785lcr.c
> > +++ b/arch/sh/boards/board-sh7785lcr.c
> > @@ -256,7 +256,7 @@ static struct i2c_pca9564_pf_platform_data i2c_plat=
form_data =3D {
> > =20
> >  static struct platform_device i2c_device =3D {
> >  	.name		=3D "i2c-pca-platform",
> > -	.id		=3D -1,
> > +	.id		=3D 0,
> >  	.dev		=3D {
> >  		.platform_data	=3D &i2c_platform_data,
> >  	},
>=20
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

I have to admit though I don't fully understand the description of this
patch. Either I don't have enough coffee or it's not precise enough.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
