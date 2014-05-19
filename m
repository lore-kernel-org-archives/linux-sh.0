From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 19 May 2014 14:16:47 +0000
Subject: Re: [PATCH v2] clocksource: sh_tmu: Fix channel IRQ retrieval in legacy case
Message-Id: <537A124F.80005@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1400244263-14832-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1400244263-14832-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 05/16/2014 02:44 PM, Laurent Pinchart wrote:
> In the legacy platform data case each TMU platform device handles a
> single channel with a single IRQ for the platform device. Retrieve the
> IRQ using the logical channel number instead of the hardware channel
> number.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>   drivers/clocksource/sh_tmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> This patch applies on top of the clockevents/cmt-mtu2-tmu-cleanups branch=
 of
> the git://git.linaro.org/people/daniel.lezcano/linux.git tree. It avoids
> breaking bisection of the TMU-related platform cleanup patches, the issue=
 it
> fixes will disappear in a later driver cleanup patch. Daniel, could you p=
lease
> apply up to clockevents/cmt-mtu2-tmu-cleanups for v3.16 ?
>
> Changes since v1:
>
> - Replace CMT by TMU in the commit message.
>
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 4ba2c0f..ec34095 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -498,7 +498,7 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel=
 *ch, unsigned int index,
>   			ch->base =3D tmu->mapbase + 8 + ch->index * 12;
>   	}
>
> -	ch->irq =3D platform_get_irq(tmu->pdev, ch->index);
> +	ch->irq =3D platform_get_irq(tmu->pdev, index);
>   	if (ch->irq < 0) {
>   		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
>   			ch->index);

Applied to my tree for 3.16

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

