From: Ben Dooks <ben-i2c@fluff.org>
Date: Wed, 13 Jul 2011 19:18:26 +0000
Subject: Re: [PATCH 1/2] i2c: i2c-riic: add support for Renesas RIIC
Message-Id: <20110713191826.GB3369@freya.fluff.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0D1C3A.4050305@renesas.com>
In-Reply-To: <4E0D1C3A.4050305-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Jul 01, 2011 at 10:00:42AM +0900, Yoshihiro Shimoda wrote:
> This driver supports the RIIC module. The SH7757 has it.
> The driver doesn't use any IRQ handler.

I'm making an assumption that this hardware is different enough
from any current driver to make it necessary.
 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/i2c/busses/Kconfig    |    9 +
>  drivers/i2c/busses/Makefile   |    1 +
>  drivers/i2c/busses/i2c-riic.c |  589 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/riic.h      |   29 ++
>  4 files changed, 628 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-riic.c
>  create mode 100644 include/linux/i2c/riic.h
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 646068e..e057344 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -687,6 +687,15 @@ config I2C_EG20T
>  	  ML7213/ML7223 is companion chip for Intel Atom E6xx series.
>  	  ML7213/ML7223 is completely compatible for Intel EG20T PCH.
> 
> +config I2C_RIIC
> +	tristate "Renesas RIIC controller"
> +	depends on SUPERH
> +	help
> +	  This driver supports the RIIC module of the Renesas SH7757.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-riic.
> +
>  comment "External I2C/SMBus adapter drivers"
> 
>  config I2C_DIOLAN_U2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index e6cf294..e8c9b1f 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
>  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
> +obj-$(CONFIG_I2C_RIIC)          += i2c-riic.o

Can we try and keep this list alphabetically sorted please.
 
>  # External I2C/SMBus adapter drivers
>  obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
> new file mode 100644
> index 0000000..dcc183b
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-riic.c
> @@ -0,0 +1,589 @@
> +/*
> + * RIIC bus driver
> + *
> + * Copyright (C) 2011  Renesas Solutions Corp.
> + *
> + * Based on i2c-sh_mobile.c
> + * Portion Copyright (C) 2008 Magnus Damm

Can this share code with the previous one?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/riic.h>
> +#include <linux/io.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +
> +#define RIIC_ICCR1	0x00
> +#define RIIC_ICCR2	0x01
> +#define RIIC_ICMR1	0x02
> +#define RIIC_ICMR2	0x03
> +#define RIIC_ICMR3	0x04
> +#define RIIC_ICFER	0x05
> +#define RIIC_ICSER	0x06
> +#define RIIC_ICIER	0x07
> +#define RIIC_ICSR1	0x08
> +#define RIIC_ICSR2	0x09
> +#define RIIC_SARL0	0x0a
> +#define RIIC_SARU0	0x0b
> +#define RIIC_SARL1	0x0c
> +#define RIIC_SARU1	0x0d
> +#define RIIC_SARL2	0x0e
> +#define RIIC_SARU2	0x0f
> +#define RIIC_ICBRL	0x10
> +#define RIIC_ICBRH	0x11
> +#define RIIC_ICDRT	0x12
> +#define RIIC_ICDRR	0x13
> +
> +/* ICCR1 */
> +#define ICCR1_ICE	0x80
> +#define ICCR1_IICRST	0x40
> +#define ICCR1_CLO	0x20
> +#define ICCR1_SOWP	0x10
> +#define ICCR1_SCLO	0x08
> +#define ICCR1_SDAO	0x04
> +#define ICCR1_SCLI	0x02
> +#define ICCR1_SDAI	0x01
> +
> +/* ICCR2 */
> +#define ICCR2_BBSY	0x80
> +#define ICCR2_MST	0x40
> +#define ICCR2_TRS	0x20
> +#define ICCR2_SP	0x08
> +#define ICCR2_RS	0x04
> +#define ICCR2_ST	0x02
> +
> +/* ICMR1 */
> +#define ICMR1_MTWP	0x80
> +#define ICMR1_CKS_MASK	0x70
> +#define ICMR1_BCWP	0x08
> +#define ICMR1_BC_MASK	0x07
> +
> +#define ICMR1_CKS(_x)	((_x << 4) & ICMR1_CKS_MASK)
> +#define ICMR1_BC(_x)	(_x & ICMR1_BC_MASK)

you missed a () around _x

