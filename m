From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Jun 2010 06:19:45 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh7367: modify IrDA clock
Message-Id: <AANLkTikS50T9SzqmqtHWVUrzCp0I2oP9xWXvqBntbVBq@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p8w6qulxd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p8w6qulxd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Paul and Morimoto-san,

Thanks for your work on this!

On Tue, Jun 8, 2010 at 2:53 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Jun 08, 2010 at 02:34:55PM +0900, Kuninori Morimoto wrote:
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>> =A0arch/arm/mach-shmobile/clock-sh7367.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmob=
ile/clock-sh7367.c
>> index b6454c9..98024eb 100644
>> --- a/arch/arm/mach-shmobile/clock-sh7367.c
>> +++ b/arch/arm/mach-shmobile/clock-sh7367.c
>> @@ -322,7 +322,7 @@ static struct clk_lookup lookups[] =3D {
>> =A0 =A0 =A0 CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[SYMSTP000]), /* SCIFA4 =
*/
>> =A0 =A0 =A0 CLKDEV_DEV_ID("sh_siu", &mstp_clks[SYMSTP231]), /* SIU */
>> =A0 =A0 =A0 CLKDEV_CON_ID("cmt1", &mstp_clks[SYMSTP229]), /* CMT10 */
>> - =A0 =A0 CLKDEV_DEV_ID("sh_irda", &mstp_clks[SYMSTP225]), /* IRDA */
>> + =A0 =A0 CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[SYMSTP225]), /* IRDA */
>> =A0 =A0 =A0 CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[SYMSTP223]), /* =
IIC1 */
>> =A0 =A0 =A0 CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[SYMSTP222]), /* U=
SBHS */
>> =A0 =A0 =A0 CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[SYMSTP222]), /* U=
SBHS */
>
> Can we just fix the sh_irda driver to do clock lookups properly?

Morimoto-san,

In this case please just adjust the irda platform data for SH-Mobile
ARM and pass a -1 as id instead of 0.

Cheers,

/ magnus
