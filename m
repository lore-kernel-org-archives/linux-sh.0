From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 07 Sep 2015 19:43:11 +0000
Subject: Re: [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <7329282.OeGUVITr0v@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062952.24004.17072.sendpatchset@little-apple>
In-Reply-To: <20150831062952.24004.17072.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thursday 03 September 2015 21:03:10 Geert Uytterhoeven wrote:
> On Thu, Sep 3, 2015 at 1:48 PM, Laurent Pinchart wrote:
> > On Thursday 03 September 2015 09:54:17 Geert Uytterhoeven wrote:
> >> On Thu, Sep 3, 2015 at 9:41 AM, Magnus Damm wrote:
> >>> On Mon, Aug 31, 2015 at 10:08 PM, Geert Uytterhoeven wrote:
> >>>> On Mon, Aug 31, 2015 at 2:59 PM, Magnus Damm wrote:
> >
> > [snip]
> > 
> >>>>> But if we're going down that route then may I ask why we have
> >>>>> "-clocks" suffix for the MSTP/CPG compat strings? I'd rather make
> >>>>> them shorter and more similar to the rest of the compat strings on
> >>>>> the SoC.
> >>>> 
> >>>> It uses plural because CPG and MSTP nodes provide more than one clock.
> >>>> 
> >>>> Cfr. DIV6, which provides a single clock, and uses e.g.
> >>>> "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock" (singular).
> >>> 
> >>> Ok, thanks but my concern was not about singular vs plural.
> >>> Why do we need the "-clocks" suffix?
> >>> 
> >>> It's a detail, but for me the shorter "renesas,r8a7795-mstp" makes
> >>> more sense than "renesas,r8a7795-mstp-clocks"
> >> 
> >> The MSTP blocks are subsets of the CPG block, and their registers are
> >> heavily entangled with other registers inside the CPG and other MSTP
> >> blocks. So currently the MSTP nodes don't represent the MSTP blocks, but
> >> their clocks only (and not e.g. reset control).
> >> 
> >> I'm afraid the only sane way to express their full functionality is to
> >> have a single cpg_mstp node...
> > 
> > That might be a good idea. We could just use two clock cells and hide all
> > the dirty details in C code. Anyone wants to give it a try ? :-)
> 
> I think we have to keep at least the references to the parent clocks of the
> MSTP clocks in DT, as many of them are instantiated from DT (fixed-factor,
> div6, ...) instead of the renesas,<soc>-cpg-clocks C code.

We could use clock-indices for that, although it might quickly become ugly. 
And it would require removing the hardcoded assumption in the CCF core that 
the number of clock cells is 1 at most.

-- 
Regards,

Laurent Pinchart

