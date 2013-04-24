From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Apr 2013 07:36:22 +0000
Subject: Re: [PATCH 00/37] Fully migrate r8a7740 to pinctrl
Message-Id: <20130424073622.GA847@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366671618-8796-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366671618-8796-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 23, 2013 at 12:59:41AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set migrates the r8a7740 platforms to pinctrl, function by function,
> and then removes function GPIO support completely.
> 
> The patches have been tested on Armadillo only as I don't have a Bonito board.

I don't know that anyone has a Bonito board :^)

I have rebased the pinmux branch on renesas-boards3-for-v3.10 to
supply dependencies. That tag includes the renesas-pinmux2-for-v3.10
tag which the pinmux branch was previously based on.

I have applied this entire series on the resulting pinmux branch.

I plan to push this when I tag renesas-next-20130424 later today.
If not I will tag and push renesas-next-20130425 tomorrow.
