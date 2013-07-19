From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 04:45:17 +0000
Subject: Re: [PATCH v5 3/5] ARM: shmobile: kota2: Use leds-pwm + pwm-rmob
Message-Id: <20130719044517.GD10959@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373970728-28648-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373970728-28648-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 16, 2013 at 12:32:06PM +0200, Laurent Pinchart wrote:
> Instead of using the LED-specific TPU PWM driver, switch to the generic
> TPU PWM driver with leds-pwm.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/board-kota2.c  | 169 +++++++++++++++++-----------------
>  arch/arm/mach-shmobile/clock-sh73a0.c |  12 ++-
>  2 files changed, 90 insertions(+), 91 deletions(-)

Thanks, I have queued this up for v3.12 in the wpu-pwm branch                   of the renesas tree.    
