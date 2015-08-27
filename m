From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 11:52:04 +0000
Subject: Re: [PATCH/RFC 08/10] arm64: dts: r8a7795: enable nfs root on Salvator-X board
Message-Id: <55DEF9E4.5000601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-9-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-9-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/27/2015 12:24 PM, Simon Horman wrote:

> As has been the practice for boards for 32bit ARM Renesas SoCs
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index e8d940cc831a..109261ea60bd 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -20,7 +20,7 @@
>   	};
>
>   	chosen {
> -		bootargs = "ignore_loglevel";
> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";

    Hm... so this SoC doesn't have the plain Ether device, just AVB?

MBR, Sergei

