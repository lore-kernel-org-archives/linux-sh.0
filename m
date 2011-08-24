From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Aug 2011 09:20:26 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings
Message-Id: <CANqRtoSx=8eTk-2Kxq=vnAVA7w4P0Eh_Kde7Te2+zZ36jsJOeA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Aug 24, 2011 at 11:44 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> USB-DMAC1 needs SMSTPCR4/MSTP407 controls, not MSTP214
>
> Reported-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Thanks for your work on this. Please make sure the code is well tested.

> @@ -558,6 +558,7 @@ static struct clk mstp_clks[MSTP_NR] =3D {
> =A0 =A0 =A0 =A0[MSTP413] =3D MSTP(&pllc1_div2_clk, SMSTPCR4, 13, 0), /* H=
DMI */
> =A0 =A0 =A0 =A0[MSTP411] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0),=
 /* IIC3 */
> =A0 =A0 =A0 =A0[MSTP410] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0),=
 /* IIC4 */
> + =A0 =A0 =A0 [MSTP407] =3D MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 7, 0), /*=
 USBDMAC */
> =A0 =A0 =A0 =A0[MSTP406] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), =
/* USB1 */
> =A0 =A0 =A0 =A0[MSTP403] =3D MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
> =A0};

Nit: s/USBDMAC/USB-DMAC0/g

> @@ -635,7 +636,7 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* =
DMAC2 */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-dma-engine.2", &mstp_clks[MSTP216]), /* =
DMAC3 */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-dma-engine.3", &mstp_clks[MSTP214]), /* =
USB-DMAC0 */
> - =A0 =A0 =A0 CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP214]), /* U=
SB-DMAC1 */
> + =A0 =A0 =A0 CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP407]), /* U=
SB-DMAC1 */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 =
*/
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 =
*/

This should follow the same order as above. Please move down MSTP407
next to the other MSTP4xx bits.

Thanks,

/ magnus
