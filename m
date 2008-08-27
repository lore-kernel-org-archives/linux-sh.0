From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Aug 2008 11:09:44 +0000
Subject: Re: [PATCH] i2c: fix i2c-sh_mobile timing issues
Message-Id: <20080827130944.02e8ec49@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080827093356.9145.33751.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080827093356.9145.33751.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: i2c@lm-sensors.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

Hi Magnus,

On Wed, 27 Aug 2008 18:33:56 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch teaches the i2c-sh_mobile driver to make use of wait irqs.
> Without this patch only dte irqs are used which may lead to overruns
> and cases of missing stop and extra bytes being read on the i2c bus.
> 
> Use of wait irqs forces the hardware to pause and wait until the cpu
> is ready. Polling is also reworked in this patch to fix ms delay issues.
> 
> Verified with bus analyzer and tested on MigoR and AP325RXA boards.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Paul, can you merge this for 2.6.27?
> 
>  drivers/i2c/busses/i2c-sh_mobile.c |  271 +++++++++++++++++++++++++++---------
>  1 file changed, 208 insertions(+), 63 deletions(-)
> 

I'm not sure why I am Cc'd on this but Ben Dooks isn't. Ben is the one
in charge of i2c bus drivers for embedded system. I'm adding him.

> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
> +++ work/drivers/i2c/busses/i2c-sh_mobile.c	2008-08-13 17:40:23.000000000 +0900
> @@ -31,13 +31,84 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  
> +/* Transmit operation:                                                      */
> +/*                                                                          */
> +/* 0 byte transmit                                                          */
> +/* BUS:     S     A8     ACK   P                                            */
> +/* IRQ:       DTE   WAIT                                                    */
> +/* ICIC:                                                                    */
> +/* ICCR: 0x94 0x90                                                          */
> +/* ICDR:      A8                                                            */
> +/*                                                                          */
> +/* 1 byte transmit                                                          */
> +/* BUS:     S     A8     ACK   D8(1)   ACK   P                              */
> +/* IRQ:       DTE   WAIT         WAIT                                       */
> +/* ICIC:      -DTE                                                          */
> +/* ICCR: 0x94       0x90                                                    */
> +/* ICDR:      A8    D8(1)                                                   */
> +/*                                                                          */
> +/* 2 byte transmit                                                          */
> +/* BUS:     S     A8     ACK   D8(1)   ACK   D8(2)   ACK   P                */
> +/* IRQ:       DTE   WAIT         WAIT          WAIT                         */
> +/* ICIC:      -DTE                                                          */
> +/* ICCR: 0x94                    0x90                                       */
> +/* ICDR:      A8    D8(1)        D8(2)                                      */
> +/*                                                                          */
> +/* 3 bytes or more, +---------+ gets repeated                               */
> +/*                                                                          */
> +/*                                                                          */
> +/* Receive operation:                                                       */
> +/*                                                                          */
> +/* 0 byte receive - not supported since slave may hold SDA low              */
> +/*                                                                          */
> +/* 1 byte receive       [TX] | [RX]                                         */
> +/* BUS:     S     A8     ACK | D8(1)   ACK   P                              */
> +/* IRQ:       DTE   WAIT     |   WAIT     DTE                               */
> +/* ICIC:      -DTE           |   +DTE                                       */
> +/* ICCR: 0x94       0x81     |   0xc0                                       */
> +/* ICDR:      A8             |            D8(1)                             */
> +/*                                                                          */
> +/* 2 byte receive        [TX]| [RX]                                         */
> +/* BUS:     S     A8     ACK | D8(1)   ACK   D8(2)   ACK   P                */
> +/* IRQ:       DTE   WAIT     |   WAIT          WAIT     DTE                 */
> +/* ICIC:      -DTE           |                 +DTE                         */
> +/* ICCR: 0x94       0x81     |                 0xc0                         */
> +/* ICDR:      A8             |                 D8(1)    D8(2)               */
> +/*                                                                          */
> +/* 3 byte receive       [TX] | [RX]                                         */
> +/* BUS:     S     A8     ACK | D8(1)   ACK   D8(2)   ACK   D8(3)   ACK    P */
> +/* IRQ:       DTE   WAIT     |   WAIT          WAIT         WAIT      DTE   */
> +/* ICIC:      -DTE           |                              +DTE            */
> +/* ICCR: 0x94       0x81     |                              0xc0            */
> +/* ICDR:      A8             |                 D8(1)        D8(2)     D8(3) */
> +/*                                                                          */
> +/* 4 bytes or more, this part is repeated    +---------+                    */
> +/*                                                                          */
> +/*                                                                          */
> +/* Interrupt order and BUSY flag                                            */
> +/*     ___                                                 _                */
> +/* SDA ___\___XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXAAAAAAAAA___/                 */
> +/* SCL      \_/1\_/2\_/3\_/4\_/5\_/6\_/7\_/8\___/9\_____/                   */
> +/*                                                                          */
> +/*        S   D7  D6  D5  D4  D3  D2  D1  D0              P                 */
> +/*                                           ___                            */
> +/* WAIT IRQ ________________________________/   \___________                */
> +/* TACK IRQ ____________________________________/   \_______                */
> +/* DTE  IRQ __________________________________________/   \_                */
> +/* AL   IRQ XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                */
> +/*         _______________________________________________                  */
> +/* BUSY __/                                               \_                */
> +/*                                                                          */
> +
>  enum sh_mobile_i2c_op {
>  	OP_START = 0,
> -	OP_TX_ONLY,
> +	OP_TX_FIRST,
> +	OP_TX,
>  	OP_TX_STOP,
>  	OP_TX_TO_RX,
> -	OP_RX_ONLY,
> +	OP_RX,
>  	OP_RX_STOP,
> +	OP_RX_STOP_DATA,
>  };
>  
>  struct sh_mobile_i2c_data {
> @@ -127,25 +198,34 @@ static unsigned char i2c_op(struct sh_mo
>  	spin_lock_irqsave(&pd->lock, flags);
>  
>  	switch (op) {
> -	case OP_START:
> +	case OP_START: /* issue start and trigger DTE interrupt */
>  		iowrite8(0x94, ICCR(pd));
>  		break;
> -	case OP_TX_ONLY:
> +	case OP_TX_FIRST: /* disable DTE interrupt and write data */
> +		iowrite8(ICIC_WAITE | ICIC_ALE | ICIC_TACKE, ICIC(pd));
>  		iowrite8(data, ICDR(pd));
>  		break;
> -	case OP_TX_STOP:
> +	case OP_TX: /* write data */
>  		iowrite8(data, ICDR(pd));
> -		iowrite8(0x90, ICCR(pd));
> -		iowrite8(ICIC_ALE | ICIC_TACKE, ICIC(pd));
>  		break;
> -	case OP_TX_TO_RX:
> +	case OP_TX_STOP: /* write data and issue a stop afterwards */
>  		iowrite8(data, ICDR(pd));
> +		iowrite8(0x90, ICCR(pd));
> +		break;
> +	case OP_TX_TO_RX: /* select read mode */
>  		iowrite8(0x81, ICCR(pd));
>  		break;
> -	case OP_RX_ONLY:
> +	case OP_RX: /* just read data */
>  		ret = ioread8(ICDR(pd));
>  		break;
> -	case OP_RX_STOP:
> +	case OP_RX_STOP: /* enable DTE interrupt, issue stop */
> +		iowrite8(ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE,
> +			 ICIC(pd));
> +		iowrite8(0xc0, ICCR(pd));
> +		break;
> +	case OP_RX_STOP_DATA: /* enable DTE interrupt, read data, issue stop */
> +		iowrite8(ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE,
> +			 ICIC(pd));
>  		ret = ioread8(ICDR(pd));
>  		iowrite8(0xc0, ICCR(pd));
>  		break;
> @@ -157,58 +237,120 @@ static unsigned char i2c_op(struct sh_mo
>  	return ret;
>  }
>  
> +static int sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
> +{
> +	if (pd->pos = -1)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
> +{
> +	if (pd->pos = (pd->msg->len - 1))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void sh_mobile_i2c_get_data(struct sh_mobile_i2c_data *pd,
> +				   unsigned char *buf)
> +{
> +	switch (pd->pos) {
> +	case -1:
> +		*buf = (pd->msg->addr & 0x7f) << 1;
> +		*buf |= (pd->msg->flags & I2C_M_RD) ? 1 : 0;
> +		break;
> +	default:
> +		*buf = pd->msg->buf[pd->pos];
> +	}
> +}
> +
> +static int sh_mobile_i2c_isr_tx(struct sh_mobile_i2c_data *pd)
> +{
> +	unsigned char data;
> +
> +	if (pd->pos = pd->msg->len)
> +		return 1;
> +
> +	sh_mobile_i2c_get_data(pd, &data);
> +
> +	if (sh_mobile_i2c_is_last_byte(pd))
> +		i2c_op(pd, OP_TX_STOP, data);
> +	else if (sh_mobile_i2c_is_first_byte(pd))
> +		i2c_op(pd, OP_TX_FIRST, data);
> +	else
> +		i2c_op(pd, OP_TX, data);
> +
> +	pd->pos++;
> +	return 0;
> +}
> +
> +static int sh_mobile_i2c_isr_rx(struct sh_mobile_i2c_data *pd)
> +{
> +	unsigned char data;
> +	int real_pos;
> +
> +	do {
> +		if (pd->pos <= -1) {
> +			sh_mobile_i2c_get_data(pd, &data);
> +
> +			if (sh_mobile_i2c_is_first_byte(pd))
> +				i2c_op(pd, OP_TX_FIRST, data);
> +			else
> +				i2c_op(pd, OP_TX, data);
> +			break;
> +		}
> +
> +		if (pd->pos = 0) {
> +			i2c_op(pd, OP_TX_TO_RX, 0);
> +			break;
> +		}
> +
> +		real_pos = pd->pos - 2;
> +
> +		if (pd->pos = pd->msg->len) {
> +			if (real_pos < 0) {
> +				i2c_op(pd, OP_RX_STOP, 0);
> +				break;
> +			}
> +			data = i2c_op(pd, OP_RX_STOP_DATA, 0);
> +		} else
> +			data = i2c_op(pd, OP_RX, 0);
> +
> +		pd->msg->buf[real_pos] = data;
> +	} while (0);
> +
> +	pd->pos++;
> +	return pd->pos = (pd->msg->len + 2);
> +}
> +
>  static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
>  {
>  	struct platform_device *dev = dev_id;
>  	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
> -	struct i2c_msg *msg = pd->msg;
> -	unsigned char data, sr;
> -	int wakeup = 0;
> +	unsigned char sr;
> +	int wakeup;
>  
>  	sr = ioread8(ICSR(pd));
> -	pd->sr |= sr;
> +	pd->sr |= sr; /* remember state */
>  
>  	dev_dbg(pd->dev, "i2c_isr 0x%02x 0x%02x %s %d %d!\n", sr, pd->sr,
> -	       (msg->flags & I2C_M_RD) ? "read" : "write",
> -	       pd->pos, msg->len);
> +	       (pd->msg->flags & I2C_M_RD) ? "read" : "write",
> +	       pd->pos, pd->msg->len);
>  
>  	if (sr & (ICSR_AL | ICSR_TACK)) {
> -		iowrite8(0, ICIC(pd)); /* disable interrupts */
> -		wakeup = 1;
> -		goto do_wakeup;
> -	}
> -
> -	if (pd->pos = msg->len) {
> -		i2c_op(pd, OP_RX_ONLY, 0);
> -		wakeup = 1;
> -		goto do_wakeup;
> -	}
> -
> -	if (pd->pos = -1) {
> -		data = (msg->addr & 0x7f) << 1;
> -		data |= (msg->flags & I2C_M_RD) ? 1 : 0;
> -	} else
> -		data = msg->buf[pd->pos];
> -
> -	if ((pd->pos = -1) || !(msg->flags & I2C_M_RD)) {
> -		if (msg->flags & I2C_M_RD)
> -			i2c_op(pd, OP_TX_TO_RX, data);
> -		else if (pd->pos = (msg->len - 1)) {
> -			i2c_op(pd, OP_TX_STOP, data);
> -			wakeup = 1;
> -		} else
> -			i2c_op(pd, OP_TX_ONLY, data);
> -	} else {
> -		if (pd->pos = (msg->len - 1))
> -			data = i2c_op(pd, OP_RX_STOP, 0);
> -		else
> -			data = i2c_op(pd, OP_RX_ONLY, 0);
> +		/* don't interrupt transaction - continue to issue stop */
> +		iowrite8(sr & ~(ICSR_AL | ICSR_TACK), ICSR(pd));
> +		wakeup = 0;
> +	} else if (pd->msg->flags & I2C_M_RD)
> +		wakeup = sh_mobile_i2c_isr_rx(pd);
> +	else
> +		wakeup = sh_mobile_i2c_isr_tx(pd);
>  
> -		msg->buf[pd->pos] = data;
> -	}
> -	pd->pos++;
> +	if (sr & ICSR_WAIT) /* TODO: add delay here to support slow acks */
> +		iowrite8(sr & ~ICSR_WAIT, ICSR(pd));
>  
> - do_wakeup:
>  	if (wakeup) {
>  		pd->sr |= SW_DONE;
>  		wake_up(&pd->wait);
> @@ -219,6 +361,11 @@ static irqreturn_t sh_mobile_i2c_isr(int
>  
>  static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
>  {
> +	if (usr_msg->len = 0 && (usr_msg->flags & I2C_M_RD)) {
> +		dev_err(pd->dev, "Unsupported zero length i2c read\n");
> +		return -EIO;
> +	}
> +
>  	/* Initialize channel registers */
>  	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
>  
> @@ -233,9 +380,8 @@ static int start_ch(struct sh_mobile_i2c
>  	pd->pos = -1;
>  	pd->sr = 0;
>  
> -	/* Enable all interrupts except wait */
> -	iowrite8(ioread8(ICIC(pd)) | ICIC_ALE | ICIC_TACKE | ICIC_DTEE,
> -		 ICIC(pd));
> +	/* Enable all interrupts to begin with */
> +	iowrite8(ICIC_WAITE | ICIC_ALE | ICIC_TACKE | ICIC_DTEE, ICIC(pd));
>  	return 0;
>  }
>  
> @@ -268,25 +414,18 @@ static int sh_mobile_i2c_xfer(struct i2c
>  		if (!k)
>  			dev_err(pd->dev, "Transfer request timed out\n");
>  
> -		retry_count = 10;
> +		retry_count = 1000;
>  again:
>  		val = ioread8(ICSR(pd));
>  
>  		dev_dbg(pd->dev, "val 0x%02x pd->sr 0x%02x\n", val, pd->sr);
>  
> -		if ((val | pd->sr) & (ICSR_TACK | ICSR_AL)) {
> -			err = -EIO;
> -			break;
> -		}
> -
>  		/* the interrupt handler may wake us up before the
>  		 * transfer is finished, so poll the hardware
>  		 * until we're done.
>  		 */
> -
> -		if (!(!(val & ICSR_BUSY) && (val & ICSR_SCLM) &&
> -		      (val & ICSR_SDAM))) {
> -			msleep(1);
> +		if (val & ICSR_BUSY) {
> +			udelay(10);
>  			if (retry_count--)
>  				goto again;
>  
> @@ -294,6 +433,12 @@ again:
>  			dev_err(pd->dev, "Polling timed out\n");
>  			break;
>  		}
> +
> +		/* handle missing acknowledge and arbitration lost */
> +		if ((val | pd->sr) & (ICSR_TACK | ICSR_AL)) {
> +			err = -EIO;
> +			break;
> +		}
>  	}
>  
>  	deactivate_ch(pd);


-- 
Jean Delvare
