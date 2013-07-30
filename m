From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 30 Jul 2013 14:20:10 +0000
Subject: Re: [PATCH] sh_eth: r8a7790: Handle the RFE (Receive FIFO overflow Error) interrupt
Message-Id: <4760883.hI1JN8gopV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375142928-17769-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51F7CADE.5070801@cogentembedded.com>
In-Reply-To: <51F7CADE.5070801@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

Hi Sergei,

On Tuesday 30 July 2013 18:17:02 Sergei Shtylyov wrote:
> On 30-07-2013 4:08, Laurent Pinchart wrote:
> > The RFE interrupt is enabled for the r8a7790 but isn't handled,
> > resulting in the interrupts core noticing unhandled interrupts, and
> > eventually disabling the ethernet IRQ.
> > 
> > Fix it by adding RFE to the bitmask of error interrupts to be handled
> > for r8a7790.
> 
> So, Simon hasn't synced his patch to my late bug fix in 3.10... Did this
> patch help you with your NFS boot issue, Laurent?

Yes, it fixes the "disabling interrupt, nobody cared" problem. I still have 
intermittent NFS issues, but at least I can now boot.

> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

