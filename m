From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Sep 2010 08:21:56 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: modify wrong array size of div6_reparent_clks
Message-Id: <AANLkTimxGr_-c9w0yi9bR5qmnrbgB59cvP+Ka_x4YZ7=@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3peicvwlyp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3peicvwlyp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Sep 15, 2010 at 3:38 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> =A0arch/arm/mach-shmobile/clock-sh7372.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobi=
le/clock-sh7372.c
> index 7594689..ea384e1 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -548,7 +548,7 @@ void __init sh7372_clock_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D sh_clk_div6_register(div6_clks, DI=
V6_NR);
>
> =A0 =A0 =A0 =A0if (!ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sh_clk_div6_reparent_register(div6_=
reparent_clks, DIV6_NR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sh_clk_div6_reparent_register(div6_=
reparent_clks, DIV6_REPARENT_NR);

Good catch, thanks!

/ magnus
