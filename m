From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Jun 2014 15:37:20 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: lager: add sound support on DT
Message-Id: <53972630.2060502@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sindcx1v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sindcx1v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 06/10/2014 06:34 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> It supports PIO transfer at this point

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts |   70 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-shmobile/Kconfig      |    1 +
>   2 files changed, 71 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 295a60e..51a3e41 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -372,3 +410,35 @@
>   &i2c3	{
>   	status = "ok";
>   };
> +
> +&i2c2 {
> +	status = "okay";

    Worth putting an empty line here...

> +	snd_codec: ak4643 {

    I see that I'll have to remind about ePAPR again:
"The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model."

> +		#sound-dai-cells = <0>;

    I think that property should go last.

> +		compatible = "asahi-kasei,ak4643";

    I think that property should go first.

> +		reg = <0x12>;
> +	};
> +};
[...]

WBR, Sergei

