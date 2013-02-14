From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Feb 2013 12:23:53 +0000
Subject: Re: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <3026499.H7lrtqOphq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Thursday 14 February 2013 13:10:11 Linus Walleij wrote:
> On Wed, Feb 13, 2013 at 5:31 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Feb 12, 2013 at 04:50:02PM +0100, Guennadi Liakhovetski wrote:
> >> Not on all sh-/r-mobile platfotms all pins are numbered contiguously from
> >> 0
> >> to N-1. On all ARM-based platforms datasheets use simple numbers to
> >> identify them, unlike some SuperH-based SoC, naming pins, using strings,
> >> e.g. A31:A0, B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver
> >> supported only contiguous pin numbering. This patch adds support for
> >> sparse pin numbers to support sh73a0 and any other similar SoCs.
> > 
> > Applied to a new topic branch, topic/pinmux-sparse.
> 
> Are you taking these patches forward Simon?
> 
> I basically trust you guys so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Though since Laurent wrote the bulk of this I'd prefer that he also ACK it.

Just to clarify the situation, Simon took the patches in his tree to provide a 
central repository where everybody can get them, but I'm still responsible for 
the PFC driver (at least for now). I'm working on a new version of those 
patches that will supersede all Simon's topic/pinmux-* branches. There's thus 
no need for you to handle the patches for now (review is of course welcome 
:-)).

-- 
Regards,

Laurent Pinchart

