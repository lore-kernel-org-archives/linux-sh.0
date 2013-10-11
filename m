From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Oct 2013 20:27:55 +0000
Subject: Re: [PATCH 06/10] ARM: shmobile: r8a7778: add SDHI support on DTSI
Message-Id: <52586D09.5030802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-10-2013 8:35, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7778.dtsi |   30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 0ff38e6..873eeb9 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -164,4 +164,34 @@
>   		interrupts = <0 61 4>;
>   		status = "disabled";
>   	};
> +
> +	sdhi0: sdhi@ffe4c000 {

    ePAPR spec [1] says:

"The name of a node should be somewhat generic, reflecting the function of the 
device and not its precise programming model." So I suggest using "mmc" or 
"sd" instead.

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

