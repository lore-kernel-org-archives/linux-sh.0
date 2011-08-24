From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Aug 2011 05:37:11 +0000
Subject: Re: [PATCH 0/4 v7] mmc: tmio, sdhi: provide multiple irq handlers
Message-Id: <20110824053711.GB17212@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1313740642-18307-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1313740642-18307-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>

On Fri, Aug 19, 2011 at 04:57:18PM +0900, Simon Horman wrote:
> The SDHI driver already supports making use of up to three interrupt
> sources.
> 
> This series breaks up the existing interrupt handler into three handlers,
> one for card access, one for card detect interrupts, and one for SDIO
> interrupts.  A cover-all handler, which makes use of these new broken-out
> handlers is provided for for the case where there is only one interrupt
> source.
> 
> This series also wires up the broken-out irq handlers in the SDHI driver

Magnus, Guennadi,

when you get a chance could I get an ack or otherwise on these changes.

