From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 24 May 2010 03:49:25 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: ap4evb: Add FSI2 support
Message-Id: <AANLkTinIkfFu6h1GYkpg0mjzK7gAIgGwtMWuvSPS_pOY@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3wmt65q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your work on this!

On Sun, May 23, 2010 at 9:55 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
> o <asm/clock.h> -> <linux/sh_clk.h>
> o use evt2irq for IRQ number
> o modify clock-sh7372.c for FSI
> o add tiny document
>
> =A0arch/arm/mach-shmobile/board-ap4evb.c | =A0138 +++++++++++++++++++++++=
+++++++++-
> =A0arch/arm/mach-shmobile/clock-sh7372.c | =A0 =A07 +-
> =A02 files changed, 139 insertions(+), 6 deletions(-)

[snip]

> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobi=
le/clock-sh7372.c
> index f2f9a4a..b8194c1 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -246,7 +246,7 @@ enum { MSTP001,
> =A0 =A0 =A0 =A0MSTP106, MSTP101, MSTP100,
> =A0 =A0 =A0 =A0MSTP223,
> =A0 =A0 =A0 =A0MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP=
200,
> - =A0 =A0 =A0 MSTP329, MSTP323, MSTP322, MSTP314, MSTP313,
> + =A0 =A0 =A0 MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313,
> =A0 =A0 =A0 =A0MSTP415, MSTP410, MSTP411, MSTP406, MSTP403,
> =A0 =A0 =A0 =A0MSTP_NR };
>
> @@ -274,6 +274,7 @@ static struct clk mstp_clks[MSTP_NR] =3D {
> =A0 =A0 =A0 =A0[MSTP201] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), =
/* SCIFA3 */
> =A0 =A0 =A0 =A0[MSTP200] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), =
/* SCIFA4 */
> =A0 =A0 =A0 =A0[MSTP329] =3D MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
> + =A0 =A0 =A0 [MSTP328] =3D MSTP(&div6_clks[DIV6_FSIA], SMSTPCR3, 28, 0),=
 /* FSIA */
> =A0 =A0 =A0 =A0[MSTP323] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0),=
 /* IIC1 */
> =A0 =A0 =A0 =A0[MSTP322] =3D MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0),=
 /* USB0 */
> =A0 =A0 =A0 =A0[MSTP314] =3D MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), =
/* SDHI0 */
> @@ -324,8 +325,6 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
> - =A0 =A0 =A0 CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FSIA]),
> - =A0 =A0 =A0 CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FSIB]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
> @@ -356,6 +355,8 @@ static struct clk_lookup lookups[] =3D {
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 =
*/
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 =
*/
> =A0 =A0 =A0 =A0CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
> + =A0 =A0 =A0 CLKDEV_CON_ID("fsia_clk", &mstp_clks[MSTP328]), /* FSI-A */
> + =A0 =A0 =A0 CLKDEV_CON_ID("fsib_clk", &mstp_clks[MSTP328]), /* FSI-B */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* =
IIC1 */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* U=
SB0 */
> =A0 =A0 =A0 =A0CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* U=
SB0 */

Are you sure about the two hunks above? It looks like you change the
code to let "fsia_clk" and "fsib_clk" he gated through the MSTP. The
MSTP bit should be controlled using CLKDEV_DEV_ID() and the platform
device name.

Cheers,

/ magnus
