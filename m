From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 Jan 2014 00:15:48 +0000
Subject: Re: [PATCH 0/4] r8a779[01]: Add new clocks to the device tree
Message-Id: <20140113001546.GC15296@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 10, 2014 at 11:00:33AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Jan 9, 2014 at 2:14 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Jan 07, 2014 at 09:22:52AM +0100, Laurent Pinchart wrote:
> >> Hello,
> >>
> >> These four patches add the VIN and SATA clocks to the device tree. Not much
> >> else to be said, the changes should be safe and will be needed for VIN and
> >> SATA DT support.
> >
> > Magnus, could you review these?
> >
> >> Laurent Pinchart (4):
> >>   ARM: shmobile: r8a7790: Add VIN clocks to device tree
> >>   ARM: shmobile: r8a7791: Add VIN clocks to device tree
> >>   ARM: shmobile: r8a7790: Add SATA clocks to device tree
> >>   ARM: shmobile: r8a7791: Add SATA clocks to device tree
> 
> They look fine to me. Now when Valentine has tested the SATA bits I
> think they are ready to merge.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks.

I will wait for a Tested-by from Valentine before applying these.
