From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Apr 2014 00:02:05 +0000
Subject: Re: [PATCH 0/2] Fix VSP1 clock names in r8a779[01] .dtsi
Message-Id: <20140410235951.GA4816@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1396449107-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396449107-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 11, 2014 at 01:32:31AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 11 April 2014 07:59:43 Simon Horman wrote:
> > On Thu, Apr 10, 2014 at 06:09:20PM +0900, Magnus Damm wrote:
> > > Hi Laurent,
> > > 
> > > [CC Simon]
> > 
> > Thanks, it helps my work flow immensely to be CCed on patches
> > that I should handle one way or another.
> 
> Every maintainer has different preferences, and for some reason I thought you 
> relied on patchwork more than on e-mails to track patches. I'll make sure to 
> CC you in the future.

Thanks.

I do use patchwork but usually as a secondary reference.
I usually pull patches straight out of email.

> 
> > > On Wed, Apr 2, 2014 at 11:31 PM, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > The VSP1 clocks were incorrectly named in the r8a7790 and r8a7791 .dtsi.
> > > > This patch set fixes the problem.
> > > > 
> > > > Laurent Pinchart (2):
> > > >   ARM: shmobile: r8a7790: Rename VSP1_(SY|RT) clocks to VSP1_(S|R)
> > > >   ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S
> > > 
> > > Thanks for fixing this. These patches look fine to me.
> > > 
> > > Acked-by: Magnus Damm <damm@opensource.se>
> > > 
> > > Simon, can you please pick up?
> > 
> > Done
> 
> Thank you.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
