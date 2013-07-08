From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 03:51:58 +0000
Subject: Re: [PATCH v2 6/6] ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates
Message-Id: <CANqRtoQjUUNSWr8SkiOwNbhQBrkBMWzPJ9vBEmqUe6L8bck8hw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373037932-19918-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373037932-19918-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

HI Guennadi,

On Sat, Jul 6, 2013 at 12:25 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This adds DT templates for all MMCIF and SDHI controllers on r8a7790.
> They are added with status="disabled". To use them platform-specific
> DTs have to enable the required ones.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2:
> 1. fixed MMCIF resource sizes
> 2. added SDHI compatibility with the actual SoC for possible future driver
>    extensions
> 3. removed not directly applicable comments
>
>  arch/arm/boot/dts/r8a7790.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 339d9b1..304be59 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi

> +       sdhi3: sdhi@ee160000 {
> +               compatible = "renesas,r8a7790-sdhi", "renesas,r8a7740-sdhi";
> +               reg = <0 0xee160000 0 0x100>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 168 4>;
> +               cap-sd-highspeed;
> +               status = "disabled";

Thanks for your update.

It looks to me that "cap-sd-highspeed" is used on all r8a7790 SDHI
instances. Would it be possible to fold that flag into the driver and
match on the "renesas,r8a7790-sdhi" compatible string?

Thanks,

/ magnus
