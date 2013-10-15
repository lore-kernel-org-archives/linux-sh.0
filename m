From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Oct 2013 13:26:12 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: r8a73a4: fixup DT node naming for SDHI
Message-Id: <525D4274.2080303@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hacjdlmi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 15-10-2013 11:44, Kuninori Morimoto wrote:

> According to ePAPR spec,
> this patch exchanges SDHI DT node from "sdhi" to "sd".

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   16 ++++++++--------
>   arch/arm/boot/dts/r8a73a4.dtsi                  |    6 +++---
>   2 files changed, 11 insertions(+), 11 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 287e047..447c128 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -244,7 +244,7 @@
>   		#gpio-cells = <2>;
>   	};
>
> -	sdhi0: sdhi@ee100000 {
> +	sd0: sd@ee100000 {

    Having to change the node names doesn't mean you need to change the labels 
too (and PFC-related node names too). In fact, I think the existing labels are 
better.

WBR, Sergei

