From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Jun 2015 14:29:26 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7740: move I2C errata handling into the driver
Message-Id: <7753098.CPS35ND2Za@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1433834080-5630-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

Thank you for the patches.

On Tuesday 09 June 2015 16:14:38 Wolfram Sang wrote:
> This series moves the errata handling from the setup function into the
> driver. It has been tested that this changeset does not cause a regression
> on the armadillo board we had access to. Unfortunately, this board did not
> need the workaround at all, only some revisions of the r8a7740 are
> affected.
> 
> After a short discussion with Simon, we agreed this should go via I2C.

Looks good to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Wolfram Sang (2):
>   i2c: sh_mobile: add errata workaround
>   ARM: shmobile: r8a7740: remove I2C errata handling
> 
>  arch/arm/mach-shmobile/setup-r8a7740.c | 55 -------------------------------
>  drivers/i2c/busses/i2c-sh_mobile.c     | 40 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 55 deletions(-)

-- 
Regards,

Laurent Pinchart

