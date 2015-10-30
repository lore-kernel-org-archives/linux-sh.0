From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 30 Oct 2015 13:06:48 +0000
Subject: Re: [PATCH] arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
Message-Id: <5186464.J3dvUFu6c7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1446197120-4640-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446197120-4640-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 30 October 2015 10:25:20 Geert Uytterhoeven wrote:
> Add an ethernet0 alias for the wired network card so that U-Boot can
> find the device-node and add an appropriate "local-mac-address"
> property.

I like that :-) Can U-Boot add the property ? I thought it needed a 
placeholder.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts index
> 86b70ce3d0599d6e..d16506338f020427 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -41,6 +41,7 @@
>  	aliases {
>  		serial0 = &scif2;
>  		serial1 = &scif1;
> +		ethernet0 = &avb;
>  	};
> 
>  	chosen {

-- 
Regards,

Laurent Pinchart

