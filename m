From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Sep 2014 00:41:05 +0000
Subject: Re: [PATCH v2 08/10] clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings
Message-Id: <20140903004105.GI23704@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 02, 2014 at 05:21:13PM -0700, Mike Turquette wrote:
> Quoting Simon Horman (2014-09-02 16:56:04)
> > On Tue, Sep 02, 2014 at 11:13:04AM +0200, Ulrich Hecht wrote:
> > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Mike, could you consider picking this up?
> 
> I had a question about patch 9/10. My mailer seems to have messed up the
> Cc list but it managed to hit the list[0].

Hi Mike,

Thanks, I agree there seem to be some outstanding questions
regarding that patch. However, I believe although it is not
clear from the arrangement of this patchset that this patch is entirely
independent of 9/10 and can be considered separately.

> 
> Regards,
> Mike
> 
> [0] http://lkml.kernel.org/r/<20140902224500.5251.83168@quantum>
> 
> > 
> > > ---
> > >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > index 8a92b5f..8f1424f 100644
> > > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > > @@ -11,9 +11,11 @@ Required Properties:
> > >  
> > >    - compatible: Must be one of the following
> > >      - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
> > > +    - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate clocks
> > >      - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
> > >      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
> > >      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> > > +    - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
> > >      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> > >    - reg: Base address and length of the I/O mapped registers used by the MSTP
> > >      clocks. The first register is the clock control register and is mandatory.
> > > -- 
> > > 1.8.4.5
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
