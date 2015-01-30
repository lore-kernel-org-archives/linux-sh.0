From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Jan 2015 21:49:23 +0000
Subject: Re: [PATCH] ARM: shmobile: alt dts: Drop console= bootargs parameter
Message-Id: <54CBFC63.4070808@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 11/04/2014 07:23 AM, Simon Horman wrote:

> Alt is booted from DT, so chosen/stdout-path is
> always used, and we can drop the "console=" parameter from chosen/bootargs.

> This change has a side-effect of changing the console speed from 38400
> to 115200. This is intentional as 115200 is consistently used on
> all other shmobile boards.

    I'd say it's not very practical to change the console's baud rate from 
U-Boot's default (AFAIR changing baud rate in U-Boot didn't work)...

> Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> index 8aec512..f2cf757 100644
> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> @@ -20,7 +20,7 @@
>   	};
>
>   	chosen {
> -		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";

    Hm, does this even work as intended? I've tried to boot another R8A7794 
based board and I couldn't get any output with alike command line. Booting 
with 'earlyprintk=serial' has shown that tty0 was enabled as a console which 
is not what we wanted.

WBR, Sergei

