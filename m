From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 13 Dec 2013 18:22:15 +0000
Subject: Re: [PATCH v2] mtd: sh_flctl: Fix warnings due to improper casts
Message-Id: <20131213182215.GZ27149@ld-irv-0074.broadcom.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385547448-13747-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385547448-13747-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

On Wed, Nov 27, 2013 at 11:17:28AM +0100, Laurent Pinchart wrote:
> Cast pointers to uintptr_t instead of unsigned int. This fixes warnings
> on platforms where pointers have a different size than int.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/mtd/nand/sh_flctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Changes compared to v1:
> 
> - Cast to uintptr_t instead of unsigned long

This patch has been in l2-mtd.git, but I forgot to alert you. Thanks for
the patch!

Brian
