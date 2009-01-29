From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 29 Jan 2009 05:46:05 +0000
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and clean up maple bus driver (3/3)
Message-Id: <200901290046.07659.vapier@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1233186456.6734.16.camel@localhost.localdomain> <1233187750.6734.27.camel@localhost.localdomain> <1233188287.6734.32.camel@localhost.localdomain>
In-Reply-To: <1233188287.6734.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

On Wednesday 28 January 2009 19:18:07 Adrian McMenamin wrote:
> --- a/drivers/input/keyboard/maple_keyb.c
> +++ b/drivers/input/keyboard/maple_keyb.c
> -	if (!kbd || !idev) {
> -		error = -ENOMEM;
> +	if (!kbd) {
> +		error = ENOMEM;
>  		goto fail;
>  	}
> ...
> -	return error;
> +fail:
> +	return -error;

this driver has the weird/broken error inverting other patches of yours have 
had recently ... that stuff really needs to stop showing up ;)
-mike
