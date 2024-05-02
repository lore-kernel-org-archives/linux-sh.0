Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4175490A
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645665; cv=none; b=matxWxh914tOf1nC9Nbyu1CScbsaW3yA1jkDFyqKh48y8iFAmbs3ljzfWFDqG5uBvnYsxNLkJZZzj6DMmNr04ER42JvTKswM+Ipg7TvCB+1bnYqGu2nQSQNxdr4xfKGq8oexSRSTUk+Atex3uo+NyKPXLYhBgWigqx0LLPV3c1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645665; c=relaxed/simple;
	bh=a9CtMTVaSLllBn9gz+Ve70J9Ob0rtYVMhFSgIrMoXaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKuIz4G2ZN0niQ5Xakaz9NFiTxiO3QYkatxTiK3PCPD6PNkGMVwaVTPY3vmAcoXWm92GQt7vjB8dvRMuZvlEQzcxEP0jHxo2Tt+hbU3sjmmNZcj64htl1ch/EsH5LEvEefvkym5kn4X5uyn1RY5Llp6OekbFFtMqY0k5y0Tn+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pvsiXTya; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pvsiXTya"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z73Ikm3LgzGcVgkS4KIsYD8qVFFsUsrWP60nM2EGiCY=; t=1714645663; x=1715250463; 
	b=pvsiXTyaXUGyk0SZ4EjJRYBFoW00Wt+O77av0SHiwG34D4xfIsg52SGTSdGXwTkGIe9e+haQkMf
	hewMS3AeChQbtHjM7uMsHqUR6u1tlzz5T8t4PFtROtMvPV+ZRMaaGbI8zWLnVmeyoMDzEFcBXcXfB
	jUKsD10yrGb+d31XjGmtPRPQ67jaRX3PHTfl0mhtjHErQZOwjK15gKvMa35fPSsPrSNpKZeQhCEkm
	QdLwnySR8+N1lJphvGp254t25zu3CM4t9Pk6Fuj+mHBGYYR9dxCtaiRFGD3No6g49TxSjAni/MK9O
	Mdd11TZSW3CedSwrJ8ccUIFOR689e76rhY4Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Tf8-00000001y2q-0D14; Thu, 02 May 2024 12:27:38 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2Tf7-000000007QK-3ViW; Thu, 02 May 2024 12:27:37 +0200
Message-ID: <31078e6a359c780316704837ecb96712daf69603.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@vpengutronix.de
Date: Thu, 02 May 2024 12:27:37 +0200
In-Reply-To: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2024-03-06 at 22:19 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/sh/drivers/push-switch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.=
c
> index 6ecba5f521eb..362e4860bf52 100644
> --- a/arch/sh/drivers/push-switch.c
> +++ b/arch/sh/drivers/push-switch.c
> @@ -91,7 +91,7 @@ static int switch_drv_probe(struct platform_device *pde=
v)
>  	return ret;
>  }
> =20
> -static int switch_drv_remove(struct platform_device *pdev)
> +static void switch_drv_remove(struct platform_device *pdev)
>  {
>  	struct push_switch *psw =3D platform_get_drvdata(pdev);
>  	struct push_switch_platform_info *psw_info =3D pdev->dev.platform_data;
> @@ -106,13 +106,11 @@ static int switch_drv_remove(struct platform_device=
 *pdev)
>  	free_irq(irq, pdev);
> =20
>  	kfree(psw);
> -
> -	return 0;
>  }
> =20
>  static struct platform_driver switch_driver =3D {
>  	.probe		=3D switch_drv_probe,
> -	.remove		=3D switch_drv_remove,
> +	.remove_new	=3D switch_drv_remove,
>  	.driver		=3D {
>  		.name	=3D DRV_NAME,
>  	},
>=20
> base-commit: 11afac187274a6177a7ac82997f8691c0f469e41

Applied to my sh-linux tree in the for-next branch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
