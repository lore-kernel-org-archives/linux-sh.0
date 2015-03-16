From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Mar 2015 23:10:19 +0000
Subject: Re: [RFC/PATCH v2] ARM: shmobile: Consolidate the pm code for R-Car Gen2
Message-Id: <20150316231018.GA15463@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <55066EBB.8060301@bp.renesas.com>
In-Reply-To: <55066EBB.8060301@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 16, 2015 at 03:33:38PM +0100, Geert Uytterhoeven wrote:
> Hi Inami-san,
> 
> On Mon, Mar 16, 2015 at 6:48 AM, Gaku Inami
> <gaku.inami.xw@bp.renesas.com> wrote:
> > The pm code for R-Car Gen2 is scatterd in each SoC. These files
> > (pm-r8a7790.c/pm-r8a7791.c) have some overlap code. This change
> > consolidate the pm code for R-Car Gen2 into one.
> >
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > ---
> >
> > Changes since version 1:
> > - Fixed copyright.
> > - Added the argument of syscier to rcar_gen2_sysc_init().
> > - Changed the variable name.(has_a15/has_a7)
> 
> Thanks for the update!
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up in a shiny new pm-for-v4.1 branch.
