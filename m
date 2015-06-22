From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Jun 2015 08:35:27 +0000
Subject: Re: [PATCH 2/6][RFC] clk: shmobile: CPG write protect register support for MSTP
Message-Id: <28701507.2nYBqlQCe6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87381twp4y.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87381twp4y.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Monday 22 June 2015 01:16:54 Kuninori Morimoto wrote:
> > On Monday 15 June 2015 04:53:30 Kuninori Morimoto wrote:
> > > R-Car Gen3 needs to care about CPG write protect register when driver
> > > driver access to CPG/MSTP.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > 
> > >  .../bindings/clock/renesas,cpg-mstp-clocks.txt           |  3 +++
> > >  drivers/clk/shmobile/clk-mstp.c                          | 16 ++++++++-
> > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > index
> > > 16ed181..d897b13 100644
> > > ---
> > > a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > +++
> > > b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > 
> > > @@ -19,12 +19,15 @@ Required Properties:
> > >      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate
> > > clocks
> > >      - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate
> > > clocks
> > >      - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate
> > > clocks
> > > +    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP
> > > gate clocks
> > >      - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate
> > >      clocks and "renesas,cpg-mstp-clocks" as a fallback.
> > >    
> > >    - reg: Base address and length of the I/O mapped registers used by
> > >    the
> > > 
> > > MSTP clocks. The first register is the clock control register and is
> > > mandatory. The second register is the clock status register and is
> > > optional when not implemented in hardware.
> > > +    The third register is the CPG write protect register and is
> > > optional when
> > > +    not implemented in hardware.
> > 
> > Given that the write protect register is common for all MSTP clocks, I
> > think duplicating it in all MSTP nodes isn't the best solution. I believe
> > we should instead restructure the MSTP DT bindings and move the MSTP
> > nodes as children of the CPG node, and let the CPG handle the write
> > protect register.
> > 
> > Geert, we've discussed this a couple of times before. Have you given it a
> > try ? I don't mind doing it, but I want to avoid duplicating work.
> 
> I don't know detail, but this write protection is for ARM <-> SH.
> I think upstream Linux doesn't need to care about SH ?
> And *maybe* we can disable it. Inami-san will test/check it.
> I think we can re-use current driver if we can disable it.
> But, what do you think ?

I think that's a good idea. Let's disable write protect for now, and implement 
support for it later if needed.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
