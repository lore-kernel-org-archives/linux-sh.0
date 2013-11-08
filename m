From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 08 Nov 2013 10:10:23 +0000
Subject: Re: [PATCH v2 2/2] clocksource: sh_mtu2: Add clk_prepare/unprepare support
Message-Id: <527CB88F.1060107@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383000569-8916-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383057045-22608-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383057045-22608-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 10/29/2013 03:30 PM, Laurent Pinchart wrote:
> Prepare the clock at probe time, as there is no other appropriate place
> in the driver where we're allowed to sleep.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

Applied in my tree as 3.13 fixes

> ---
>   drivers/clocksource/sh_mtu2.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
> index e6cfb32..3cf1283 100644
> --- a/drivers/clocksource/sh_mtu2.c
> +++ b/drivers/clocksource/sh_mtu2.c
> @@ -313,13 +313,18 @@ static int sh_mtu2_setup(struct sh_mtu2_priv *p, st=
ruct platform_device *pdev)
>   		goto err1;
>   	}
>
> +	ret =3D clk_prepare(p->clk);
> +	if (ret < 0)
> +		goto err2;
> +
>   	ret =3D sh_mtu2_register(p, (char *)dev_name(&p->pdev->dev),
>   			       cfg->clockevent_rating);
>   	if (ret < 0)
> -		goto err2;
> +		goto err3;
>
>   	return 0;
> -
> + err3:
> +	clk_unprepare(p->clk);
>    err2:
>   	clk_put(p->clk);
>    err1:
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

