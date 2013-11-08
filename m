From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 08 Nov 2013 10:10:31 +0000
Subject: Re: [PATCH v2 1/2] clocksource: sh_tmu: Release clock when sh_tmu_register() fails
Message-Id: <527CB897.8070107@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383057097-22689-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 10/29/2013 03:31 PM, Laurent Pinchart wrote:
> Fix the probe error path to release the clock resource when the
> sh_tmu_register() call fails.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Applied in my tree as 3.13 fixes

> ---
>   drivers/clocksource/sh_tmu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 78b8dae..1597837 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -475,9 +475,16 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struc=
t platform_device *pdev)
>   	p->cs_enabled =3D false;
>   	p->enable_count =3D 0;
>
> -	return sh_tmu_register(p, (char *)dev_name(&p->pdev->dev),
> -			       cfg->clockevent_rating,
> -			       cfg->clocksource_rating);
> +	ret =3D sh_tmu_register(p, (char *)dev_name(&p->pdev->dev),
> +			      cfg->clockevent_rating,
> +			      cfg->clocksource_rating);
> +	if (ret < 0)
> +		goto err2;
> +
> +	return 0;
> +
> + err2:
> +	clk_put(p->clk);
>    err1:
>   	iounmap(p->mapbase);
>    err0:
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

