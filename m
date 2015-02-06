From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Feb 2015 00:58:43 +0000
Subject: Re: [PATCH 12/12] ARM: shmobile: koelsch: Add DU HDMI output support
Message-Id: <20150206005842.GA10620@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1411589072-28609-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20141027003829.GC32437@verge.net.au>
 <2760366.et6DDZxN2B@avalon>
In-Reply-To: <2760366.et6DDZxN2B@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Magnus Damm <magnus.damm@gmail.com>

[CC Damian, Magnus]

On Mon, Oct 27, 2014 at 02:12:56PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 27 October 2014 09:38:29 Simon Horman wrote:
> > On Wed, Sep 24, 2014 at 11:04:32PM +0300, Laurent Pinchart wrote:
> > > Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector
> > > and configure the DISP pin group that drives the HDMI transmitter DE
> > > pin.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Please be careful of any conflicts that may arise if this patch
> > doesn't go through my renesas tree.
> 
> I think it would be best if the patch went through your tree. There's no 
> compile time or runtime dependency on the DU HDMI code, so as soon as the 
> ADV7511 DT bindings get accepted I plan to ask you to merge this patch.

Hi Laurent,

I'd like to enquire about the status of this change as
Damian has asked me about it.

It seems that I could pick this up for v3.21 as the bindings seem to be in
v3.19-rc1. But perhaps events have overtaken the discussion above which was
some months ago now.
