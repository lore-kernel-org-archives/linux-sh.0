From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 03:36:15 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Use pinconf API to configure pin pull-down
Message-Id: <20131205033615.GL21443@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385651878-7002-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385651878-7002-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 28, 2013 at 04:17:58PM +0100, Laurent Pinchart wrote:
> The USB0 and USB1 VBUS pins must be pulled down. Add corresponding
> configuration entries in the pinctrl map table instead of manually
> poking the pin control registers.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I will queue this up.
