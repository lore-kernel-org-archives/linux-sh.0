From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Dec 2013 05:37:33 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a7791: Add SSI clocks in device tree
Message-Id: <20131226053733.GC11739@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 26, 2013 at 11:13:32AM +0900, Simon Horman wrote:
> On Wed, Dec 25, 2013 at 07:41:20PM +0100, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Wednesday 25 December 2013 22:07:59 Simon Horman wrote:
> > > On Thu, Dec 19, 2013 at 04:51:06PM +0100, Laurent Pinchart wrote:
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Hi Laurent,
> > > 
> > > I have queued this up and it is present in
> > > renesas-next-v3.13-rc5-20131224v4.
> > > 
> > > However, I have observed that it prevents the Koelsch board booting
> > > to the point where anything is displayed on the serial console.
> > > Likewise on Lager with the r8a7790 variant of this patch.
> > > 
> > > Could you take a look into this?
> > 
> > Indeed, I've been able to reproduce the problem. Could you please drop this 
> > patch and the related Lager patch ? I'll send a new version as an RFC as the 
> > problem might be in the CCF core.
> 
> As I have already sent a pull request that included these changes
> I think that I would prefer to revert them than drop them.

I have queued up reversions of these two patches and intend
to push them later this afternoon.
