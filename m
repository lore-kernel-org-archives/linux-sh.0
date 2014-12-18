From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 18 Dec 2014 03:24:40 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: sh73a0: Set control-parent for all irqpin nodes
Message-Id: <2812373.rqVbtG7F7j@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 18 December 2014 12:17:16 Magnus Damm wrote:
> On Thu, Dec 18, 2014 at 11:26 AM, Laurent Pinchart wrote:
> > The sh73a0 INTC can't mask interrupts properly most likely due to a
> > hardware bug. Set the control-parent property to delegate masking to the
> > parent interrupt controller.
> 
> Thanks for your patch. Are you sure it is needed for all interrupts?

I'm not as I can't test all interrupts, but given that it's needed for two 
interrupts on two different INTC instances (well, two different INTC DT nodes, 
but it's really the same IP core) I'm pretty confident that the workaround is 
needed for all INTC interrupts on sh73a0.

> If so, perhaps it we should consider to enable this in the driver based on
> the SoC compat string?

I was thinking about that. We could then remove the property from the DT 
bindings.

-- 
Regards,

Laurent Pinchart

