From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 05:49:01 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <CANqRtoSDajisBnkz0g_0RNe8EK6rEW2U1_1TbdSfuegB8WcrCA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfp5gz3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This adds DT templates for all MMCIF and SDHI controllers on r8a73a4.
> They are added with status="disabled". To use them platform-specific
> DTs have to enable the required ones.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi |   45 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 4e1ddf0..064f045 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -166,4 +166,49 @@
>                 interrupt-parent = <&gic>;
>                 interrupts = <0 173 0x4>;
>         };
> +
> +       mmcif0: mmcif@ee200000 {
> +               compatible = "renesas,sh-mmcif";
> +               reg = <0 0xee200000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 169 0x4>;
> +               reg-io-width = <4>;
> +               status = "disabled";
> +       };
> +
> +       mmcif1: mmcif@ee220000 {
> +               compatible = "renesas,sh-mmcif";
> +               reg = <0 0xee220000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 170 0x4>;
> +               reg-io-width = <4>;
> +               status = "disabled";
> +       };

I don't think the size of the MMCIF I/O memory resource is correct,
please check with the data sheet and fix.

> +       sdhi0: sdhi@ee100000 {
> +               compatible = "renesas,r8a7740-sdhi";
> +               reg = <0 0xee100000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 165 4>;
> +               cap-sd-highspeed;
> +               status = "disabled";
> +       };
> +
> +       sdhi1: sdhi@ee120000 {
> +               compatible = "renesas,r8a7740-sdhi";
> +               reg = <0 0xee120000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 166 4>;
> +               cap-sd-highspeed;
> +               status = "disabled";
> +       };
> +
> +       sdhi2: sdhi@ee140000 {
> +               compatible = "renesas,r8a7740-sdhi";
> +               reg = <0 0xee140000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 167 4>;
> +               cap-sd-highspeed;
> +               status = "disabled";
> +       };

And now we're here again using "r8a7740" for SDHI on r8a73a4.

I don't think you have full documentation for the SDHI block, do you?
So please don't assume it is compatible with r8a7740 just because it
happens to work for you.

Cheers,

/ magnus
