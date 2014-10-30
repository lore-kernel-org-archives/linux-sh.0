From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Oct 2014 10:44:41 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <42870768.kOpZNjp1qs@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be> <1414592918-25138-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592918-25138-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

On Wednesday 29 October 2014 15:28:38 Geert Uytterhoeven wrote:
> Since commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
> board code"), koelsch is restricted to booting from DT, so
> chosen/stdout-path is always used, and we can drop the "console="
> parameter from chosen/bootargs.

I'm curious, how is the baud rate now selected ?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> b/arch/arm/boot/dts/r8a7791-koelsch.dts index
> 191f32bc43ea6dad..523ae4d807b907b2 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -25,7 +25,7 @@
>  	};
> 
>  	chosen {
> -		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs
> ip=dhcp";
> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>  		stdout-path = &scif0;
>  	};

-- 
Regards,

Laurent Pinchart

