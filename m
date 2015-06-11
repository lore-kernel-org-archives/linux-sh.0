From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Jun 2015 02:38:39 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7740: move I2C errata handling into the driver
Message-Id: <20150611023839.GA6904@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Tue, Jun 09, 2015 at 04:14:38PM +0900, Wolfram Sang wrote:
> This series moves the errata handling from the setup function into the driver.
> It has been tested that this changeset does not cause a regression on the
> armadillo board we had access to. Unfortunately, this board did not need the
> workaround at all, only some revisions of the r8a7740 are affected.
> 
> After a short discussion with Simon, we agreed this should go via I2C.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Wolfram Sang (2):
>   i2c: sh_mobile: add errata workaround
>   ARM: shmobile: r8a7740: remove I2C errata handling
> 
>  arch/arm/mach-shmobile/setup-r8a7740.c | 55 ----------------------------------
>  drivers/i2c/busses/i2c-sh_mobile.c     | 40 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 55 deletions(-)
> 
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
