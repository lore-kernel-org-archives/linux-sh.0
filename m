Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC8A48095D;
	Sun,  4 Oct 2026 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146104; cv=none; b=My4JEAMvw8ttSTrPLSQLfFpIYD+a5RUIY1BpG/rcsSS8EtRvKNkR9fZ2MfRZRD47jwEBvJecIa+9LLRz6AzeFv3niDkyEvevZD8pv/+ouRq2bhe6/GVtyuWhSGEqfmbI54r+IzUJUnZ6LG1qSnp31bAE6IAuzrxWhFBJ28Zhsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146104; c=relaxed/simple;
	bh=eTjCzurdJlcEL9u/ERcD70Taio0Ybjoa3Kh3I/eyU7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anvP2dnbx+KSs3GYYjrw7MkmJJ3m5V8GxMtKLxbpqMYdZvpLalBBukzaLj56fNJJbYZyLbrWmM3JMuStTVHxq9Q4qzSUxKPdA5E3QrWbThdSG4fqz3kGUFOXD5dKbzk63lLzadY1sJW/iHJhpgFganRHZljIlYonRVKAD6TDibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=N4CzBz7Y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="N4CzBz7Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nIruSnPtZ3jJHwA7r0U5oZva6oH29kymYAEv3KsW6mI=; t=1791146100;
	x=1791750900; b=N4CzBz7Y0w/5Oc7/NTQ2YT6evIoqpu0tKwRR0oW4y6K830PhpHpuuZMptqYWg
	BI0FL9qpDS/6MeRrA/cV7FB0/fSKKXujM22J6AGrK5cth6/LzqSMntkr4gn5kZNA9+GUZC3YmW4mZ
	C5q0z13pblUZLLOYDwZVlrHMD70PdWmknb99HgWgReuOGC/3HN5akyIHQzN47og+nI691x+bsr6tU
	w8B+m67MdUa499vWr3LKMTXLetAnGzTydzE/dVS5F7z0J6IaqDkDKRKzd9wnvwuU6TqwqBvaxM1PF
	nXN4KntwxUIy/0JGUrWbxg27rA+MIbontudOb58/hJy55DlKhw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xDSv3-00000000RC5-42bU; Sun, 04 Oct 2026 22:34:49 +0200
Received: from dynamic-092-224-138-137.92.224.pool.telefonica.de ([92.224.138.137] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xDSv3-00000003QVl-2h7L; Sun, 04 Oct 2026 22:34:49 +0200
Message-ID: <8acb30b9b9fbbd8d5c5754251eb3f1c166e6d41a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: sh7785lcr: register the PCA9564 as I2C bus 0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <yoshinori.sato@nifty.com>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Date: Sun, 04 Oct 2026 22:34:48 +0200
In-Reply-To: <20261004184644.90750-1-kmehltretter@gmail.com>
References: <20261004184644.90750-1-kmehltretter@gmail.com>
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

On Sun, 2026-10-04 at 20:46 +0200, Karl Mehltretter wrote:
> Before commit 44454baa7ca7 ("i2c: Dynamically assign adapter id if it
> wasn't explictly specified"), a negative ID was replaced by zero, and
> I2C bus zero was instantiated. Since that commit, a negative ID is passed
> verbatim, instantiating an I2C bus with a dynamic number. As SH boards
> still use i2c_register_board_info(0, ...) to register I2C devices, they
> rely on the I2C bus being bus zero.
>=20
> The SH7785LCR is the only SH board whose I2C adapter has a negative ID.
> Its PCA9564 becomes i2c-1, causing registration of the R2025S/D RTC to
> fail, and hwclock finds no /dev/rtc0.
>=20
> Set the platform device ID to 0, so that the adapter is registered as
> bus zero again.
>=20
> Fixes: 44454baa7ca7 ("i2c: Dynamically assign adapter id if it wasn't exp=
lictly specified")
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> v2:
> - Rewrite the commit message based on Geert's suggested wording.
> - Add the tags from Adrian and Geert.
> - No code change.
>=20
> v1: https://lore.kernel.org/r/20261003082833.21511-1-kmehltretter@gmail.c=
om/
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

Thanks a lot! I'll merge it in the upcoming week together with some
more pending patches. This patch will then be part of v7.4.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
