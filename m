From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 08 Feb 2015 16:08:19 +0000
Subject: Re: [PATCH 12/12] ARM: shmobile: koelsch: Add DU HDMI output support
Message-Id: <1659503.1z5khf1Cxm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2760366.et6DDZxN2B@avalon> <20150206005842.GA10620@verge.net.au>
In-Reply-To: <20150206005842.GA10620@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Magnus Damm <magnus.damm@gmail.com>

Hi Simon,

On Friday 06 February 2015 09:58:43 Simon Horman wrote:
> [CC Damian, Magnus]
> 
> On Mon, Oct 27, 2014 at 02:12:56PM +0200, Laurent Pinchart wrote:
> > On Monday 27 October 2014 09:38:29 Simon Horman wrote:
> > > On Wed, Sep 24, 2014 at 11:04:32PM +0300, Laurent Pinchart wrote:
> > >> Add DT nodes for the ADV7511 HDMI encoder and its HDMI output
> > >> connector and configure the DISP pin group that drives the HDMI
> > >> transmitter DE pin.
> > >> 
> > >> Signed-off-by: Laurent Pinchart
> > >> <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > Please be careful of any conflicts that may arise if this patch
> > > doesn't go through my renesas tree.
> > 
> > I think it would be best if the patch went through your tree. There's no
> > compile time or runtime dependency on the DU HDMI code, so as soon as the
> > ADV7511 DT bindings get accepted I plan to ask you to merge this patch.
> 
> Hi Laurent,
> 
> I'd like to enquire about the status of this change as
> Damian has asked me about it.
> 
> It seems that I could pick this up for v3.21 as the bindings seem to be in
> v3.19-rc1. But perhaps events have overtaken the discussion above which was
> some months ago now.

For Koelsch everything should be fine, you can pick the patch for v3.21.

For Lager, there's an additional dependency on "drm: rcar-du: Don't fail probe 
in case of partial encoder init error" (to avoid regressions) and on "drm: 
rcar-du: Remove LVDS and HDMI encoders chaining restriction" (to make it work 
at all). Both are in Dave's drm-next branch and should land in v3.20-rc1. To 
avoid bisection breakages we would have to merge Dave's branch first.

-- 
Regards,

Laurent Pinchart

