From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Jan 2015 09:20:03 +0000
Subject: Re: [PATCH 2/3 v2][RFC] ARM: shmobile: r8a7790: add SSIU/DTCP/MLM/SCU reg for Audio DMAC peri peri
Message-Id: <CAMuHMdWzRA69SG_tzopv1Fdm5M6GwsswA_A6vUFnZnxmkqSkBw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9v9f13n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9v9f13n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Jan 30, 2015 at 3:33 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> New Audio DMAC peri peri driver requests SSIU/DTCP/MLM/SCU
> register address.

Thanks, that's the missing piece I was looking for yesterday ;-)

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
>  - new patch
>
>  arch/arm/boot/dts/r8a7790.dtsi |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index ca22009..9f05f19 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -373,7 +373,11 @@
>                 compatible = "renesas,rcar-audmapp";
>                 #dma-cells = <1>;
>
> -               reg = <0 0xec740000 0 0x200>;
> +               reg = <0 0xec740000 0 0x200>,
> +                       <0 0xec400000 0 0x10000>, /* SSIU */
> +                       <0 0xec420000 0 0x4800>,  /* DTCP */
> +                       <0 0xec320000 0 0x2000>,  /* MLM */
> +                       <0 0xec300000 0 0x8800>;  /* SCU */

Please use "reg-names".
Can we still make the name mandatory for the first range, or do we have
to support an anonymous first range for backwards compatibility?

>         };
>
>         i2c0: i2c@e6508000 {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
