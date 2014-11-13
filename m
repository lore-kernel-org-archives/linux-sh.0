From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Nov 2014 00:30:29 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: add missing DVC DMA entry on DTSI
Message-Id: <20141113003026.GD14971@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878ujgokun.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878ujgokun.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 12, 2014 at 08:59:29AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7791.dtsi |   26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 142c3ed..960223c 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1463,7 +1463,18 @@
>  				<&audmapp 0x0f32>,	<&audmapp 0x0f33>,	<&audmapp 0x0f34>,	<&audmapp 0x0f35>,	<&audmapp 0x0f36>,
>  				<&audmapp 0x1032>,	<&audmapp 0x1033>,	<&audmapp 0x1034>,	<&audmapp 0x1035>,	<&audmapp 0x1036>,
>  				<&audmapp 0x1132>,	<&audmapp 0x1133>,	<&audmapp 0x1134>,	<&audmapp 0x1135>,	<&audmapp 0x1136>,
> -				<&audmapp 0x1232>,	<&audmapp 0x1233>,	<&audmapp 0x1234>,	<&audmapp 0x1235>,	<&audmapp 0x1236>;
> +				<&audmapp 0x1232>,	<&audmapp 0x1233>,	<&audmapp 0x1234>,	<&audmapp 0x1235>,	<&audmapp 0x1236>,
> +
> +				<&audmapp 0x3700>,	<&audmapp 0x3800>,
> +				<&audmapp 0x3704>,	<&audmapp 0x3804>,
> +				<&audmapp 0x3708>,	<&audmapp 0x3808>,
> +				<&audmapp 0x370c>,	<&audmapp 0x380c>,
> +				<&audmapp 0x370d>,	<&audmapp 0x380d>,
> +				<&audmapp 0x370e>,	<&audmapp 0x380e>,
> +				<&audmapp 0x370f>,	<&audmapp 0x380f>,
> +				<&audmapp 0x3710>,	<&audmapp 0x3810>,
> +				<&audmapp 0x3711>,	<&audmapp 0x3811>,
> +				<&audmapp 0x3712>,	<&audmapp 0x3812>;
>  
>  		dma-names =	"mem_ssi0",	"ssi0_mem",	"mem_ssiu0",	"ssiu0_mem",
>  				"mem_ssi1",	"ssi1_mem",	"mem_ssiu1",	"ssiu1_mem",
> @@ -1529,7 +1540,18 @@
>  				"ssiu6_src5",		"ssiu6_src6",		"ssiu6_src7",		"ssiu6_src8",		"ssiu6_src9",
>  				"ssiu7_src5",		"ssiu7_src6",		"ssiu7_src7",		"ssiu7_src8",		"ssiu7_src9",
>  				"ssiu8_src5",		"ssiu8_src6",		"ssiu8_src7",		"ssiu8_src8",		"ssiu8_src9",
> -				"ssiu9_src5",		"ssiu9_src6",		"ssiu9_src7",		"ssiu9_src8",		"ssiu9_src9";
> +				"ssiu9_src5",		"ssiu9_src6",		"ssiu9_src7",		"ssiu9_src8",		"ssiu9_src9",
> +
> +				"dvc0_ssiu0",		"dvc1_ssiu0",
> +				"dvc0_ssiu1",		"dvc1_ssiu1",
> +				"dvc0_ssiu2",		"dvc1_ssiu2",
> +				"dvc0_ssiu3",		"dvc1_ssiu3",
> +				"dvc0_ssiu4",		"dvc1_ssiu4",
> +				"dvc0_ssiu5",		"dvc1_ssiu5",
> +				"dvc0_ssiu6",		"dvc1_ssiu6",
> +				"dvc0_ssiu7",		"dvc1_ssiu7",
> +				"dvc0_ssiu8",		"dvc1_ssiu8",
> +				"dvc0_ssiu9",		"dvc1_ssiu9";
>  
>  		status = "disabled";
>  
> -- 
> 1.7.9.5
> 
