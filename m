From: Simon Horman <horms@verge.net.au>
Date: Wed, 28 Jan 2015 06:48:23 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <20150128064822.GC3581@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 27, 2015 at 10:55:22AM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the review.
> 
> On Tuesday 27 January 2015 09:53:25 Geert Uytterhoeven wrote:
> > On Tue, Jan 27, 2015 at 9:45 AM, Laurent Pinchart wrote:
> > > Enable the ethernet controller for the Alt board. Pin muxing entries are
> > > currently left out as r8a7794 pin control support isn't available yet.
> > > We thus rely on the boot loader to configure ethernet pins for now.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Looks OK (I don't have an Alt, nor schematics).
> 
> I only have a block diagram, no detailed schematics. I have however 
> successfully tested the patch on Magnus' Alt board. It might depends on 
> particular DIP switch settings, but it should be good enough to start with.
> 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up for v3.21.

Geert, I took the Ack above to cover both patches in this series
which has no cover letter. If that was not your intention
please let me know.

