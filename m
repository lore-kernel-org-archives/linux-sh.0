From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 May 2010 05:32:44 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <w3pd3wl985f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch

> > @@ -274,6 +274,7 @@ static struct clk mstp_clks[MSTP_NR] = {
> >        [MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
> >        [MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
> >        [MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
> > +       [MSTP328] = MSTP(&div6_clks[DIV6_FSIA], SMSTPCR3, 28, 0), /* FSIA */
> >        [MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
> >        [MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
> >        [MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
> > @@ -324,8 +325,6 @@ static struct clk_lookup lookups[] = {
> >        CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
> >        CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
> >        CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
> > -       CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FSIA]),
> > -       CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FSIB]),
> >        CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
> >        CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
> >        CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
> > @@ -356,6 +355,8 @@ static struct clk_lookup lookups[] = {
> >        CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
> >        CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
> >        CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
> > +       CLKDEV_CON_ID("fsia_clk", &mstp_clks[MSTP328]), /* FSI-A */
> > +       CLKDEV_CON_ID("fsib_clk", &mstp_clks[MSTP328]), /* FSI-B */
> >        CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
> >        CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
> >        CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
> 
> Are you sure about the two hunks above? It looks like you change the
> code to let "fsia_clk" and "fsib_clk" he gated through the MSTP. The
> MSTP bit should be controlled using CLKDEV_DEV_ID() and the platform
> device name.

I understand.

But if I use CLKDEV_DEV_ID, then,
how to change FSI clock to use external clock ?
clk_get seems return ERR_PTR(-ENOENT).


And,
FSI A and B have div6_clks for each,
but MSTP needs just "FSI"

what should I do below ?

> > +       [MSTP328] = MSTP(&div6_clks[DIV6_FSIA], SMSTPCR3, 28, 0), /* FSIA */

Best regards
--
Kuninori Morimoto
