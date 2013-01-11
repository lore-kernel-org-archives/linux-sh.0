From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jan 2013 07:08:25 +0000
Subject: Re: [PATCH 0/8] Use gpio_request_one() in SH Mobile board code
Message-Id: <20130111070824.GA1906@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357847279-7765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357847279-7765-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 08:47:51PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> Here's a small patch set that converts gpio_request() + gpio_direction_*()
> calls into gpio_request_one() in all SH Mobile board files.
> 
> The patches are based on top of "[PATCH v2 00/29] SH pinctrl and pinmux
> implementation". I will rebase my next version of the pinctrl DT patches on
> top of them.

I may be confused but I believe that I have already merged the pinctl DT
patches in their form "[PATCH v2 0/8] SH pinctrl DT support".

Could you either rebase this series on top of the next branch in the reneas
tree or; Indicate that I should drop "[PATCH v2 0/8] SH pinctrl DT support".

I have a slight preference for the first option.

Thanks
