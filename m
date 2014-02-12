From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 05:53:48 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: lager: add SDHI0/2 support on DTS
Message-Id: <CANqRtoTtcBd2cOC_ZTHfFCFxUXiyzx7ffNPfRPYZSK0ShXienw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r47fb9tc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87r47fb9tc.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch.

On Fri, Feb 7, 2014 at 5:34 PM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |   84 +++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 1081c5e..972c75a 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -56,6 +56,54 @@
>                 regulator-boot-on;
>                 regulator-always-on;
>         };
> +
> +       vcc_sdhi0: regulator@1 {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "SDHI0 Vcc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&gpio5 24 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       vccq_sdhi0: regulator@2 {
> +               compatible = "regulator-gpio";
> +
> +               regulator-name = "SDHI0 VccQ";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
> +               gpios-states = <1>;
> +               states = <3300000 1
> +                         1800000 0>;
> +       };
> +
> +       vcc_sdhi2: regulator@3 {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "SDHI0 Vcc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&gpio5 25 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       vccq_sdhi2: regulator@4 {
> +               compatible = "regulator-gpio";
> +
> +               regulator-name = "SDHI0 VccQ";

After some testing I can see that "regulator-name" contains a typo
above. Please use SDHI2 as name for SDHI2 devices, not SDHI0. =)

Can you make a V2?

Thanks,

/ magnus
