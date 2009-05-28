From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 28 May 2009 15:28:33 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <Pine.LNX.4.44L0.0905281124490.3037-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 28 May 2009, Rafael J. Wysocki wrote:

> I think we'll need one separate workqueue for run-time PM in general, so that
> bus types don't introduce their own workqueues for this purpose.  IMO one
> system-wide run-time PM workqueue should be sufficient (it could also be
> used for the suspend blockers BTW).
> 
> So, perhaps it makes sense to implement such a workqueue at the core level?
> Thoughts?

That's fine with me.  This new workqueue can take over the job of the 
"ksuspend_usbd" workqueue.  But it would have to be marked as 
freezable.

Alan Stern

