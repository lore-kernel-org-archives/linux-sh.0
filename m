From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 08 Apr 2014 14:24:43 +0000
Subject: Re: [PATCH 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <13971645.xg9uykBgs8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk> <1756954.RD74mEdSeA@avalon> <5343FFCF.6040809@codethink.co.uk>
In-Reply-To: <5343FFCF.6040809@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

Hi Ben,

On Tuesday 08 April 2014 14:55:27 Ben Dooks wrote:
> On 08/04/14 14:22, Laurent Pinchart wrote:
> > Hi Ben
> > 
> > Thank you for the patch.
> > 
> > On Monday 07 April 2014 21:07:02 Ben Dooks wrote:
> >> Add the DMA resource IDs for the R8A7790 Audio and SYS DMA controllers
> >> for use when specifying DMA handles.
> >> 
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >> 
> >>  include/dt-bindings/dma/r8a7790-dma.h | 223 +++++++++++++++++++++++++++
> >>  1 file changed, 223 insertions(+)
> >>  create mode 100644 include/dt-bindings/dma/r8a7790-dma.h
> >> 
> >> diff --git a/include/dt-bindings/dma/r8a7790-dma.h
> >> b/include/dt-bindings/dma/r8a7790-dma.h new file mode 100644
> >> index 0000000..7c52132
> >> --- /dev/null
> >> +++ b/include/dt-bindings/dma/r8a7790-dma.h
> >> @@ -0,0 +1,223 @@
> >> +/*
> >> + * R8A7790 System and Audio DMA channel resource identifiers
> >> + *
> >> + * Copyirght (c) 2014 Codethink Ltd.
> >> + *	Ben Dooks <ben.dooks@codethink.co.uk>
> >> + *
> >> + * Licensed under GPLv2
> >> +*/
> >> +
> >> +/* System DMAC */
> >> +
> >> +#define R8A7790_DMA_SCIFA0_TX	(0x21)
> > 
> > Do we really need parentheses ? Also, doesn't the kernel favor lower-case
> > hex values ?
> 
> Parentheses are useful to stop accidental concatenation so I like them and
> would prefer them to stay.

I'd say that if you write

R8A7790_DMA_SCIFA0_TX##R8A7790_DMA_SCIFA0_RX

in your .dts file you deserve concatenation :-)

I'm all in favor of parentheses in macro definitions for "complex" macros that 
involve operators for instance, but when the macro expands to a single token 
that's less useful (and not used in most kernel source files) 

> Not sure on the case for the hex constants.

It might just be me.

$ find include -type f -name \*.h -exec grep "^#define.*0x[0-9]*[a-f][0-9a-
f]*[^0-9a-fA-F]" {} \; | wc
   2237   16646  132688
$ find include -type f -name \*.h -exec grep "^#define.*0x[0-9]*[A-F][0-9A-
F]*[^0-9a-fA-F]" {} \; | wc
   2424   17768  159828

Close to a draw. For DT headers, however,

$ find include/dt-bindings/ -type f -name \*.h -exec grep 
"^#define.*0x[0-9]*[a-f][0-9a-f]*[^0-9a-fA-F]" {} \; | wc
     51     388    2870
$ find include/dt-bindings/ -type f -name \*.h -exec grep 
"^#define.*0x[0-9]*[A-F][0-9A-F]*[^0-9a-fA-F]" {} \; | wc
      0       0       0

That might not be very significant though.

-- 
Regards,

Laurent Pinchart

