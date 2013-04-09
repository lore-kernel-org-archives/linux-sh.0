From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Apr 2013 09:11:38 +0000
Subject: Re: [PATCH 00/02] sh-pfc: Initial r8a7790 PFC support
Message-Id: <3485828.c21o1yJO9t@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130408020834.29957.24249.sendpatchset@w520>
In-Reply-To: <20130408020834.29957.24249.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 09 April 2013 17:59:06 Simon Horman wrote:
> On Mon, Apr 08, 2013 at 11:18:11AM +0200, Laurent Pinchart wrote:
> > Hi Magnus,
> > 
> > Thanks for the patches.
> > 
> > On Monday 08 April 2013 11:08:34 Magnus Damm wrote:
> > > sh-pfc: Initial r8a7790 PFC support
> > > 
> > > [PATCH 01/02] ARM: shmobile: Add second I/O range for r8a7790 PFC
> > > [PATCH 02/02] sh-pfc: Initial r8a7790 PFC support
> > > 
> > > This mini-series contains initial support for the r8a7790 PFC.
> > > Incremental future changes will move over to PINCTRL.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > For the whole series,
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> 01/02: Queued up in the soc-r8a7790 branch
> 02/02: Queued up in the pinmux branch

Will you push these to v3.10 or v3.11 ? If v3.10, I'd really like my follow-up 
patch series to go in at the same time, otherwise people will start writing 
board code on the outdated function GPIO API.

-- 
Regards,

Laurent Pinchart

