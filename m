Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9921118D
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379423; cv=none; b=B6f+7+7b99nJKIfYw686K6uiR0/CJkRvU9Cwil8vQULYzrFb+P+l7VS+gX4MqCfOSOWs+g4IObQnHbX5MduV1JBJnA22g/BvxtI5tv9jkDHoiDJ2LefwpYl1eeJtSFlkTWJezE2maWq93cl8wOd4UMMx3Q07oDU9N76Km/c6kMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379423; c=relaxed/simple;
	bh=JaLaOtqIvYUrl9HpniFpibDtduN6o7ct7rcxygYn6Nk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRlbG21DIdYfoiFrNkdcRHEcNlqCpjNj0Bq34stTnrz62XPE9wTXHWuXo2bxuG0A+toBM7o598QL1VaKREjjKHChMc9xXXfyECtOQIB8q6R3chhfMOFcLUkY3d5hImxdUpI1DBiTiWC2oesBc19eF5+l58Fbb2sQWxKzjkQRWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OFgikepa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OFgikepa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6BLmq4wMfJdn6WWMnnTU3e/n9xRo0JCnuj/jgRy3i38=; t=1714379421; x=1714984221; 
	b=OFgikepadzLkxVsCw9nsBPsohzHOd3incrmV278JYOWJ1pICQkVzT6AMLQdgd6K6NzTeclJXYLS
	MVSO40rS4X0idZ9f883TyEcg9wp8OFuvy1t+Eno7A7/e2I4jO1LnGNs6PG6qbt3S4hJDzPX56Afr/
	cCBXlOuKVC38tp5gyOzIwjCceJycCpv0aQlF+XciG1apyvUE6dXdO3LDXu6az+n2UyyQpU+eaq0jA
	dsSePlGPzcerPsn+uH3sEhN2d3ceN6W9wYKxUy1AdsoY2OqES9K/KAnA+Xk2BuJfej98rlUsCo8N2
	4uGm0hDkFwRcmAS4ALwlKR35X//JebuiHGQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1MOn-00000003fum-3zti; Mon, 29 Apr 2024 10:30:09 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1MOn-00000001KBp-34Kh; Mon, 29 Apr 2024 10:30:09 +0200
Message-ID: <9e26c50be78ff415f484cb9af9546a49002d3851.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Duoming Zhou
	 <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@vpengutronix.de
Date: Mon, 29 Apr 2024 10:30:08 +0200
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

Thanks for elaborate explanation in the commit message which makes it much
easier to understand the changes and the reasoning behind it. I fully agree
with the changes.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
