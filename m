From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Nov 2013 01:00:46 +0000
Subject: Re: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
Message-Id: <2305074.dSYTpfKiqG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <3394178.9T7q17vczr@avalon> <87li0zrc3m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0zrc3m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Morimoto-san,

On Thursday 07 November 2013 16:06:29 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > Sure, if the hardware is very similar, it makes sense to share code. I've
> > had a quick look at the M2 documentation, and it seems to be indeed
> > mostly identical to H2. Only a couple of clocks are missing, and a new
> > GPU clock register is documented. As the GPU clock is mentioned in the H2
> > documentation as being programmable I would assume that the GPU clock
> > register exists and is identical in H2 but has been forgotten in the
> > documentation.
> > 
> > We should probably extend clock-r8a7790.c with M2 support and rename it to
> > clock-rcar-gen2.c before pushing it to mainline. Would you like to submit
> > a patch ? :-)
> 
> Thank yor for your agreement.
> I don't want to send "rename patch",
> please consider it in your v2 patch if possible :P

We also need to take into account that the two SoCs will have a different 
number of clocks. I'm thus inclined to replace the index-based switch 
statement by a similar construct that will match on the clock name instead. Do 
you have any opinion on that ?

-- 
Regards,

Laurent Pinchart

