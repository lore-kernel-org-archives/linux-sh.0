From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:09:04 +0000
Subject: Re: [PATCH v3 0/9] DU DT support for Marzen, Lager and Koelsch
Message-Id: <20141027000901.GA25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1411564828-30272-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411564828-30272-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 03:04:49PM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 24 October 2014 16:20:24 Simon Horman wrote:
> > On Fri, Oct 24, 2014 at 02:09:43PM +0900, Simon Horman wrote:
> > > On Wed, Sep 24, 2014 at 04:20:19PM +0300, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This patch series enable the DU device in DT for the Marzen, Lager and
> > > > Koelsch boards (in their multiplatform implementation only).
> > > > 
> > > > Compared to v2,
> > > > 
> > > > - the Marzen and Lager adv7123 DT nodes have been renamed to vga-encoder
> > > > 
> > > > - the Marzen and Lager adv7123 DT nodes now correctly set the "reg"
> > > > property in their port subnodes.
> > > > 
> > > > Compared to v1,
> > > > 
> > > > - support for the external LVDS panel commonly used with the three
> > > > boards has been moved to a separate file (r8a77xx-aa104xd12-panel.dtsi)
> > > > that can be included at the end of the Marzen, Lager or Koelsch DTS
> > > > 
> > > > - the DU DT nodes have been renamed to "display"
> > > > 
> > > > - the s/remote/remove/ typo has been fixed in commit messages.
> > > > 
> > > > The first three patches add the DU nodes to the SoC .dtsi files. Patch
> > > > 04 adds the panel .dtsi. Patches 05 enables the DU device in DT for the
> > > > Marzen board, and patches 06 to 09 perform the same operation for the
> > > > Lager and Koelsch boards, removing the C code DU platform device in the
> > > > process.
> > > > 
> > > > Please note that HDMI output isn't supported yet, another patch set will
> > > > come in the next few days.
> > > > 
> > > > The patches are based on top of the DU changes from the "[PATCH 00/16]
> > > > R-Car Display Unit DT bindings" series that will be merged in v3.18.
> > > > This series is thus targeted at v3.19. Fast-tracking it to v3.18 is
> > > > still possible if desired, in which case I would need to ask Dave
> > > > Airlie to provide a stable branch with the driver changes. The clock is
> > > > ticking, if anyone would like DU DT in v3.18, speak now or forever hold
> > > > your peace.
> > > > 
> > > > I've pushed a test branch that includes all patches to
> > > > 
> > > > 	git://linuxtv.org/pinchartl/fbdev.git drm/du/dt
> > > 
> > > Thanks for this, I'm very happy to see these changes.
> > > 
> > > Now that v3.18-rc1 is part of my devel tree could you consider
> > > rebasing these patches?
> 
> Done.

Thanks.

> > If it is appropriate could you also consider an shmobile_defconfig
> > update to accompany this series.
> 
> The rcar-du-drm driver is already enabled in shmobile_defconfig.

Thanks, got it.
