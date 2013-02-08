From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 08 Feb 2013 00:17:21 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <87vca3y7zo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1359596703-17556-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<87txpozr28.wl%kuninori.morimoto.gx@renesas.com>
	<2069640.rTxqgDbF3Q@avalon>
In-Reply-To: <2069640.rTxqgDbF3Q@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com


Hi Laurent

> > > Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
> > > and DU1 LVDS outputs will require information about the panels that will
> > > be connected to those outputs.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/mach-shmobile/board-marzen.c | 65 ++++++++++++++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > 
> > It is very helpfull if this patch or additional patch has RCAR_DU defconfig
> > for marzen
> 
> Very good point. I will include that in the next version. Thank you.

Nice !
Thank you

Best regards
---
Kuninori Morimoto
