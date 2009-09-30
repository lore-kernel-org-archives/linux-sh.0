From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Sep 2009 03:52:38 +0000
Subject: Re: [PATCH v2] sh: mach-ecovec24: modify 1st MTD area to read only
Message-Id: <20090930035238.GD25971@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uk4zh9rxl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk4zh9rxl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 30, 2009 at 09:50:30AM +0900, Kuninori Morimoto wrote:
> Tested-by: Yusuke Goda <goda.yusuke@renesas.com>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> this patch is v2 of 
> [PATCH] sh: mach-ecovec24: modify MTD mask_flags typo
> 
> v1 -> v2
> 
> o MTD_CAP_RAM => MTD_WRITEABLE
> o change Subject
> 
>  arch/sh/boards/mach-ecovec24/setup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
Applied, thanks.
