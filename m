From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 21 Feb 2014 14:04:20 +0000
Subject: Re: Maybe this is CCF bug
Message-Id: <3334595.bHAKMF48WS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87zjlkq1v1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Friday 21 February 2014 13:42:10 Ben Dooks wrote:
> On 21/02/14 13:30, Laurent Pinchart wrote:
> > Hi Morimoto-san,
> > 
> > (CC'ing Mike and Ben)
> > 
> > On Friday 21 February 2014 11:20:06 Geert Uytterhoeven wrote:
> >> On Fri, Feb 21, 2014 at 9:58 AM, Kuninori Morimoto wrote:
> >>> Now, I'm working for sound DT support,
> >>> and I noticed common clock setting's strange behavior.
> >>> I guess this is bug, but 50% my misunderstanding.
> >>> 
> >>> Now, we have clock index on
> >>> ${LINUX}/include/dt-bindings/clock/r8a7790-clock.h For example,
> >>> r8a7790's
> >>> MSTP9 case, like this
> >>> 
> >>>          /* MSTP9 */
> >>>          #define R8A7790_CLK_GPIO5               7
> >>>          #define R8A7790_CLK_GPIO4               8
> >>>          #define R8A7790_CLK_GPIO3               9
> >>>          #define R8A7790_CLK_GPIO2               10
> >>>          #define R8A7790_CLK_GPIO1               11
> >>>          #define R8A7790_CLK_GPIO0               12
> >>>          #define R8A7790_CLK_RCAN1               15
> >>>          #define R8A7790_CLK_RCAN0               16
> >>>          #define R8A7790_CLK_QSPI_MOD            17
> >>>          #define R8A7790_CLK_IICDVFS             26
> >>>          #define R8A7790_CLK_I2C3                28
> >>>          #define R8A7790_CLK_I2C2                29
> >>>          #define R8A7790_CLK_I2C1                30
> >>>          #define R8A7790_CLK_I2C0                31
> >>> 
> >>> and MSTP9 is like this
> >>> 
> >>>          mstp9_clks: mstp9_clks@e6150994 {
> >>>          
> >>>                  compatible = "renesas,r8a7790-mstp-clocks",
> >>>                  "renesas,cpg-mstp-clocks";
> >>>                  reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
> >>>                  clocks = <&p_clk>, <&p_clk>, <&cpg_clocks
> >>>                  R8A7790_CLK_QSPI>,
> >>>                           <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
> >>>                  
> >>>                  #clock-cells = <1>;
> >>>                  renesas,clock-indices = <
> >>>                          R8A7790_CLK_RCAN1 R8A7790_CLK_RCAN0
> >>>                          R8A7790_CLK_QSPI_MOD
> >>>                          R8A7790_CLK_I2C3 R8A7790_CLK_I2C2
> >>>                          R8A7790_CLK_I2C1
> >>>                          R8A7790_CLK_I2C0
> >>>                  >;
> >>>                  
> >>>                  clock-output-names > >>>                          "rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2",
> >>>                          "i2c1", "i2c0";
> >>>          };
> >>> 
> >>> And, now, spi parent is MSTP9 QSPI MOD
> >>> 
> >>>          spi: spi@e6b10000 {
> >>>                  ...
> >>>                  clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
> >>>                  ...
> >>>          };
> >>> 
> >>> This SPI would like to use MSTP9's 17th (= R8A7790_CLK_QSPI_MOD) clock
> >>> as its parent. But, mstp9_clks has 7 clocks only.
> >>> R8A7790_CLK_xxx means "bit shift", not "index" on DT clock.
> >> 
> >> Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt says:
> >>      The MSTP groups are sparsely populated. Unimplemented
> >>      gate clocks must not be declared.
> >>> 
> >>> On ${LINUX}/drivers/clk/shmobile/clk-mstp.c,
> >>> it try to get parent name by
> >>> 
> >>>          parent_name = of_clk_get_parent_name(np, i);
> >>> 
> >>> and it returns "mstp9_clks" in this case.
> >>> Maybe SPI would like to get "qspi_mod" ?
> > 
> > I wouldn't call that a bug in CCF, but it's definitely a non-intuitive
> > behaviour. CCF lets OF clock providers implement their own method to
> > translate clock specifiers into clocks (see the second and third
> > arguments passed to of_clk_add_provider). In practice the vast majority
> > (if not all) of the drivers implementing support for multiple clocks use
> > an index as their first clock cell. That index can be a direct index into
> > the list of clocks provided by the CCF device, but doesn't have to be. In
> > the case of the clk-mstp driver the first clock cell represents the clock
> > hardware index, which is different than the index into the software list
> > of clocks as clocks are sparsely populated.
> > 
> > The of_clk_get_parent_name() function behaves differently. It first looks
> > up the parent clock node in DT and parses the clock specifier cells, and
> > then uses the first cell as a direct index into the clock-names property
> > of the parent clock node. This bypasses the parent clock driver clock
> > lookup mechanism, and thus leads to confusion as the meaning of the clock
> > specifier in DT will depend on whether you're referencing a clock from an
> > end-user driver (which will in that case use clk_get() and go through the
> > clock provider driver for clock lookup), or from another clock provider
> > (which will in that case call of_clk_get_parent_name() and use direct
> > index lookup). This has bitten me several weeks ago when I tried to add
> > SSI clocks to DT. With the MSTP indices defined as
> > 
> > /* MSTP10 */
> > #define R8A7790_CLK_SSI                5
> > #define R8A7790_CLK_SSI9               6
> > #define R8A7790_CLK_SSI8               7
> > #define R8A7790_CLK_SSI7               8
> > #define R8A7790_CLK_SSI6               9
> > #define R8A7790_CLK_SSI5               10
> > #define R8A7790_CLK_SSI4               11
> > #define R8A7790_CLK_SSI3               12
> > #define R8A7790_CLK_SSI2               13
> > #define R8A7790_CLK_SSI1               14
> > #define R8A7790_CLK_SSI0               15
> > 
> > my naive approach was
> > 
> > mstp10_clks: mstp10_clks@e6150998 {
> > 
> >          compatible = "renesas,r8a7790-mstp-clocks",
> >          "renesas,cpg-mstp-clocks";
> >          reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> >          clocks = <&p_clk>, <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>,
> >                   <&mstp10_clks R8A7790_CLK_SSI>;
> >          #clock-cells = <1>;
> >          renesas,clock-indices = <
> >                  R8A7790_CLK_SSI R8A7790_CLK_SSI9 R8A7790_CLK_SSI8
> >                  R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
> >                  R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2
> >                  R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
> >          >;
> >          clock-output-names > >                  "ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
> >                  "ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
> > }
> > 
> > However, this resulted in all SSI clocks but the master one referencing
> > "ssi5" as their parent instead of "ssi".
> > 
> > The simple fix was to change the parent clocks to
> > 
> >          clocks = <&p_clk>, <&mstp10_clks 0>, <&mstp10_clks 0>,
> >                   <&mstp10_clks 0>, <&mstp10_clks 0>, <&mstp10_clks 0>,
> >                   <&mstp10_clks 0>, <&mstp10_clks 0>, <&mstp10_clks 0>,
> >                   <&mstp10_clks 0>, <&mstp10_clks 0>;
> > 
> > I understand this difference in behaviour is necessary, as the parent
> > clock device might not have been probed yet when a child clock driver
> > looks up the parent clock name. We thus can't rely on the parent clock
> > driver to perform the clock specifier to clock translation.
> 
> In this case the problem is worse as even if we could defer clock
> lookups until the driver had been probed, we have a case where this
> is self-referential.
> 
> > Another approach to fix the problem was proposed by Ben Dooks in his
> > "[PATCH 1/3] clk: add clock-indices support" patch series was to
> > standardize the reneses,clock-indices property into a clock-indices
> > property, usable by of_clk_get_parent_name() without requiring the parent
> > clock driver to have probed the device yet. That's more complex but would
> > have the added benefit of making the clock specifier translation
> > consistent, at least in this case. I'm not sure whether we'll always be
> > able to achieve consistency as some exotic clock providers might require
> > a really weird translation mechanism.
>
> I think there is a couple of issues here, the first is that
> of_clk_get_parent_name() exists at-all. It would be nicer just to be able to
> pass a set of 'struct clk *' to the clock registration code. Although this
> may also still have an issue where we cannot use self-referential clocks (I
> added a hack to allow the mstp driver to use sub-nodes for each mstp clock
> group to get around that as a first implementation)
> 
> I have not seen any comments on my clock-indices patch yet, I wonder
> if anyone has had a chance to review it.

From a code point of view your proposal looks nice, what I wonder is whether 
that's the direction we want to take. It would fix the problem in this case, 
but as I've mentioned I'm not sure whether we can solve it generically for all 
providers with exotic requirements.

Mike probably has a wider view of the issue, that's why I'd like him to 
comment on this.

-- 
Regards,

Laurent Pinchart

