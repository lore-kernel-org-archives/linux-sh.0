From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Jun 2014 15:39:39 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: lager: add sound support on DT
Message-Id: <539726BB.7090904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sindcx1v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sindcx1v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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
> +	snd_codec: ak4643 {
> +		#sound-dai-cells = <0>;
> +		compatible = "asahi-kasei,ak4643";

    Oh, and according to 
Documentation/devicetree/bindings/vendor-prefixes.txt, the vendor prefix 
should be "ak", not "asahi-kasei"...

[...]

WBR, Sergei

