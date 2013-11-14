From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Nov 2013 14:57:49 +0000
Subject: Re: [PATCH 01/03] gpio: rcar: Use lazy disable and mask on suspend
Message-Id: <2298370.sXN8x2E2mt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113225927.21449.78044.sendpatchset@w520> <4743540.rTIWauTJHg@avalon> <CANqRtoSkTBG1o1Vrfay_qPxwoyCuitH5cJNCjDdEuiPf0XjvUw@mail.gmail.com>
In-Reply-To: <CANqRtoSkTBG1o1Vrfay_qPxwoyCuitH5cJNCjDdEuiPf0XjvUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Magnus,

On Thursday 14 November 2013 17:50:09 Magnus Damm wrote:
> On Thu, Nov 14, 2013 at 11:17 AM, Laurent Pinchart wrote:
> > On Thursday 14 November 2013 11:03:06 Magnus Damm wrote:
> >> On Thu, Nov 14, 2013 at 9:07 AM, Laurent Pinchart wrote:
> >> > On Thursday 14 November 2013 07:59:36 Magnus Damm wrote:
> >> >> From: Magnus Damm <damm@opensource.se>
> >> >> 
> >> >> Set the ->irq_enable() and ->irq_disable() methods to NULL
> >> >> to enable lazy disable of interrupts.
> >> > 
> >> > Is that just for optimization purpose, or is there another reason ?
> >> 
> >> It is needed for IRQCHIP_MASK_ON_SUSPEND operation, which in turn is
> >> needed for Suspend-to-RAM.
> >> 
> >> >> Also extend the code to set IRQCHIP_MASK_ON_SUSPEND which tells the
> >> >> core that only IRQs marked as wakeups need to stay enabled during
> >> >> Suspend-to-RAM.
> >> > 
> >> > Shouldn't this be split to a separate patch ?
> >> 
> >> I could split them up, but since there is a dependency and since I
> >> mainly care about making sure Suspend-to-RAM works I preferred to keep
> >> them together.
> > 
> > Fine with me. Could you then please update the commit message to mention
> > that lazy disabling is required for IRQCHIP_MASK_ON_SUSPEND ? Same
> > comment for patch 03/03.
> 
> Since when is it common practise to describe the dependencies for the
> various components included in a single commit?

It's common practice to describe the reason for a commit in the commit 
message. In this case the two changes seemed unrelated at first sight, I 
believe explained why they're both needed would be good. 

> My opinion is that the person reading the code if requiring more information
> will have to grep for IRQCHIP_MASK_ON_SUSPEND in the friendly source code
> and learn how the subsystem is held together.
> 
> In the case you have some special detailed commit message that you would
> like me to use then please feel free to propose that. If not then I will
> then split up the patches.

I would have use something like

"gpio: rcar: Use mask on suspend

Set IRQCHIP_MASK_ON_SUSPEND to tell the core that only IRQs marked as wakeups 
need to stay enabled during Suspend-to-RAM. This requires lazy interrupt 
disabling, so set the ->irq_enable() and ->irq_disable() methods to NULL."

Alternatively you can split the patches, I have no preference.

-- 
Regards,

Laurent Pinchart

