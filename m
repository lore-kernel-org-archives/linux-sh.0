From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 19 Apr 2012 02:10:12 +0000
Subject: Re: [PATCH] i2c: Add support SuperH SH7734 I2C bus controller
Message-Id: <CABMQnV+B-FsHr7Rdk2HS793CCfF3yzesEmgos12hxJhRBqVGUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334188641-14641-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <CAM=Q2ctB9FDOd3-wJ7Xf5v0HEPFZ8-Wc3f8tstQ8+8Wu-cfcbg@mail.gmail.com>
In-Reply-To: <CAM=Q2ctB9FDOd3-wJ7Xf5v0HEPFZ8-Wc3f8tstQ8+8Wu-cfcbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

Thanks for your review.

2012/4/16 Shubhrajyoti Datta <omaplinuxkernel@gmail.com>:
> Hi ,
> Few comments,
>
>
> On Thu, Apr 12, 2012 at 5:27 AM, Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com> wrote:
>> This is the SuperH SH7734 I2C Controller Driver.
>> A simple Master only support driver for the I2C included in processors S=
H7734 only.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0| =A0 =A09 +
>> =A0drivers/i2c/busses/Makefile =A0 =A0 | =A0 =A01 +
>> =A0drivers/i2c/busses/i2c-sh7734.c | =A0721 ++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 731 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/i2c/busses/i2c-sh7734.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index d2c5095..68d3181 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -634,6 +634,15 @@ config I2C_SH_MOBILE
>> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, =
the module
>> =A0 =A0 =A0 =A0 =A0will be called i2c-sh_mobile.
>>
>> +config I2C_SH7734
>> + =A0 =A0 =A0 tristate "Renesas SH7734 I2C Controller"
>> + =A0 =A0 =A0 depends on CPU_SUBTYPE_SH7734
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This driver supports the I2C interfaces on the Renesas=
 SH7734.
