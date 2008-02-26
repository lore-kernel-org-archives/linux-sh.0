From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:22:23 +0000
Subject: Re: [PATCH] maple: remove unused variable
Message-Id: <20080226052223.GE19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1203205053.6737.17.camel@localhost.localdomain>
In-Reply-To: <1203205053.6737.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Feb 16, 2008 at 11:37:33PM +0000, Adrian McMenamin wrote:
> Remove an unused variable from the definition of struct maple_device
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> ---
> 
> diff -ruN a/include/linux/maple.h b/include/linux/maple.h
> --- a/include/linux/maple.h	2008-02-16 20:52:09.000000000 +0000
> +++ b/include/linux/maple.h	2008-02-16 21:42:06.000000000 +0000
> @@ -64,7 +64,6 @@
>  	int (*connect) (struct maple_device * dev);
>  	void (*disconnect) (struct maple_device * dev);
>  	struct device_driver drv;
> -	int registered;
>  };
>  
Applied, thanks.
