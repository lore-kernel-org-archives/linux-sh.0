From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Jun 2013 08:25:01 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <CANqRtoRWofxKWcNNXE3Y7bi_E_bcMaPRgedc+O1Gpp60-tn6Lg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Fri, May 17, 2013 at 11:55 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch adds all MMCIF and SDHI devices to r8a73a4.dtsi in the "disabled"
> state, those of them, available on APE6EVM, are then added to the board DT.
> This version assignes fixed regulators to all the interfaces, in future
> versions support for regulators should be added.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks for your work on this. In general I'm happy to see your
progress but I wonder about the following:

> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -98,4 +98,49 @@
>                 gpio-controller;
>                 #gpio-cells = <2>;
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
> +
> +       sdhi0: sdhi@ee100000 {
> +               compatible = "renesas,r8a7740-sdhi";
> +               reg = <0 0xee100000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 165 4>;
> +               cap-sd-highspeed;
> +               status = "disabled";
> +       };

Here you use the "r8a7740-sdhi" compatible string on the r8a73a4 SoC.
Sorry to say this but to me this seems like the first steps toward a
future binary compatibility mess.

Others seem to handle this differently. For instance, in
drivers/mmc/host/omap_hsmmc.c there are separate compatible strings
for omap2 and omap3.

As I stated before, I prefer to see using a compatible string based on
the version of the IP block, or if we have to use the SoC name then
use the name of the actual SoC used.

What is the common way to deal with the compatible strings? Just use
an existing one if it happens to match? Seems a lot like copy-paste
integration to me with the added benefit of forever binary
compatibility.

Perhaps we have agreed on something already? Care to remind me? =)

Cheers,

/ magnus
