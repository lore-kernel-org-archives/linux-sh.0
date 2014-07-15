From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jul 2014 11:35:10 +0000
Subject: Re: [PATCH v5 0/8] Enable timers DT devices for Marzen, Genmai, Lager and Koelsch
Message-Id: <20140715113505.GA25203@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404911564-17380-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140715050106.GG5277@verge.net.au>
 <20140715085536.GC17806@verge.net.au>
In-Reply-To: <20140715085536.GC17806@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 15, 2014 at 05:55:36PM +0900, Simon Horman wrote:
> On Tue, Jul 15, 2014 at 02:01:07PM +0900, Simon Horman wrote:
> > On Wed, Jul 09, 2014 at 03:12:36PM +0200, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set enables timer devices in DT for the Marzen, Genmai, Lager and
> > > Koelsch boards. It has previously been posted as part of the "[PATCH v4 00/19]
> > > Renesas CMT, MTU2 and TMU timers DT support" series, and is now split into its
> > > own patch set for merge in v3.17.
> > > 
> > > The series depends on the driver changes of the "[PATCH v4 00/19] Renesas CMT,
> > > MTU2 and TMU timers DT support" series, for which a pull request has been sent.
> > 
> > Thanks, I have queued these up.
> 
> As reported elsewhere I am having a bit of trouble with the dependencies
> for this series so I have dropped it for now.

Please ignore that remark, it was supposed to be about
"ARM: shmobile: r7s72100: Remove legacy board support".

I have only dropped the 72100/genmai patches of this series.
