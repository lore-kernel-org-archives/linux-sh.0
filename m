From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Dec 2014 01:16:31 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Handle hardware descriptor allocation failure
Message-Id: <87r3w79ea0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416924617-15939-1-git-send-email-j@bitron.ch>
	<20141208175044.GT16827@intel.com>
	<20141209063912.GZ16827@intel.com>
	<2735456.CKbC358ZrM@avalon>
In-Reply-To: <2735456.CKbC358ZrM@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon Horman <horms+renesas@verge.net.au>, =?ISO-2022-JP-2?B?ShskKEQrZBsoQnJn?= Billeter <j@bitron.ch>, Magnus Damm <damm+renesas@opensource.se>, Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org


Hi Laurent

> > On Mon, Dec 08, 2014 at 11:20:44PM +0530, Vinod Koul wrote:
> > > On Mon, Dec 08, 2014 at 07:40:15PM +0200, Laurent Pinchart wrote:
> > > > > > [GIT PULL FOR v3.19] R-Car DMA engine driver
> > > > > > http://www.spinics.net/lists/linux-sh/msg37764.html
> > > > > 
> > > > > And I dont seem to have this request in my Inbox :(
> > > > > Yes I do see it in archieves, so not sure how this is not present, not
> > > > > sure if the servers mangeled it!!
> > > > 
> > > > I haven't CC'ed you, I'll make sure to do so next time. The mail should
> > > > still have reached you through the mailing list though (I assume you're
> > > > subscribed to dmaengine@vger.kernel.org ;-)).
> > > 
> > > Yes I am, so should have reached me even though i wasnt cced
> > > I do see email reaching me from list without me being in CC, but then it
> > > wont hit my inbox and go to ML folder :)
> > > So generally its a good practice to CC relvant folks, lots of folks do ask
> > > that if ML is high volume
> > 
> > Hey Laurent,
> > 
> > I see that the oddity in commitlogs with change since artifacts after SOB,
> > can you please fix that up
> 
> My bad. I've fixed the problem and pushed the result to the same branch
> 
> 	git://linuxtv.org/pinchartl/fbdev.git dma/next
> 
> The only difference lies in the commit logs.

If my understanding was correct, we need to be based on Vinod's
topic/slave_caps_device_control_fix

Best regards
---
Kuninori Morimoto