> +
> +/* ICMR2 */
> +#define ICMR2_DLCS	0x80
> +#define ICMR2_SDDL_MASK	0x70
> +#define ICMR2_TMOH	0x04
> +#define ICMR2_TMOL	0x02
> +#define ICMR2_TMOS	0x01
> +
> +/* ICMR3 */
> +#define ICMR3_SMBS	0x80
> +#define ICMR3_WAIT	0x40
> +#define ICMR3_RDRFS	0x20
> +#define ICMR3_ACKWP	0x10
> +#define ICMR3_ACKBT	0x08
> +#define ICMR3_ACKBR	0x04
> +#define ICMR3_NF_MASK	0x03
> +
> +/* ICFER */
> +#define ICFER_FMPE	0x80
> +#define ICFER_SCLE	0x40
> +#define ICFER_NFE	0x20
> +#define ICFER_NACKE	0x10
> +#define ICFER_SALE	0x08
> +#define ICFER_NALE	0x04
> +#define ICFER_MALE	0x02
> +#define ICFER_TMOE	0x01
> +
> +/* ICSER */
> +#define ICSER_HOAE	0x80
> +#define ICSER_DIDE	0x20
> +#define ICSER_GCAE	0x08
> +#define ICSER_SAR2E	0x04
> +#define ICSER_SAR1E	0x02
> +#define ICSER_SAR0E	0x01
> +
> +/* ICIER */
> +#define ICIER_TIE	0x80
> +#define ICIER_TEIE	0x40
> +#define ICIER_RIE	0x20
> +#define ICIER_NAKIE	0x10
> +#define ICIER_SPIE	0x08
> +#define ICIER_STIE	0x04
> +#define ICIER_ALIE	0x02
> +#define ICIER_TMOIE	0x01
> +
> +/* ICSR1 */
> +#define ICSR1_HOA	0x80
> +#define ICSR1_DID	0x20
> +#define ICSR1_GCA	0x08
> +#define ICSR1_AAS2	0x04
> +#define ICSR1_AAS1	0x02
> +#define ICSR1_AAS0	0x01
> +
> +/* ICSR2 */
> +#define ICSR2_TDRE	0x80
> +#define ICSR2_TEND	0x40
> +#define ICSR2_RDRF	0x20
> +#define ICSR2_NACKF	0x10
> +#define ICSR2_STOP	0x08
> +#define ICSR2_START	0x04
> +#define ICSR2_AL	0x02
> +#define ICSR2_TMOF	0x01
> +
> +/* SARLn */
> +#define SARL_SVA_MASK	0xfe	/* SVA[7:1] */
> +#define SARL_SVA	0x01
> +
> +/* SARUn */
> +#define SARU_SVA_MASK	0x06	/* SVA[9:8] */
> +#define SARU_FS		0x01
> +
> +/* ICBRH */
> +#define ICBRH_RESERVED	0xe0	/* The write value shoud always be 1 */
> +#define ICBRH_BRH_MASK	0x1f
> +
> +/* ICBRL */
> +#define ICBRL_RESERVED	0xe0	/* The write value shoud always be 1 */
> +#define ICBRL_BRL_MASK	0x1f
> +
> +#define RIIC_TIMEOUT	10000	/* 100msec (unit = 10usec) */
> +
> +struct riic_data {
> +	struct device *dev;
> +	void __iomem *reg;
> +	struct i2c_adapter adap;
> +	struct i2c_msg *msg;
> +};
> +
> +#define DRIVER_VERSION	"2011-07-01"
> +
> +static unsigned char riic_read(struct riic_data *pd, unsigned long addr)
> +{
> +	return ioread8(pd->reg + addr);
> +}
> +
> +static void riic_write(struct riic_data *pd, unsigned char data,
> +		       unsigned long addr)
> +{
> +	iowrite8(data, pd->reg + addr);
> +}
> +
> +static void riic_set_bit(struct riic_data *pd, unsigned char val,
> +			 unsigned long offset)
> +{
> +	unsigned char tmp;
> +
> +	tmp = riic_read(pd, offset);
> +	tmp |= val;
> +	riic_write(pd, tmp, offset);
> +}
> +
> +static void riic_clear_bit(struct riic_data *pd, unsigned char val,
> +			   unsigned long offset)
> +{
> +	unsigned char tmp;
> +
> +	tmp = riic_read(pd, offset);
> +	tmp &= ~val;
> +	riic_write(pd, tmp, offset);

as a note, you could have probably merged the above two lines together.

> +}

ok, although you could have probably done a modify but

