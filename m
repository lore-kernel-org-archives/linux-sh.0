From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Mar 2013 17:30:38 +0000
Subject: Re: [PATCH/RFC 02/12] gpio-rcar: Add pinctrl support
Message-Id: <1495514.xyb7jHtL07@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Wednesday 13 March 2013 18:21:59 Linus Walleij wrote:
> On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart wrote:
> > Register the GPIO pin range, and request and free GPIO pins using the
> > pinctrl API.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Looks good.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This requires that the Rcar driver is finalized first tho I guess.

I'm working on that with Magnus. This patch will likely be squashed into the 
gpio-rcar driver for mainline submission.

The PFC pinconf implementation is nearly ready, I'll post new patch sets soon 
and will appreciate if you could review the core patches :-) (I'll point them 
out in the cover letter).

-- 
Regards,

Laurent Pinchart

