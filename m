From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 23:37:00 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Fix address and size cells in LVDS encoder node
Message-Id: <20141027233700.GB31257@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414402033-7311-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414402033-7311-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 27, 2014 at 12:30:31PM +0100, Geert Uytterhoeven wrote:
> On Mon, Oct 27, 2014 at 12:28 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Monday 27 October 2014 12:17:11 Geert Uytterhoeven wrote:
> >> On Mon, Oct 27, 2014 at 10:27 AM, Laurent Pinchart wrote:
> >> > The LVDS encoder DT node #address-cells and #size-cells properties are
> >> > misplaced. Move them to within the ports node.
> >> >
> >> > Reported-by: Simon Horman <horms@verge.net.au>
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >>
> >> by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you mean Acked-by ?
> 
> Yes, sorry for the bad cut-'n-paste.

Thanks, I have queued this up with the following changelog:

ARM: shmobile: marzen: Fix address and size cells in LVDS encoder node

The LVDS encoder DT node #address-cells and #size-cells properties are
misplaced. Move them to within the ports node.

Reported-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