> +static void riic_set_clock(struct riic_data *pd, int clock)
> +{
> +	switch (clock) {
> +	case 100:
> +		riic_clear_bit(pd, ICFER_FMPE, RIIC_ICFER);
> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
> +		riic_set_bit(pd, ICMR1_CKS(3), RIIC_ICMR1);
> +		riic_write(pd, ICBRH_RESERVED | 23, RIIC_ICBRH);
> +		riic_write(pd, ICBRL_RESERVED | 23, RIIC_ICBRL);
> +		break;
> +	case 400:
> +		riic_clear_bit(pd, ICFER_FMPE, RIIC_ICFER);
> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
> +		riic_set_bit(pd, ICMR1_CKS(1), RIIC_ICMR1);
> +		riic_write(pd, ICBRH_RESERVED | 20, RIIC_ICBRH);
> +		riic_write(pd, ICBRL_RESERVED | 19, RIIC_ICBRL);
> +		break;
> +	case 1000:
> +		riic_set_bit(pd, ICFER_FMPE, RIIC_ICFER);
> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
> +		riic_set_bit(pd, ICMR1_CKS(0), RIIC_ICMR1);
> +		riic_write(pd, ICBRH_RESERVED | 14, RIIC_ICBRH);
> +		riic_write(pd, ICBRL_RESERVED | 14, RIIC_ICBRL);
> +		break;

as a note, you could have factored out the two writes to after
the case statement.

> +	default:
> +		dev_err(pd->dev, "unsupported clock (%dkHz)\n", clock);
> +		break;

no error indication to the caller?

> +	}



> +}
> +
> +static void riic_init_setting(struct riic_data *pd, int clock)
> +{
> +	riic_clear_bit(pd, ICCR1_ICE, RIIC_ICCR1);
> +	riic_set_bit(pd, ICCR1_IICRST, RIIC_ICCR1);
> +	riic_clear_bit(pd, ICCR1_IICRST, RIIC_ICCR1);
> +
> +	riic_write(pd, 0, RIIC_SARL0);
> +	riic_write(pd, 0, RIIC_SARU0);
> +	riic_write(pd, ICSER_SAR0E, RIIC_ICSER);
> +
> +	riic_write(pd, ICMR1_BC(7), RIIC_ICMR1);
> +	riic_set_clock(pd, clock);
> +
> +	riic_set_bit(pd, ICCR1_ICE, RIIC_ICCR1);
> +	riic_set_bit(pd, ICMR3_RDRFS | ICMR3_WAIT | ICMR3_ACKWP, RIIC_ICMR3);
> +}
> +
> +static int riic_check_busy(struct riic_data *pd)
> +{
> +	if (riic_read(pd, RIIC_ICCR2) & ICCR2_BBSY) {
> +		dev_err(pd->dev, "i2c bus is busy.\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int riic_wait_for_icsr2(struct riic_data *pd, unsigned short bit)
> +{
> +	unsigned char icsr2;
> +	int timeout = RIIC_TIMEOUT;
> +
> +	while (timeout-- > 0) {
> +		icsr2 = riic_read(pd, RIIC_ICSR2);
> +		if (icsr2 & ICSR2_NACKF)
> +			return -EIO;
> +		if (icsr2 & bit)
> +			return 0;
> +		udelay(10);
> +	}
> +
> +	dev_err(pd->dev, "%s: bit = %x icsr2 = %x, iccr2 = %x\n", __func__,
> +		bit, riic_read(pd, RIIC_ICSR2), riic_read(pd, RIIC_ICCR2));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int riic_send_slave_address(struct riic_data *pd, int read)
> +{
> +	unsigned char sa_rw[2];
> +	int ret;
> +
> +	if (pd->msg->flags & I2C_M_TEN) {
> +		sa_rw[0] = ((((pd->msg->addr & 0x300) >> 8) | 0x78) << 1);
> +		sa_rw[0] |= read;
> +		sa_rw[1] = pd->msg->addr & 0xff;
> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
> +		if (ret < 0)
> +			return ret;
> +		riic_write(pd, sa_rw[0], RIIC_ICDRT);
> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
> +		if (ret < 0)
> +			return ret;
> +		riic_write(pd, sa_rw[1], RIIC_ICDRT);
> +	} else {
> +		sa_rw[0] = (pd->msg->addr << 1) | read;
> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
> +		if (ret < 0)
> +			return ret;
> +		riic_write(pd, sa_rw[0], RIIC_ICDRT);
> +	}
> +	return 0;
> +}

do you really want to be busy waiting on a 100kHz bus where
peripherals are allowed to stall transfers? wouldn't using
interrupts to do the transfer be better?

> +static int riic_master_transmit(struct riic_data *pd, int stop)
> +{
> +	int ret = 0;
> +	int index;
> +
> +	riic_set_bit(pd, ICCR2_ST, RIIC_ICCR2);
> +	ret = riic_wait_for_icsr2(pd, ICSR2_START);
> +	if (ret < 0)
> +		goto force_exit;
> +	riic_clear_bit(pd, ICSR2_START, RIIC_ICSR2);
> +
> +	ret = riic_send_slave_address(pd, 0);
> +	if (ret < 0)
> +		goto force_exit;
> +
> +	/* transmit data */
> +	index = 0;
> +	do {
> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
> +		if (ret < 0)
> +			goto force_exit;
> +
> +		riic_write(pd, pd->msg->buf[index], RIIC_ICDRT);
> +		index++;
> +	} while (pd->msg->len > index);
> +
> +	ret = riic_wait_for_icsr2(pd, ICSR2_TEND);
> +	if (ret < 0)
> +		goto force_exit;
> +
> +force_exit:
> +	if (stop) {
> +		riic_clear_bit(pd, ICSR2_STOP | ICSR2_NACKF, RIIC_ICSR2);
> +		riic_set_bit(pd, ICCR2_SP, RIIC_ICCR2);
> +		riic_wait_for_icsr2(pd, ICSR2_STOP);
> +	}
> +	riic_clear_bit(pd, ICSR2_STOP | ICSR2_NACKF, RIIC_ICSR2);
> +
> +	return ret;
> +}
> +
> +static void riic_set_receive_ack(struct riic_data *pd, int ack)
> +{
> +	if (ack)
> +		riic_clear_bit(pd, ICMR3_ACKBT, RIIC_ICMR3);
> +	else
> +		riic_set_bit(pd, ICMR3_ACKBT, RIIC_ICMR3);
> +}
> +
> +static int riic_master_receive(struct riic_data *pd, int restart)
> +{
> +	int dummy_read = 1;
> +	int ret = 0;
> +	int index;
> +
> +	if (restart)
> +		riic_set_bit(pd, ICCR2_RS, RIIC_ICCR2);
> +	else
> +		riic_set_bit(pd, ICCR2_ST, RIIC_ICCR2);
> +
> +	ret = riic_wait_for_icsr2(pd, ICSR2_START);
> +	if (ret < 0)
> +		return ret;
> +	riic_clear_bit(pd, ICSR2_START, RIIC_ICSR2);
> +
> +	/* send slave address */
> +	ret = riic_send_slave_address(pd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (riic_read(pd, RIIC_ICSR2) & ICSR2_NACKF) {
> +		/* received NACK */
> +		riic_clear_bit(pd, ICSR2_STOP, RIIC_ICSR2);
> +		riic_set_bit(pd, ICCR2_SP, RIIC_ICCR2);
> +		riic_read(pd, RIIC_ICDRR);	/* dummy read */
> +		goto force_exit;
> +	}
> +
> +	/* receive data */
> +	index = 0;
> +	while ((pd->msg->len - 1) > index) {
> +		ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
> +		if (ret < 0)
> +			return ret;
> +
> +		if ((index + 1) >= (pd->msg->len - 1))
> +			break;
> +
> +		if (dummy_read) {
> +			riic_read(pd, RIIC_ICDRR);
> +			dummy_read = 0;
> +		} else {
> +			pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
> +			index++;
> +			riic_set_receive_ack(pd, 1);
> +		}
> +	}
> +
> +	/* step 6 */
> +	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* step 7 */
> +	if (dummy_read) {
> +		riic_read(pd, RIIC_ICDRR);
> +		dummy_read = 0;
> +	} else {
> +		pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
> +		index++;
> +	}
> +	riic_set_receive_ack(pd, 1);
> +
> +	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
> +	if (ret < 0)
> +		return ret;
> +
> +	riic_clear_bit(pd, ICSR2_STOP, RIIC_ICSR2);
> +	riic_set_bit(pd, ICCR2_SP, RIIC_ICCR2);
> +
> +	pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
> +	index++;
> +	riic_set_receive_ack(pd, 0);
> +
> +force_exit:
> +	ret = riic_wait_for_icsr2(pd, ICSR2_STOP);
> +	if (ret < 0)
> +		return ret;
> +
> +	riic_clear_bit(pd, ICSR2_STOP | ICSR2_NACKF, RIIC_ICSR2);
> +
> +	return ret;
> +}
> +
> +static int riic_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
> +		     int num)
> +{
> +	struct riic_data *pd = i2c_get_adapdata(adapter);
> +	int i, ret = 0;
> +	int restart = num > 1 ? 1 : 0;
> +	int stop;
> +
> +	if (riic_check_busy(pd))
> +		return -EBUSY;
> +
> +	for (i = 0; (i < num) && !ret; i++) {
> +		pd->msg = &msgs[i];
> +		stop = (i = num - 1);
> +
> +		if (pd->msg->flags & I2C_M_RD)
> +			ret = riic_master_receive(pd, restart);
> +		else
> +			ret = riic_master_transmit(pd, stop);
> +	}
> +
> +	return !ret ? num : ret;
> +}
> +
> +static u32 riic_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm riic_algorithm = {
> +	.functionality	= riic_func,
> +	.master_xfer	= riic_xfer,
> +};
> +
> +static int __devexit riic_remove(struct platform_device *pdev)
> +{
> +	struct riic_data *pd = platform_get_drvdata(pdev);
> +
> +	if (!pd)
> +		return 0;
> +
> +	i2c_del_adapter(&pd->adap);
> +	iounmap(pd->reg);
> +	kfree(pd);
> +
> +	return 0;
> +}
> +
> +static int __devinit riic_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = NULL;
> +	struct riic_data *pd = NULL;
> +	struct riic_platform_data *riic_data = NULL;
> +	struct i2c_adapter *adap;
> +	void __iomem *reg = NULL;
> +	int ret = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENODEV;
> +		dev_err(&pdev->dev, "platform_get_resource error.\n");
> +		goto clean_up;
> +	}

do you really want to be generating -ENODEV here. It will
be ignored by the upper level.

> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "no platform data\n");

you forgot to set ret here.

> +		goto clean_up;
> +	}
> +	riic_data = pdev->dev.platform_data;

> +	reg = ioremap(res->start, resource_size(res));
> +	if (reg = NULL) {
> +		ret = -ENOMEM;

don't think this is the correct error return here.

> +		dev_err(&pdev->dev, "ioremap error.\n");
> +		goto clean_up;
> +	}
> +
> +	pd = kzalloc(sizeof(struct riic_data), GFP_KERNEL);
> +	if (pd = NULL) {
> +		ret = -ENOMEM;
> +		dev_err(&pdev->dev, "kzalloc error.\n");

personally, I would use failed instead of error.

> +		goto clean_up;
> +	}
> +
> +	pd->dev = &pdev->dev;
> +	pd->reg = reg;
> +	platform_set_drvdata(pdev, pd);
> +
> +	adap = &pd->adap;
> +	i2c_set_adapdata(adap, pd);
> +
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &riic_algorithm;
> +	adap->dev.parent = &pdev->dev;
> +	adap->retries = 5;
> +	adap->nr = pdev->id;
> +
> +	strlcpy(adap->name, pdev->name, sizeof(adap->name));

think you should be using dev_name() instead of using pdev->name

> +	riic_init_setting(pd, riic_data->clock);
> +
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "i2c_add_numbered_adapter error.\n");
> +		goto clean_up;
> +	}
> +
> +	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
> +	return ret;
> +
> +clean_up:
> +	if (reg)
> +		iounmap(reg);
> +	kfree(pd);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver riic_driver = {
> +	.probe =	riic_probe,
> +	.remove =	__devexit_p(riic_remove),
> +	.driver		= {
> +		.name	= "i2c-riic",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init riic_init(void)
> +{
> +	return platform_driver_register(&riic_driver);
> +}
> +module_init(riic_init);
> +
> +static void __exit riic_cleanup(void)
> +{
> +	platform_driver_unregister(&riic_driver);
> +}
> +module_exit(riic_cleanup);
> +
> +MODULE_DESCRIPTION("Renesas RIIC Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yoshihiro Shimoda");
> +MODULE_ALIAS("platform:i2c-riic");

> diff --git a/include/linux/i2c/riic.h b/include/linux/i2c/riic.h
> new file mode 100644
> index 0000000..5839381
> --- /dev/null
> +++ b/include/linux/i2c/riic.h
> @@ -0,0 +1,29 @@
> +/*
> + * RIIC bus driver
> + *
> + * Copyright (C) 2011  Renesas Solutions Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifndef _RIIC_H_
> +#define _RIIC_H_
> +
> +struct riic_platform_data {
> +	int	clock;		/* i2c clock (kHZ) */
> +};
> +
> +#endif