>> +
>> + =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, t=
he module
>> + =A0 =A0 =A0 =A0 will be called i2c-sh7734.
>> +
>> =A0config I2C_SIMTEC
>> =A0 =A0 =A0 =A0tristate "Simtec Generic I2C interface"
>> =A0 =A0 =A0 =A0select I2C_ALGOBIT
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 569567b..b7057f5 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -63,6 +63,7 @@ obj-$(CONFIG_I2C_S3C2410) =A0 =A0 +=3D i2c-s3c2410.o
>> =A0obj-$(CONFIG_I2C_S6000) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D i2c-s6000=
.o
>> =A0obj-$(CONFIG_I2C_SH7760) =A0 =A0 =A0 +=3D i2c-sh7760.o
>> =A0obj-$(CONFIG_I2C_SH_MOBILE) =A0 =A0+=3D i2c-sh_mobile.o
>> +obj-$(CONFIG_I2C_SH7734) =A0 =A0 =A0 +=3D i2c-sh7734.o
>> =A0obj-$(CONFIG_I2C_SIMTEC) =A0 =A0 =A0 +=3D i2c-simtec.o
>> =A0obj-$(CONFIG_I2C_SIRF) =A0 =A0 =A0 =A0 +=3D i2c-sirf.o
>> =A0obj-$(CONFIG_I2C_STU300) =A0 =A0 =A0 +=3D i2c-stu300.o
>> diff --git a/drivers/i2c/busses/i2c-sh7734.c b/drivers/i2c/busses/i2c-sh=
7734.c
>> new file mode 100644
>> index 0000000..89e37d0
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-sh7734.c
>> @@ -0,0 +1,721 @@
>> +/*
>> + * SuperH SH7734 I2C Controller
>> + *
>> + * Copyright (C) 2008 Magnus Damm
>> + * Copyright (C) 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.c=
om>
>> + * Copyright (C) 2012 Renesas Solutions Corp.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General =
Public
>> + * License. =A0See the file "COPYING" in the main directory of this arc=
hive
>> + * for more details.
>> + *
>> + * Based on drivers/i2c/busses/i2c-sh_mobile.c.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/i2c.h>
>> +#include <linux/err.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/i2c/i2c-sh_mobile.h>
>> +
>> +enum sh7734_i2c_op {
>> + =A0 =A0 =A0 OP_START_TRS =3D 0,
>> + =A0 =A0 =A0 OP_START_SCP,
>> + =A0 =A0 =A0 OP_TX_FIRST,
>> + =A0 =A0 =A0 OP_TX_FIRST_END,
>> + =A0 =A0 =A0 OP_TX,
>> + =A0 =A0 =A0 OP_TX_END,
>> + =A0 =A0 =A0 OP_TX_STOP,
>> + =A0 =A0 =A0 OP_TX_STOP_CHK,
>> + =A0 =A0 =A0 OP_TX_FINISH,
>> + =A0 =A0 =A0 OP_RX,
>> + =A0 =A0 =A0 OP_RX_BBSY_CLR,
>> + =A0 =A0 =A0 OP_RX_LAST_DATA,
>> + =A0 =A0 =A0 OP_RX_FINISH,
>> + =A0 =A0 =A0 OP_RX_STOP,
>> + =A0 =A0 =A0 OP_RX_STOP_CHK,
>> +};
>> +
>> +struct sh7734_i2c_data {
>> + =A0 =A0 =A0 struct device *dev;
>> + =A0 =A0 =A0 void __iomem *reg;
>> + =A0 =A0 =A0 struct i2c_adapter adap;
>> + =A0 =A0 =A0 unsigned long bus_speed;
>> + =A0 =A0 =A0 struct clk *clk;
>> + =A0 =A0 =A0 u_int8_t nf2cyc;
>> + =A0 =A0 =A0 u_int8_t nf2cyc_clk;
>> + =A0 =A0 =A0 u_int8_t iccr1_clk;
>> + =A0 =A0 =A0 spinlock_t lock;
>> + =A0 =A0 =A0 wait_queue_head_t wait;
>> + =A0 =A0 =A0 struct i2c_msg *msg;
>> + =A0 =A0 =A0 int pos;
>> + =A0 =A0 =A0 int sr;
>> + =A0 =A0 =A0 int irq;
>> + =A0 =A0 =A0 int ackbr;
>> + =A0 =A0 =A0 int state;
>> + =A0 =A0 =A0 int data_num;
>> +};
>> +
>> +#define NORMAL_SPEED =A0 100000 /* FAST_SPEED 400000 */
>> +
>> +/* Register offsets */
>> +#define ICCR1 =A00x0
>> +#define ICCR2 =A00x1
>> +#define ICMR =A0 0x2
>> +#define ICIER =A00x3
>> +#define ICSR =A0 0x4
>> +#define SAR =A0 =A0 =A0 =A0 =A0 =A00x5
>> +#define ICDRT =A00x6
>> +#define ICDRR =A00x7
>> +#define NF2CYC 0x8
>> +
>> +#define ICCR1_ICE =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
>> +#define ICCR1_RCVD =A0 =A0 =A0 =A0 =A0 =A0 0x40
>> +#define ICCR1_MST =A0 =A0 =A0 =A0 =A0 =A0 =A00x20
>> +#define ICCR1_TRS =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
>> +
>> +#define SW_DONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x100
>> +#define SW_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x200
>> +
>> +#define ICCR2_BBSY =A0 =A0 =A0 =A0 =A0 =A0 0x80
>> +#define ICCR2_SCP =A0 =A0 =A0 =A0 =A0 =A0 =A00x40
>> +#define ICCR2_SDAO =A0 =A0 =A0 =A0 =A0 =A0 0x20
>> +#define ICCR2_SDAOP =A0 =A0 =A0 =A0 =A0 =A00x10
>> +#define ICCR2_SCLO =A0 =A0 =A0 =A0 =A0 =A0 0x08
>> +#define ICCR2_I2CRST =A0 0x02
>> +
>> +#define ICSR_TDRE =A0 =A0 =A0 =A0 =A0 =A0 =A00x80
>> +#define ICSR_TEND =A0 =A0 =A0 =A0 =A0 =A0 =A00x40
>> +#define ICSR_RDRF =A0 =A0 =A0 =A0 =A0 =A0 =A00x20
>> +#define ICSR_NACKF =A0 =A0 =A0 =A0 =A0 =A0 0x10
>> +#define ICSR_STOP =A0 =A0 =A0 =A0 =A0 =A0 =A00x08
>> +#define ICSR_AL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04
>> +#define ICSR_AAS =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> +#define ICSR_ADZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x01
>> +
>> +#define ICIER_TIE =A0 =A0 =A00x80 =A0 =A0/* Transfer interrputs */
>> +#define ICIER_TEIE =A0 =A0 0x40 =A0 =A0/* Transfer end interrupts */
>> +#define ICIER_RIE =A0 =A0 =A00x20 =A0 =A0/* Receive interrupts */
>> +#define ICIER_NAKIE =A0 =A00x10 =A0 =A0/* NACK interrupts */
>> +#define ICIER_STIE =A0 =A0 0x08 =A0 =A0/* Stop interrupts */
>> +#define ICIER_ACKE =A0 =A0 0x04 =A0 =A0/* ACKbit check*/
>> +#define ICIER_ACKBR =A0 =A00x02 =A0 =A0/* set ACKbit / Receive */
>> +#define ICIER_ACKBT =A0 =A00x01 =A0 =A0/* set ACKbit / Transfer */
>> +#define ICIER_RX (ICIER_RIE|ICIER_TEIE|ICIER_TIE|ICIER_NAKIE|ICIER_STIE)
>> +#define ICIER_TX (ICIER_TIE|ICIER_TEIE|ICIER_NAKIE|ICIER_STIE)
>> +
>> +#define I2C0_INTMASK 0xFF804288
>> +#define I2C1_INTMASK 0xFF80428C
>> +#define I2C0_INTMASK_CLR 0xFF8042A8
>> +#define I2C1_INTMASK_CLR 0xFF8042AC
>> +#define I2C0_INT 0xFF8040AC
>> +#define I2C1_INT 0xFF8040D8
>> +
>> +#define I2C_INT_TXI =A0 =A0(1 << 4)
>> +#define I2C_INT_TEI =A0 =A0(1 << 3)
>> +#define I2C_INT_RXI =A0 =A0(1 << 2)
>> +#define I2C_INT_NAKI =A0 (1 << 1)
>> +#define I2C_INT_STPI =A0 (1 << 0)
>> +#define I2C_INT_ALL =A0 =A0\
>> + =A0 =A0 =A0 (I2C_INT_TXI|I2C_INT_TEI|I2C_INT_RXI|I2C_INT_NAKI|I2C_INT_=
STPI)
>> +
>> +static void
>> +iic_wr(struct sh7734_i2c_data *pd, int offs, unsigned char data)
>> +{
>> + =A0 =A0 =A0 iowrite8(data, pd->reg + offs);
>> +}
>> +
>> +static unsigned char iic_rd(struct sh7734_i2c_data *pd, int offs)
>> +{
>> + =A0 =A0 =A0 return ioread8(pd->reg + offs);
>> +}
>> +
>> +static void iic_set_clr(struct sh7734_i2c_data *pd, int offs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char set, unsigne=
d char clr)
>> +{
>> + =A0 =A0 =A0 iic_wr(pd, offs, (iic_rd(pd, offs) | set) & ~clr);
>> +}
>> +
>> +static int clk_denom_tbl[] =3D {
>> + =A0 =A0 =A0 44, 52, 64, 72, 84, 92, 100, 108, 176,
>> + =A0 =A0 =A0 208, 256, 288, 336, 368, 400, 432, 352, 416,
>> + =A0 =A0 =A0 512, 576, 672, 736, 800, 864, 704, 832, 1024,
>> + =A0 =A0 =A0 1152, 1344, 1472, 1600, 1728 };
>> +
>> +static void activate_ch(struct sh7734_i2c_data *pd, int num)
>> +{
>> + =A0 =A0 =A0 unsigned long pclk;
>> + =A0 =A0 =A0 unsigned long mode, mode_tmp;
>> + =A0 =A0 =A0 unsigned int cks_bit;
>> + =A0 =A0 =A0 long denom, speed;
>> + =A0 =A0 =A0 unsigned int i;
>> +
>> + =A0 =A0 =A0 pclk =3D clk_get_rate(pd->clk) / 1000;
>> + =A0 =A0 =A0 mode =3D speed =3D pd->bus_speed / 1000;
>> +
>> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(clk_denom_tbl); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 denom =3D (unsigned int)(pclk / clk_denom_=
tbl[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (denom > (speed * 2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((speed - denom) > 100)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode_tmp =3D (unsigned int)(denom % speed);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mode_tmp < speed) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mode_tmp < mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode =3D m=
ode_tmp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cks_bit =
=3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pd->nf2cyc =3D 1;
>> + =A0 =A0 =A0 pd->nf2cyc_clk =3D (u_int8_t)(cks_bit & 0x10);
>> + =A0 =A0 =A0 pd->iccr1_clk =3D (u_int8_t)(cks_bit & 0x0F);
>> + =A0 =A0 =A0 pd->state =3D OP_START_TRS;
>> + =A0 =A0 =A0 pd->ackbr =3D 0;
>> + =A0 =A0 =A0 pd->data_num =3D num;
>> +
>> + =A0 =A0 =A0 /* Mask clear interrupts */
>> + =A0 =A0 =A0 if (pd->adap.nr =3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(I2C_INT_ALL, I2C0_INTMASK_CLR=
);
>> + =A0 =A0 =A0 else
> Nit : Can the else be dropped?

If pd->adap.nr is 0, write value to I2C*0*_INTMASK_CLR.
In differing, it writes a value to I2C*1*_INTMASK_CLR.
Not "else" but "else if" (pd->adap.nr =3D 1) is right here.
It corrects.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(I2C_INT_ALL, I2C1_INTMASK_CLR=
);
>> +}
>> +
>> +static void deactivate_ch(struct sh7734_i2c_data *pd)
>> +{
>> + =A0 =A0 =A0 /* Reset controller */
>> + =A0 =A0 =A0 iic_set_clr(pd, ICCR2, ICCR2_I2CRST, 0);
>> + =A0 =A0 =A0 udelay(10);
>> + =A0 =A0 =A0 iic_set_clr(pd, ICCR2, 0, ICCR2_I2CRST);
>> +
>> + =A0 =A0 =A0 /* Clear/disable interrupts */
> Why is the interrupts disabled?

Permission of various interruption factors is repealed here.
These are repealed whenever communication finishes.

>
>> + =A0 =A0 =A0 iic_wr(pd, ICSR, 0);
>> + =A0 =A0 =A0 iic_wr(pd, ICIER, 0);
>> +
>> + =A0 =A0 =A0 /* Mask interrupts */
>> + =A0 =A0 =A0 if (pd->adap.nr =3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(I2C_INT_ALL, I2C0_INTMASK);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(I2C_INT_ALL, I2C1_INTMASK);
>> +
>> + =A0 =A0 =A0 /* Disable channel */
>> + =A0 =A0 =A0 iic_set_clr(pd, ICCR1, 0, ICCR1_ICE);
>> +
>> + =A0 =A0 =A0 pd->ackbr =3D 0;
>> + =A0 =A0 =A0 /* Reset controller */
>> + =A0 =A0 =A0 iic_set_clr(pd, ICCR2, ICCR2_I2CRST, 0);
>> + =A0 =A0 =A0 udelay(10);
>> + =A0 =A0 =A0 iic_set_clr(pd, ICCR2, 0, ICCR2_I2CRST);
>> +}
>> +
>> +static int i2c_op(struct sh7734_i2c_data *pd)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 unsigned char data;
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&pd->lock, flags);
>> +
>> + =A0 =A0 =A0 switch (pd->state) {
>> + =A0 =A0 =A0 case OP_START_TRS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICCR2) & ICCR2_BBSY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set to master transfer =
mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR1, ICC=
R1_MST | ICCR1_TRS, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_FIRST;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Device b=
usy\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_STOP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR2, ICCR2_BBSY, ICCR2_S=
CP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_START_SCP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Send TIE, Set TDRE */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR2, ICCR2_BBSY, ICCR2_S=
CP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_FIRST;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_TX_FIRST:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iic_rd(pd, ICSR) & ICSR_TDRE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Create command */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D (pd->msg->addr & =
0x7f) << 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data |=3D (pd->msg->flags =
& I2C_M_RD) ? 1 : 0;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write data with clear T=
DRE bit */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICDRT, data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Write da=
ta (ICDRT): %02X\n", data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_FIRST_=
END;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "ICSR/TDR=
E is not set\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_TX_FIRST_END:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & ICSR_TEND)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "ICSR/TEN=
D is not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Don't clear TEND */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->ackbr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->msg->flags & I2C_M=
_RD) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_cl=
r(pd, ICSR, 0, ICSR_TEND);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_cl=
r(pd, ICCR1, ICCR1_MST, ICCR1_TRS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_cl=
r(pd, ICSR, 0, ICSR_TDRE);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->ms=
g->len =3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 iic_set_clr(pd, ICIER, ICIER_ACKBT, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 iic_set_clr(pd, ICCR1, ICCR1_RCVD, 0);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 data =3D iic_rd(pd, ICDRR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 /* If pd->msg->len =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0this read data is dummy. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 dev_dbg(pd->dev, "Last - 1 read data %02X\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pd->state =3D OP_RX_STOP_CHK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 iic_set_clr(pd, ICIER, 0, ICIER_ACKBT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 data =3D iic_rd(pd, ICDRR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 dev_dbg(pd->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 "Dummy read data %02X\n", data);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pd->state =3D OP_RX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =
=3D OP_TX_STOP;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iic_rd(pd, ICIER) & ICIER_ACKBR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pd->dev, "ACKBR Er=
ror...\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->sr |=3D SW_ERROR; /* S=
ave Error state */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_STOP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->ackbr =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Through to OP_TX */
>> +
>> + =A0 =A0 =A0 case OP_TX: /* send data */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iic_rd(pd, ICSR) & ICSR_TDRE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D pd->msg->buf[pd->=
pos];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write data with clear T=
DRE bit */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICDRT, data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Write da=
ta (ICDRT): %02X\n", data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_END;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Retry Da=
ta translate\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_TX_END:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & ICSR_TEND)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "TEND bit=
 was not set (%02X)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 iic_rd(pd, ICSR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "pd->pos %d, pd->msg->len=
 %d, pd->data_num %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos, pd->msg->len, pd-=
>data_num);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->pos =3D pd->msg->len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If last data, need chec=
k ICSR_TDRE and ICSR_TEND. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & I=
CSR_TDRE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Last data / Last Packet=
 */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->data_num =3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =
=3D OP_TX_STOP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Through=
 to OP_TX_STOP */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (pd->data_num > =
1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Change =
Transfer to Receive */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd,=
 ICIER, 0x0); /* Interrupts disable */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =
=3D OP_TX_FINISH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Through to OP_TX_STOP */
>> +
>> + =A0 =A0 =A0 case OP_TX_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_TEND);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_STOP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR2, 0, ICCR2_BBSY | ICC=
R2_SCP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_STOP_CHK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Through to OP_TX_STOP_CHK */
>> +
>> + =A0 =A0 =A0 case OP_TX_STOP_CHK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) | ICSR_STOP)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "ICSR/STO=
P is not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR1, 0, ICCR1_MST | ICCR=
1_TRS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_TDRE);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Interrupts disable */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICIER, 0x0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX_FINISH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_RX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & ICSR_RDRF))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D iic_rd(pd, ICDRR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->msg->buf[pd->pos] =3D data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Read data %02X\n", data);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->pos =3D pd->msg->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_RX_STOP;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_RX_STOP: /* enable DTE interrupt, issue stop */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICIER, ICIER_ACKBT, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR1, ICCR1_RCVD, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_RX_BBSY_CLR;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_RX_BBSY_CLR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D iic_rd(pd, ICDRR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Last - 1 read data %02X\=
n", data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->msg->buf[pd->pos] =3D data;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_RX_STOP_CHK;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 case OP_RX_STOP_CHK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & ICSR_RDRF)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "ICSR/RDR=
F bit 0\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_STOP);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR2, 0, ICCR2_BBSY|ICCR2=
_SCP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_RX_LAST_DATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Through to OP_RX_LAST_DATA */
>> +
>> + =A0 =A0 =A0 case OP_RX_LAST_DATA:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iic_rd(pd, ICCR2) && ICCR2_BBSY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR2, 0, =
ICCR2_BBSY|ICCR2_SCP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(iic_rd(pd, ICSR) & ICSR_STOP)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "ICSR/STO=
P is not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_STOP);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D iic_rd(pd, ICDRR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->msg->buf[pd->pos] =3D data;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(pd->dev, "Last read data %02X\n", =
data);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos++;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR1, 0, ICCR1_MST);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICSR, 0, ICSR_TDRE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_set_clr(pd, ICCR1, 0, ICCR1_RCVD);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICIER, 0x00);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_RX_FINISH;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&pd->lock, flags);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static irqreturn_t sh7734_i2c_isr(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 struct platform_device *dev =3D dev_id;
>> + =A0 =A0 =A0 struct sh7734_i2c_data *pd =3D platform_get_drvdata(dev);
>> + =A0 =A0 =A0 unsigned char sr;
>> + =A0 =A0 =A0 int wakeup;
>> +
>> + =A0 =A0 =A0 sr =3D iic_rd(pd, ICSR);
>> + =A0 =A0 =A0 pd->sr |=3D sr; /* remember state */
>> +
>> + =A0 =A0 =A0 dev_dbg(pd->dev, "%s ICSR: 0x%02x sr: 0x%02x %s %d %d!\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, sr, pd->sr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pd->msg->flags & I2C_M_RD) ? "read" : "wr=
ite",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->pos, pd->msg->len);
>> +
>> + =A0 =A0 =A0 if (sr & (ICSR_AL)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* error / abitration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICSR, sr & ~ICSR_AL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wakeup =3D 0;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wakeup =3D i2c_op(pd);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (wakeup) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->sr |=3D SW_DONE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&pd->wait);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int start_ch(struct sh7734_i2c_data *pd, struct i2c_msg *usr_msg)
>> +{
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 if (usr_msg->len =3D 0 && (usr_msg->flags & I2C_M_RD)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pd->dev, "Unsupported zero length =
i2c read\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (pd->ackbr =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICCR1, pd->iccr1_clk | ICCR1_IC=
E);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, NF2CYC, pd->nf2cyc | pd->nf2cyc=
_clk);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&pd->lock, flags);
>> +
>> + =A0 =A0 =A0 pd->msg =3D usr_msg;
>> + =A0 =A0 =A0 pd->pos =3D 0;
>> + =A0 =A0 =A0 pd->sr =3D 0;
>> +
>> + =A0 =A0 =A0 /* Enable interrupts */
>> + =A0 =A0 =A0 if (usr_msg->flags & I2C_M_RD) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((pd->ackbr) && (pd->state =3D OP_TX_FI=
NISH))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_START_SCP;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICIER, ICIER_RX);
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pd->state =3D OP_RX)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->state =3D OP_TX;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iic_wr(pd, ICIER, ICIER_TX);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&pd->lock, flags);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int sh7734_i2c_xfer(struct i2c_adapter *adapter,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_msg=
 *msgs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int num)
