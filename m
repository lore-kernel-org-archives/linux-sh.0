From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 01 Jun 2009 19:04:48 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <200906012104.49890.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 28 May 2009, Alan Stern wrote:
> On Thu, 28 May 2009, Rafael J. Wysocki wrote:
> 
> > I think we'll need one separate workqueue for run-time PM in general, so that
> > bus types don't introduce their own workqueues for this purpose.  IMO one
> > system-wide run-time PM workqueue should be sufficient (it could also be
> > used for the suspend blockers BTW).
> > 
> > So, perhaps it makes sense to implement such a workqueue at the core level?
> > Thoughts?
> 
> That's fine with me.  This new workqueue can take over the job of the 
> "ksuspend_usbd" workqueue.  But it would have to be marked as 
> freezable.

Having considered it for a while I'm not sure if freezing is the right approach
here.  Namely, the work items put into the workqueue need not be useful after
the resume any more, so perhaps we should deqeue them during suspend?

Best,
Rafael
