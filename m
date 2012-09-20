From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Sep 2012 01:52:31 +0000
Subject: Re: [PATCH v2 4/6] pwm_backlight: Add deferred probe support
Message-Id: <20120920015231.GB6873@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1343140823-13754-5-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1343140823-13754-5-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 19, 2012 at 08:27:55PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Saturday 25 August 2012 15:57:12 Simon Horman wrote:
> > On Tue, Jul 24, 2012 at 04:40:21PM +0200, Laurent Pinchart wrote:
> > > If the PWM instance is not available yet at probe time, request a
> > > deferred probe.
> > > 
> > > A better way to fix might be to create a PWM subsystem (possibly
> > > integrated into the GPIO subsystem) to support generic PWM objects, and
> > > make sure the subsystem gets initialized first.
> > 
> > Hi Richard,
> > 
> > I am wondering if you have had a chance to review this change.
> > I believe that it is a pre-requisite for work that Laurent has
> > done to enable the backlight on the Armadillo 800 EVA board.
> 
> The PWM core now returns -EPROBE_DEFER if pwm_get() or pwm_request() can't 
> find the requested device, so this patch isn't needed anymore.

Thanks, case closed.
