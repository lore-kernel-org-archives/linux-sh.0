From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:28:28 +0000
Subject: Re: [PATCH/RESEND] clocksource: em_sti: Convert to devm_* managed helpers
Message-Id: <20130801072828.GB26015@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375194277-2850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51F8D467.1030400@linaro.org>
In-Reply-To: <51F8D467.1030400@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 31, 2013 at 11:09:59AM +0200, Daniel Lezcano wrote:
> On 07/30/2013 04:24 PM, Laurent Pinchart wrote:
> > Replace kzalloc, clk_get, ioremap and request_irq by their managed
> > counterparts to simplify error paths.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> Sounds good.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, I have queued this up for v3.12 in the clocksource branch
of my renesas tree on kernel.org.
