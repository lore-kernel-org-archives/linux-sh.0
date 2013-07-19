From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 04:45:08 +0000
Subject: Re: [PATCH v5 2/5] ARM: shmobile: armadillo800eva: Add backlight support
Message-Id: <20130719044508.GC10959@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373970728-28648-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373970728-28648-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 16, 2013 at 12:32:05PM +0200, Laurent Pinchart wrote:
> The flat panel backlight on the Armadillo 800 EVA board is driven by the
> TPU PWM output.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Simon Horman <horms@verge.net.au>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 54 +++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.12 in the wpu-pwm branch
of the renesas tree.
