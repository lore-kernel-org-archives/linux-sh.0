From: Simon Horman <horms@verge.net.au>
Date: Fri, 24 Jan 2014 01:20:50 +0000
Subject: Re: [PATCH 0/3] Renesas serial sh-sci DT fixes
Message-Id: <20140124012049.GA16314@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390308519-31320-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390308519-31320-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 22, 2014 at 10:51:38AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 22 January 2014 09:34:56 Simon Horman wrote:
> > On Tue, Jan 21, 2014 at 01:48:36PM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > These three patches fix issues with the sh-sci DT support.
> > > 
> > > The first patch fixes a typo in the DT bindings documentation example. The
> > > two other patches fix issues in the r8a7790 serial port DT nodes caused
> > > by merging work in progress version of DT support instead of the latest
> > > available one.
> > > 
> > > The first two patches are candidates for v3.14-rc. I'd like to third patch
> > > to join them if possible.
> > 
> > Forgive me for blase
> 
> I'll try to forgive you :-)
> 
> > but these changes seem to be more on the cosmetic side than on the fixing
> > problems side. I'm more inclined to queue them up for v3.15 than v3.14-rc.
> 
> Given that the serial devices are disabled the problems shouldn't cause any 
> issue, indeed. I was more concerned about someone enabling them and having 
> incorrect DTs in the wild, but I suppose that's not likely.

Agreed.

I have queued up this series for v3.15.
