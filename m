From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 14 Jul 2011 01:52:57 +0000
Subject: Re: [PATCH 1/2] i2c: i2c-riic: add support for Renesas RIIC
Message-Id: <4E1E4BF9.7050309@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0D1C3A.4050305@renesas.com>
 <20110713191826.GB3369@freya.fluff.org>
In-Reply-To: <20110713191826.GB3369@freya.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-i2c@fluff.org>
Cc: ben-linux@fluff.org, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

Hi Ben,

Thank you very much for your review.

2011/07/14 4:18, Ben Dooks wrote:
> On Fri, Jul 01, 2011 at 10:00:42AM +0900, Yoshihiro Shimoda wrote:
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index e6cf294..e8c9b1f 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -66,6 +66,7 @@ obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
>>  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
>>  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
>> +obj-$(CONFIG_I2C_RIIC)          += i2c-riic.o
> 
> Can we try and keep this list alphabetically sorted please.

OK, I will fix it.

>> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
>> new file mode 100644
>> index 0000000..dcc183b
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-riic.c
>> @@ -0,0 +1,589 @@
>> +/*
>> + * RIIC bus driver
>> + *
>> + * Copyright (C) 2011  Renesas Solutions Corp.
>> + *
>> + * Based on i2c-sh_mobile.c
>> + * Portion Copyright (C) 2008 Magnus Damm
> 
> Can this share code with the previous one?

Unfortunately, we cannot share the code with i2c-sh_mobile.c.
Because the registers are differ.

>> +#define ICMR1_BC(_x)	(_x & ICMR1_BC_MASK)
> 
> you missed a () around _x

Oh, I will fix it.

>> +static void riic_clear_bit(struct riic_data *pd, unsigned char val,
>> +			   unsigned long offset)
>> +{
>> +	unsigned char tmp;
>> +
>> +	tmp = riic_read(pd, offset);
>> +	tmp &= ~val;
>> +	riic_write(pd, tmp, offset);
> 
> as a note, you could have probably merged the above two lines together.

I will fix it to "tmp = riic_read(pd, offset) & ~val;"

> 
> ok, although you could have probably done a modify but
> 
>> +static void riic_set_clock(struct riic_data *pd, int clock)
>> +{
>> +	switch (clock) {
>> +	case 100:
>> +		riic_clear_bit(pd, ICFER_FMPE, RIIC_ICFER);
>> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
>> +		riic_set_bit(pd, ICMR1_CKS(3), RIIC_ICMR1);
>> +		riic_write(pd, ICBRH_RESERVED | 23, RIIC_ICBRH);
>> +		riic_write(pd, ICBRL_RESERVED | 23, RIIC_ICBRL);
>> +		break;
>> +	case 400:
>> +		riic_clear_bit(pd, ICFER_FMPE, RIIC_ICFER);
>> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
>> +		riic_set_bit(pd, ICMR1_CKS(1), RIIC_ICMR1);
>> +		riic_write(pd, ICBRH_RESERVED | 20, RIIC_ICBRH);
>> +		riic_write(pd, ICBRL_RESERVED | 19, RIIC_ICBRL);
>> +		break;
>> +	case 1000:
>> +		riic_set_bit(pd, ICFER_FMPE, RIIC_ICFER);
>> +		riic_clear_bit(pd, ICMR1_CKS_MASK, RIIC_ICMR1);
>> +		riic_set_bit(pd, ICMR1_CKS(0), RIIC_ICMR1);
>> +		riic_write(pd, ICBRH_RESERVED | 14, RIIC_ICBRH);
>> +		riic_write(pd, ICBRL_RESERVED | 14, RIIC_ICBRL);
>> +		break;
> 
> as a note, you could have factored out the two writes to after
> the case statement.

I'm sorry, I couldn't understand your point.
Does the "two writes" mean about RIIC_ICMR1? or RIIC_ICBR[H,L]?

>> +	default:
>> +		dev_err(pd->dev, "unsupported clock (%dkHz)\n", clock);
>> +		break;
> 
> no error indication to the caller?

Umm, this function should return an error.
I will fix the function.

>> +static int riic_send_slave_address(struct riic_data *pd, int read)
>> +{
>> +	unsigned char sa_rw[2];
>> +	int ret;
>> +
>> +	if (pd->msg->flags & I2C_M_TEN) {
>> +		sa_rw[0] = ((((pd->msg->addr & 0x300) >> 8) | 0x78) << 1);
>> +		sa_rw[0] |= read;
>> +		sa_rw[1] = pd->msg->addr & 0xff;
>> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
>> +		if (ret < 0)
>> +			return ret;
>> +		riic_write(pd, sa_rw[0], RIIC_ICDRT);
>> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
>> +		if (ret < 0)
>> +			return ret;
>> +		riic_write(pd, sa_rw[1], RIIC_ICDRT);
>> +	} else {
>> +		sa_rw[0] = (pd->msg->addr << 1) | read;
>> +		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
>> +		if (ret < 0)
>> +			return ret;
>> +		riic_write(pd, sa_rw[0], RIIC_ICDRT);
>> +	}
>> +	return 0;
>> +}
> 
> do you really want to be busy waiting on a 100kHz bus where
> peripherals are allowed to stall transfers? wouldn't using
> interrupts to do the transfer be better?

I wanted to use an interrupt for waiting transfers.
But, the module has an eratta, so I couldn't use
the interrupt for the transfers.
So, I will describe this reason to git comment.

>> +static int __devinit riic_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res = NULL;
>> +	struct riic_data *pd = NULL;
>> +	struct riic_platform_data *riic_data = NULL;
>> +	struct i2c_adapter *adap;
>> +	void __iomem *reg = NULL;
>> +	int ret = 0;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		ret = -ENODEV;
>> +		dev_err(&pdev->dev, "platform_get_resource error.\n");
>> +		goto clean_up;
>> +	}
> 
> do you really want to be generating -ENODEV here. It will
> be ignored by the upper level.

I will modify the error to -ENOENT.

>> +	if (!pdev->dev.platform_data) {
>> +		dev_err(&pdev->dev, "no platform data\n");
> 
> you forgot to set ret here.

Oh, I will add "ret = -ENOENT;".

>> +	reg = ioremap(res->start, resource_size(res));
>> +	if (reg = NULL) {
>> +		ret = -ENOMEM;
> 
> don't think this is the correct error return here.

I will modify the "-ENOMEM" to "-ENXIO".

>> +		dev_err(&pdev->dev, "ioremap error.\n");
>> +		goto clean_up;
>> +	}
>> +
>> +	pd = kzalloc(sizeof(struct riic_data), GFP_KERNEL);
>> +	if (pd = NULL) {
>> +		ret = -ENOMEM;
>> +		dev_err(&pdev->dev, "kzalloc error.\n");
> 
> personally, I would use failed instead of error.

OK, I will modify it.

>> +	strlcpy(adap->name, pdev->name, sizeof(adap->name));
> 
> think you should be using dev_name() instead of using pdev->name

I will fix it.

Best regards,
Yoshihiro Shimoda
