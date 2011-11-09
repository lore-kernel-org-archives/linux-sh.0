From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 Nov 2011 10:39:26 +0000
Subject: Re: [PATCH] don't skip debugging output upon earlier loop termination
Message-Id: <CANqRtoQ6YPdQ=z7B8tSnLdf1qn8HbLhQiNc=VTDU7=8CkuBLyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Nov 9, 2011 at 3:44 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> This is against the sh7372-test branch of the linux-pm tree. Feel free to
> roll this patch into the respective original commit.
>
> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/=
pm-sh7372.c
> index 46ee116..a81d8a9 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -123,13 +123,13 @@ static int pd_power_up(struct generic_pm_domain *ge=
npd)
>
> =A0 =A0 =A0 =A0for (retry_count =3D 2 * PSTR_RETRIES; retry_count; retry_=
count--) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(__raw_readl(SWUCR) & mask))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (retry_count > PSTR_RETRIES)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(PSTR_DELAY_US);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (__raw_readl(SWUCR) & mask)
> + =A0 =A0 =A0 if (!retry_count)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EIO;
>
> =A0 =A0 =A0 =A0if (!sh7372_pd->no_debug)
>

Hi Guennadi,

This looks fine to me. In the future, please remember to CC the
linux-sh list for SoC-specific patches.

Acked-by: Magnus Damm <damm@opensource.se>

Thanks,

/ magnus
