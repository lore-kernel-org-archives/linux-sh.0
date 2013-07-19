From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 04:45:31 +0000
Subject: Re: [PATCH v5 4/5] ARM: shmobile: sh73a0: Remove all GPIOs
Message-Id: <20130719044531.GE10959@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373970728-28648-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373970728-28648-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 16, 2013 at 12:32:07PM +0200, Laurent Pinchart wrote:
> Function GPIOs are not used anymore, and all code use the GPIO numbers
> directly. Remove the GPIOs enumeration.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/include/mach/sh73a0.h | 373 +--------------------------
>  1 file changed, 1 insertion(+), 372 deletions(-)

Thanks, I have queued this up for v3.12 in the wpu-pwm branch                   of the renesas tree.    
