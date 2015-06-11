From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jun 2015 00:43:27 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7740: move I2C errata handling into the driver
Message-Id: <87si9zcc0o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


Hi Wolfram

> This series moves the errata handling from the setup function into the driver.
> It has been tested that this changeset does not cause a regression on the
> armadillo board we had access to. Unfortunately, this board did not need the
> workaround at all, only some revisions of the r8a7740 are affected.
> 
> After a short discussion with Simon, we agreed this should go via I2C.
> 
> Wolfram Sang (2):
>   i2c: sh_mobile: add errata workaround
>   ARM: shmobile: r8a7740: remove I2C errata handling
> 
>  arch/arm/mach-shmobile/setup-r8a7740.c | 55 ----------------------------------
>  drivers/i2c/busses/i2c-sh_mobile.c     | 40 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 55 deletions(-)

Thank you for your patches

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Best regards
---
Kuninori Morimoto
