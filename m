From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Aug 2015 06:31:11 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: bockw dts: enable SMSC interrupt
Message-Id: <20150827063110.GB21875@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 26, 2015 at 02:34:15PM +0200, Geert Uytterhoeven wrote:
> Hi Uli,
> 
> On Thu, Aug 20, 2015 at 5:45 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > Clears bit 4 in IRQMR0 in the FPGA to enable the SMSC interrupt.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  arch/arm/boot/dts/r8a7778-bockw.dts | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> > index 8a54076..73ba7de 100644
> > --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> > +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> > @@ -65,6 +65,23 @@
> >  };
> >
> >  &bsc {
> > +       fpga@18200000 {
> > +               /* Simplified description that only serves to enable the
> > +                * ethernet controller.
> > +                */
> > +               compatible = "pinctrl-single";
> 
> This needs CONFIG_PINCTRL_SINGLE=y in shmobile_defconfig and
> multi_v7_defconfig, right?

Thanks, with that option enabled I was successfully able to test
this series on top of v4.2-rc1.
