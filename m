From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 13 Feb 2015 08:39:13 +0000
Subject: Re: [PATCH v2 0/6] Renesas R-Car DMAC fixes
Message-Id: <20150213082712.GO21387@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422576013-7846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422576013-7846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 13, 2015 at 04:51:01AM +0200, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Thursday 12 February 2015 14:59:36 Vinod Koul wrote:
> > On Fri, Jan 30, 2015 at 02:00:07AM +0200, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > Here are a couple of fixes for the rcar-dmac driver. They're based on the
> > > next branch of the dmaengine tree.
> > > 
> > > The first four patches fix driver bugs, while the last two work around two
> > > hardware issues. Patch 5 works around a documented errata, while patch 6
> > > handles a data corruption issue that was noticed during test but not yet
> > > confirmed to be a hardware bug by Renesas. When more information about the
> > > issue will be available a better fix could possibly be developed.
> > > 
> > > The patches are available at
> > > 
> > > 	git://linuxtv.org/pinchartl/fbdev.git dma/upstream
> > > 
> > > Vinod, is there still time for a v3.20 pull request ?
> > 
> > Since this is fixes I was trying to merge them before I send to Linus in
> > next few days, but this fails to apply for me :(
> > 
> > I have merged everything into my for-linus which will be sent to him. Or you
> > can send later and we can get this into fixes
> 
> I've rebased my branch on your for-linus branch and pushed the result to
> 
> 	git://linuxtv.org/pinchartl/fbdev.git dma/upstream
Since I had to modify my branch, i ended up cherrypicking. So all these are
in my queue now.

Thanks

-- 
~Vinod

