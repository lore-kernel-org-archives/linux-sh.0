From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 29 May 2014 13:20:34 +0000
Subject: Re: [PATCH v2 04/05] staging: board: Initial board staging support
Message-Id: <20140529132034.GB15585@mwanda>
List-Id: <linux-sh.vger.kernel.org>
References: <20140529131650.2329.3197.sendpatchset@w520>
 <20140529131732.2329.50630.sendpatchset@w520>
In-Reply-To: <20140529131732.2329.50630.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, olof@lixom.net

On Thu, May 29, 2014 at 10:17:32PM +0900, Magnus Damm wrote:
> --- /dev/null
> +++ work/drivers/staging/board/Kconfig	2014-05-29 21:40:41.000000000 +0900
> @@ -0,0 +1,7 @@
> +config STAGING_BOARD
> +	boolean "Staging Board Support"
> +	help
> +	  Select to enable per-board staging support code.
> +
> +	  If in doubt, say N here.
> +

Actually, you're probably going to need to add a bunch of dependencies
here or it will break "make randconfig" right away.  Sorry that I forgot
about this in the first review.

regards,
dan carpenter

