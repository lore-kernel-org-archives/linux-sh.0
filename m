From: David Miller <davem@davemloft.net>
Date: Wed, 31 Jul 2013 21:52:33 +0000
Subject: Re: [PATCH/RESEND net-next] sh_eth: r8a7790: Handle the RFE (Receive FIFO overflow Error) interrupt
Message-Id: <20130731.145233.529617514769288794.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1375256531-28884-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375256531-28884-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms+renesas@verge.net.au
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, laurent.pinchart+renesas@ideasonboard.com

From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 31 Jul 2013 16:42:11 +0900

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The RFE interrupt is enabled for the r8a7790 but isn't handled,
> resulting in the interrupts core noticing unhandled interrupts, and
> eventually disabling the ethernet IRQ.
> 
> Fix it by adding RFE to the bitmask of error interrupts to be handled
> for r8a7790.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied, thanks.
