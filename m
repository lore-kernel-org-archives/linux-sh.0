From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 10:46:10 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Split DU input and output pixel clocks
Message-Id: <20130327104610.GC413@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364378797-29376-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364378797-29376-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 11:06:37AM +0100, Laurent Pinchart wrote:
> The output pixel clocks can be used without the input pixel clocks.
> Split them in different groups.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 60 +++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 21 deletions(-)
> 
> Simon,
> 
> This is needed for DU support on R8A7779. Could you please queue this patch for
> v3.10 ?

Sure, I have queued it up in the pinmux branch.
