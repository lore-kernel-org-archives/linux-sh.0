From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Apr 2013 07:37:16 +0000
Subject: Re: [PATCH 00/35] Fully migrate sh7372 to pinctrl
Message-Id: <20130424073716.GB847@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366671758-8954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366671758-8954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 23, 2013 at 01:02:03AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set migrates the r8a7740 platforms to pinctrl, function by function,
> and then removes function GPIO support completely.
> 
> The patches are based on tags/renesas-next-20130422. They have been tested on
> Mackerel only as I don't have an ap4evb board.

I have rebased the pinmux branch on renesas-boards3-for-v3.10 to
supply dependencies. That tag includes the renesas-pinmux2-for-v3.10
tag which the pinmux branch was previously based on.

I have applied this entire series on the resulting pinmux branch.

I plan to push this when I tag renesas-next-20130424 later today.
If not I will tag and push renesas-next-20130425 tomorrow.   
