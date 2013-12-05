From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 06:55:12 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7740: Fix pin bias setup
Message-Id: <20131205065511.GA6817@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385652004-7117-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385652004-7117-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 05, 2013 at 06:55:07AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 05 December 2013 12:43:11 Simon Horman wrote:
> > Hi Laurent,
> > 
> > On Thu, Nov 28, 2013 at 04:20:03PM +0100, Laurent Pinchart wrote:
> > > When computing the pin configuration register offset the bias setup code
> > > erroneously compares the pin number range with the loop index instead of
> > > the pin number. Fix it.
> > 
> > this appears to be a bug-fix. If you haven't queued this up already
> > could you consider adding something like this to the changelog?
> > Likewise for "[2/2] sh-pfc: sh7372: Fix pin bias setup".
> > 
> > This resolves a problem that was added when bias pinconf support was added
> > by 80da8e02d22caaef ("sh-pfc: r8a7740: Add bias (pull-up/down) pinconf
> > support") in v3.10-rc3.
> 
> Linus has queued both patches up already, sorry.

No problem.
