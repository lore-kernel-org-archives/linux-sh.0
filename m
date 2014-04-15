From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 15 Apr 2014 14:26:55 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo-reference dts: Seiko Instruments, Inc is "sii"
Message-Id: <CAO3366zsXNcJDsFwHfqeO2SjB2VEEEJbvJBFXdyJZK-zFAyR7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397566310-24055-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397566310-24055-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org

On Tue, Apr 15, 2014 at 2:51 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Use "sii,s35390a" instead of "seiko,s35390a", cfr.
> Documentation/devicetree/bindings/i2c/trivial-devices.txt and
> Documentation/devicetree/bindings/vendor-prefixes.txt.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

> ---
>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index 0cb235a450b9..10344e6edd20 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -180,7 +180,7 @@
>  &i2c2 {
>         status = "okay";
>         rtc@30 {
> -               compatible = "seiko,s35390a";
> +               compatible = "sii,s35390a";
>                 reg = <0x30>;
>         };
>  };
> --
> 1.7.9.5
>

CU
Uli
