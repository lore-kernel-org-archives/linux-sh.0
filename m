From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 01:38:05 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: fixup ether node naming
Message-Id: <20131008013803.GC11179@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9ip25nz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9ip25nz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 06:20:19PM -0700, Kuninori Morimoto wrote:
> According to the ePAPR spec,
> the node name should be "ethernet", not "lan0".
> 
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> index 4425fd2..969e386 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
> @@ -39,7 +39,7 @@
>  		regulator-always-on;
>  	};
>  
> -	lan0@18300000 {
> +	ethernet@18300000 {
>  		compatible = "smsc,lan9220", "smsc,lan9115";
>  		reg = <0x18300000 0x1000>;

Thanks, I have queued this up for v3.13.
