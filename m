From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 11 Jan 2013 09:46:15 +0000
Subject: Re: [PATCH 0/8] Use gpio_request_one() in SH Mobile board code
Message-Id: <1939733.2hrOhEyhvK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1357847279-7765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357847279-7765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Friday 11 January 2013 16:08:25 Simon Horman wrote:
> On Thu, Jan 10, 2013 at 08:47:51PM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's a small patch set that converts gpio_request() + gpio_direction_*()
> > calls into gpio_request_one() in all SH Mobile board files.
> > 
> > The patches are based on top of "[PATCH v2 00/29] SH pinctrl and pinmux
> > implementation". I will rebase my next version of the pinctrl DT patches
> > on
> > top of them.
> 
> I may be confused but I believe that I have already merged the pinctl DT
> patches in their form "[PATCH v2 0/8] SH pinctrl DT support".
> 
> Could you either rebase this series on top of the next branch in the reneas
> tree or; Indicate that I should drop "[PATCH v2 0/8] SH pinctrl DT support".
> 
> I have a slight preference for the first option.

The DT series hasn't been acked, and I'm still unsure about the DT bindings, 
so I expect at least one more iteration of the patches. It should thus not be 
merged yet (I'm sorry for not having stated that explicitly when posting the 
patch set). This is why I've based this series on top of the pinctrl + pinmux 
implementation, as it doesn't depend on the DT patches (I would of course like 
to get acks before merging it).

-- 
Regards,

Laurent Pinchart

