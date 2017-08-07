From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Aug 2017 07:59:20 +0000
Subject: Re: [PATCH] ARM:dts:armadillo800eva: Add console parametters
Message-Id: <20170807075920.GD7175@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1502027702-4366-1-git-send-email-phucduc.bui@gmail.com>
 <1502027702-4366-2-git-send-email-phucduc.bui@gmail.com>
In-Reply-To: <1502027702-4366-2-git-send-email-phucduc.bui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Aug 06, 2017 at 08:55:02PM +0700, Bui Duc Phuc (Fukuda) wrote:
> From: Bui Duc Phuc <phucduc.bui@gmail.com>
> 
> After the kernel boot, the login prompt doesn't appear.
> This patch will add console parametters to bootargs to fix it.
> 
> Signed-off-by: Bui Duc Phuc <phucduc.bui@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> index 1788e18..d383b37 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> @@ -24,7 +24,8 @@
>  	};
>  
>  	chosen {
> -		bootargs = "earlyprintk ignore_loglevel root=/dev/nfs ip=dhcp rw";
> +		bootargs = "console=tty0 console=ttySC0,115200 earlyprintk
> +				ignore_loglevel root=/dev/nfs ip=dhcp rw";
>  		stdout-path = "serial0:115200n8";
>  	};

Hi,

this feels wrong. My understanding is that stdout-path should be enough
to get the console.
