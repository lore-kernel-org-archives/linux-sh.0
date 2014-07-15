From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 15 Jul 2014 23:12:14 +0000
Subject: Re: [PATCH 6/7] ARM: shmobile: r8a7790: Add DMAC devices to DT
Message-Id: <12241886.LU9xPaZdx9@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 16 July 2014 08:06:15 Nobuhiro Iwamatsu wrote:
> 2014-07-16 7:52 GMT+09:00 Laurent Pinchart:
> > On Wednesday 16 July 2014 07:49:15 Nobuhiro Iwamatsu wrote:
> >> 2014-07-16 5:18 GMT+09:00 Laurent Pinchart:
> >> > Instantiate the two system DMA controllers in the r8a7790 device tree.
> >> > 
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >> > ---
> >> > 
> >> > arch/arm/boot/dts/r8a7790.dtsi | 59 ++++++++++++++++++++++++++++++++++
> >> > 1 file changed, 59 insertions(+)
> >> > 
> >> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> >> > b/arch/arm/boot/dts/r8a7790.dtsi index 220662f..0f15f7c 100644
> >> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> >> > @@ -217,6 +217,65 @@
> >> >                              <0 3 IRQ_TYPE_LEVEL_HIGH>;
> >> >         };
> >> > 
> >> > +       dmac0: dma-controller@e6700000 {
> >> > +               compatible = "renesas,rcar-dmac";
> >> > +               reg = <0 0xe6700000 0 0x20000>;
> >> > +               interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 200 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 201 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 202 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 203 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 204 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 205 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 206 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 207 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 208 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 209 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 210 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 211 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 212 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 213 IRQ_TYPE_LEVEL_HIGH
> >> > +                             0 214 IRQ_TYPE_LEVEL_HIGH>;
> >> > +               interrupt-names = "error",
> >> > +                               "ch0", "ch1", "ch2", "ch3",
> >> > +                               "ch4", "ch5", "ch6", "ch7",
> >> > +                               "ch8", "ch9", "ch10", "ch11",
> >> > +                               "ch12", "ch13", "ch14", "ch15";
> >> > +               clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
> >> > +               clock-names = "fck";
> >> > +               #dma-cells = <1>;
> >> > +               dma-channels = <15>;
> >> > +       };
> >> 
> >> I think  that  dma-channels should be set to 16.
> > 
> > The r8a7790 and r8a7791 datasheets document 30 channels, split across two
> > DMA controllers with 15 channels each.
> 
> I see. This is my misunderstand.
> Well, is ch15 unnecessary in interrupt-names?

Indeed, my bad. I'll fix that.

-- 
Regards,

Laurent Pinchart

