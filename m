From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 15 May 2014 08:48:05 +0000
Subject: Re: [PATCH] thermal: rcar: Use pm_runtime_put() i.s.o. pm_runtime_put_sync()
Message-Id: <1400143685.2273.31.camel@rzhang1-toshiba>
List-Id: <linux-sh.vger.kernel.org>
References: <1397494975-22489-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1397494975-22489-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On =E4=B8=80, 2014-04-14 at 19:02 +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> There's no need for this to be synchronous
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

applied.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_therma=
l.c
> index 5a37940b02c9..a8ed0e0265ae 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -470,7 +470,7 @@ error_unregister:
>  			rcar_thermal_irq_disable(priv);
>  	}
> =20
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> =20
>  	return ret;
> @@ -488,7 +488,7 @@ static int rcar_thermal_remove(struct platform_device=
 *pdev)
>  			rcar_thermal_irq_disable(priv);
>  	}
> =20
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
> =20
>  	return 0;


