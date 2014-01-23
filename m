From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 23 Jan 2014 11:31:27 +0000
Subject: Re: [RFC/PATCH 1/7] drm/rcar-du: Add OF support
Message-Id: <3739709.HlpN7KneJZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1390318362-29954-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CANqRtoQQ45w1EroyfbWSFtWQVdg-YyPVPWpGTvFmCXqoDZhpQA@mail.gmail.com>
In-Reply-To: <CANqRtoQQ45w1EroyfbWSFtWQVdg-YyPVPWpGTvFmCXqoDZhpQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, SH-Linux <linux-sh@vger.kernel.org>, dri-devel@lists.freedesktop.org

Hi Magnus,

On Thursday 23 January 2014 18:52:29 Magnus Damm wrote:
> On Wed, Jan 22, 2014 at 12:32 AM, Laurent Pinchart wrote:
> > Add DT bindings for the R-Car DU with support for core resources
> > (memory, IRQ and clocks). Output configuration must still be passed
> > through platform data using OF_DEV_AUXDATA.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/video/renesas,du.txt       |  49 +++++++
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c              | 161 +++++++++-------
> > 2 files changed, 138 insertions(+), 72 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/video/renesas,du.txt
> 
> Hi Laurent,
> 
> Thanks for your patches. I have some minor comments related to r8a7790
> vs r8a7791, please see below.
> 
> > diff --git a/Documentation/devicetree/bindings/video/renesas,du.txt
> > b/Documentation/devicetree/bindings/video/renesas,du.txt new file mode
> > 100644
> > index 0000000..6bd947c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/renesas,du.txt
> > @@ -0,0 +1,49 @@
> > +* Renesas R-Car Display Unit (DU)
> > +
> > +Required Properties:
> > +
> > +  - compatible: must be one of the following.
> > +    - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
> > +    - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
> > +    - "renesas,du-r8a7790" for R8A7791 (R-Car M2) compatible DU
> 
> I suppose the last line above should be "renesas,du-r8a7791", right?
> 
> > +  - reg: A list of base address and length of each memory resource, one
> > for
> > +    each entry in the reg-names property.
> > +  - reg-names: Name of the memory resources. The DU requires one memory
> > +    resource for the DU core (named "du") and one memory resource for
> > each
> > +    LVDS encoder (named "lvds.x" with "x" being the LVDS controller
> > numerical
> > +    index).
> > +
> > +  - interrupt-parent: phandle of the parent interrupt controller.
> > +  - interrupts: Interrupt specifiers for the DU interrupts.
> > +
> > +  - clocks: A list of phandles + clock-specifier pairs, one for each
> > entry in
> > +    the clock-names property.
> > +  - clock-names: Name of the clocks. This property is model-dependent.
> > +    - R8A7779 uses a single functional clock. The clock doesn't need to
> > be
> > +      named.
> > +    - R8A7790 and R8A7790 use one functional clock per channel and one
> > clock
> > +      per LVDS encoder. The functional clocks must be named "du.x" with
> > "x"
> > +      being the channel numerical index. The LVDS clocks must be named
> > +      "lvds.x" with "x" being the LVDS encoder numerical index.
> 
> "R8A7790 and R8A7791"...?

I'll fix both in the next version.

-- 
Regards,

Laurent Pinchart