>> +{
>> + =A0 =A0 =A0 struct sh7734_i2c_data *pd =3D i2c_get_adapdata(adapter);
>> + =A0 =A0 =A0 struct i2c_msg =A0*msg;
>> + =A0 =A0 =A0 int err =3D 0, i, k;
>> + =A0 =A0 =A0 u_int8_t val;
>> +
>> + =A0 =A0 =A0 activate_ch(pd, num);
>> +
>> + =A0 =A0 =A0 /* Process all messages */
>> + =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D &msgs[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D start_ch(pd, msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_op(pd);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 k =3D wait_event_timeout(pd->wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0pd->sr & (SW_DONE|SW_ERROR),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A05 * HZ);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!k) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pd->dev, "Transfer=
 request timed out\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pd->dev, "Polling =
timed out\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D iic_rd(pd, ICSR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* handle missing acknowledge and arbitrat=
ion lost */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (((val | pd->sr) & (ICSR_AL | SW_ERROR)=
)) {
> What about checking for other errors?

OK, I will update about error check.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(pd->dev, "I2C I/O =
error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 deactivate_ch(pd);
>> +
>> + =A0 =A0 =A0 if (!err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D num;
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> +
>> +static u32 sh7734_i2c_func(struct i2c_adapter *adapter)
>> +{
>> + =A0 =A0 =A0 return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static struct i2c_algorithm sh7734_i2c_algorithm =3D {
>> + =A0 =A0 =A0 .functionality =A0=3D sh7734_i2c_func,
>> + =A0 =A0 =A0 .master_xfer =A0 =A0=3D sh7734_i2c_xfer,
>> +};
>> +
>> +static int sh7734_i2c_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 =A0 struct i2c_sh_mobile_platform_data *pdata =3D pdev->dev.pl=
atform_data;
>> + =A0 =A0 =A0 struct sh7734_i2c_data *pd;
>> + =A0 =A0 =A0 struct i2c_adapter *adap;
>> + =A0 =A0 =A0 struct resource *res;
>> + =A0 =A0 =A0 int size;
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 pd =3D kzalloc(sizeof(struct sh7734_i2c_data), GFP_KERNEL);
>> + =A0 =A0 =A0 if (pd =3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot allocate priva=
te data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* I2C of SH7734 base clock is pll clock */
>> + =A0 =A0 =A0 pd->clk =3D clk_get(NULL, "peripheral_clk");
>> + =A0 =A0 =A0 if (IS_ERR(pd->clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot get clock\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(pd->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pd->irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 =A0 if (pd->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get irq\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D request_irq(pd->irq, sh7734_i2c_isr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0, pdev->name, pdev);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot request IRQ\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 pd->dev =3D &pdev->dev;
>> + =A0 =A0 =A0 platform_set_drvdata(pdev, pd);
>> +
>> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 =A0 if (res =3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot find IO resour=
ce\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 size =3D resource_size(res);
>> +
>> + =A0 =A0 =A0 pd->reg =3D ioremap(res->start, size);
>> + =A0 =A0 =A0 if (pd->reg =3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot map IO\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Use platformd data bus speed or NORMAL_SPEED */
>> + =A0 =A0 =A0 pd->bus_speed =3D NORMAL_SPEED;
>> + =A0 =A0 =A0 if (pdata && pdata->bus_speed)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd->bus_speed =3D pdata->bus_speed;
>> +
>> + =A0 =A0 =A0 /* setup the private data */
>> + =A0 =A0 =A0 adap =3D &pd->adap;
>> + =A0 =A0 =A0 i2c_set_adapdata(adap, pd);
>> +
>> + =A0 =A0 =A0 adap->owner =3D THIS_MODULE;
>> + =A0 =A0 =A0 adap->algo =3D &sh7734_i2c_algorithm;
>> + =A0 =A0 =A0 adap->dev.parent =3D &pdev->dev;
>> + =A0 =A0 =A0 adap->retries =3D 5;
>> + =A0 =A0 =A0 adap->nr =3D pdev->id;
>> +
>> + =A0 =A0 =A0 strlcpy(adap->name, pdev->name, sizeof(adap->name));
>> +
>> + =A0 =A0 =A0 spin_lock_init(&pd->lock);
>> + =A0 =A0 =A0 init_waitqueue_head(&pd->wait);
>> +
>> + =A0 =A0 =A0 ret =3D i2c_add_numbered_adapter(adap);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot add numbered a=
dapter\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_all;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 dev_info(&pdev->dev, "I2C adapter %d with bus speed %lu Hz=
\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0adap->nr, pd->bus_speed);
>> +
>> + =A0 =A0 =A0 return 0;
>> +
>> +err_all:
>> + =A0 =A0 =A0 iounmap(pd->reg);
>> +err_irq:
>> + =A0 =A0 =A0 free_irq(pd->irq, pd);
>> +err_clk:
>> + =A0 =A0 =A0 clk_put(pd->clk);
>> +err:
>> + =A0 =A0 =A0 kfree(pd);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int sh7734_i2c_remove(struct platform_device *pdev)
>
> Can these be in the __devexit ??

Thanks, I will fix.

>
>> +{
>> + =A0 =A0 =A0 struct sh7734_i2c_data *pd =3D platform_get_drvdata(pdev);
>> +
> Should we release resource here??
>
> May be =A0devm* could be considered?

OK, I wll update to using devm*.

>
>> + =A0 =A0 =A0 i2c_del_adapter(&pd->adap);
>> + =A0 =A0 =A0 iounmap(pd->reg);
>> + =A0 =A0 =A0 free_irq(pd->irq, pdev);
>> + =A0 =A0 =A0 clk_put(pd->clk);
>> + =A0 =A0 =A0 kfree(pd);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver sh7734_i2c_driver =3D {
>> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh7734",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D sh7734_i2c_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D sh7734_i2c_remove,
>> +};
>> +
>> +static int __init sh7734_i2c_adap_init(void)
>> +{
>> + =A0 =A0 =A0 return platform_driver_register(&sh7734_i2c_driver);
>> +}
>> +
>> +static void __exit sh7734_i2c_adap_exit(void)
>> +{
>> + =A0 =A0 =A0 platform_driver_unregister(&sh7734_i2c_driver);
>> +}
>> +
>> +subsys_initcall(sh7734_i2c_adap_init);
>> +module_exit(sh7734_i2c_adap_exit);
>> +
>> +MODULE_DESCRIPTION("SuperH SH7734 I2C Bus Controller driver");
>> +MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:i2c-sh7734");
>> --
>> 1.7.9.1
>>

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
