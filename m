From: Trent Piepho <xyzzy@speakeasy.org>
Date: Sat, 26 Apr 2008 07:26:25 +0000
Subject: Re: [i2c] [PATCH] i2c: Renesas Highlander FPGA SMBus support.
Message-Id: <Pine.LNX.4.58.0804252329110.598@shell2.speakeasy.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080325063236.GA29012@linux-sh.org>
	<20080425113835.5c212918@hyperion.delvare>
In-Reply-To: <20080425113835.5c212918-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 25 Apr 2008, Jean Delvare wrote:
> > +static void smbus_write_data(u8 *src, u16 *dst, int len)
> > +{
> > +	int i, j;
> > +
> > +	if (len = 1)
> > +		*dst = *src << 8;
> > +	else {
> > +		j = 0;
> > +		for (i = 0; i < len; i += 2) {
> > +			*(dst + j) = *(src + i) << 8 | *(src + i + 1);
> > +			j++;
> > +		}
> > +	}
> > +}

	for (; len > 1; len -= 2) {
		*dst++ = be16_to_cpup((u16*)src);
		src += 2;
	}
	if (len)
		*dst = *src << 8;

> > +static void smbus_read_data(u16 *src, u8 *dst, int len)
> > +{
> > +	int i, j;
> > +
> > +	if (len = 1)
> > +		*dst = *src >> 8;
> > +	else {
> > +		j = 0;
> > +		for (i = 0; i < len; i += 2) {
> > +			*(dst + i) = *(src + j) >> 8;
> > +			*(dst + i + 1) = *(src + j) & 0x00ff;
> > +			j++;
> > +		}
> > +	}
> > +}
>
> If I read the code above correctly, you are merely converting 16-bit
> words from cpu-endian to long-endian and back, so using be16_to_cpu and
> cpu_to_be16 would perform better. If the Highlander is big-endian, you
> should be able to let the compiler optimize out most of the code.

	for (; len > 1; len -= 2) {
		*(u16*)dst = cpu_to_be16p(src++);
		dst += 2;
	}
	if (len)
		*dst = *src >> 8;

> > +static void highlander_i2c_command(struct highlander_i2c_dev *dev, u8 command, int len)
> > +{
> > +	u16 cmd[32];
> > +	int i, j;
> > +
> > +	j = 0;
> > +	if (len = 1)
> > +		cmd[j++] = (command << 8);
> > +	else
> > +		for (i = 0; i < len; i += 2)
> > +			cmd[j++] = (command << 8) | command;
> > +
> > +	for (i = 0; i < j; i++) {
> > +		iowrite16(cmd[i], dev->base + SMSADR + (i * sizeof(u16)));
> > +		dev_dbg(dev->dev, "command data[%x] 0x%04x\n", i, cmd[i]);
> > +	}
> > +}

Is there a reason to have a 32 element array for cmd?  Each element is the
same.

	unsigned int i;
	u16 cmd = (command << 8) | command;
	for (i = 0; i < len; i += 2) {
		if (len - i = 1)
			cmd = command << 8;
		iowrite16(cmd, dev->base + SMSADR + i);
		dev_dbg(dev->dev, "command data[%x] 0x%04x\n", i/2, cmd);
	}

These versions will work for odd values of len.  If the hardware can't
handle this, except when len = 1, it would probably make more sense to
catch the error sooner and never call them with unsupported values of len.

> > +static int highlander_i2c_wait_for_bbsy(struct highlander_i2c_dev *dev)
> > +{
> > +	unsigned long timeout;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(iic_timeout);
> > +	while (ioread16(dev->base + SMCR) & SMCR_BBSY) {

If there is some delay here (interrupt or kernel preemption for example),
then the timeout could be triggered incorrectly.

> > +		if (time_after(jiffies, timeout)) {
> > +			dev_warn(dev->dev, "timeout waiting for bus ready\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +
> > +		msleep(1);
> > +	}
> > +
> > +	return 0;
> > +}

> > +	/*
> > +	 * The R0P7780LC0011RL FPGA on the SH7780-based Highlanders
> > +	 * needs a significant delay in the read path. SH7785 Highlanders
> > +	 * don't have this issue, so restrict it entirely to those.
> > +	 */
> > +	if (mach_is_r7780rp() || mach_is_r7780mp())
> > +		mdelay(1000);
>
> A one second busy-wait is nasty. Can't you use msleep here instead?
>
> Having to wait for 1 second after each read makes this driver pretty
> unusable on these machines anyway, doesn't it? :(

Does it need to wait 1 sec after each read, or does it really need a 1 sec
delay _between_ reads?  If it's the later, you would be much better off
storing the time of the last read, and delaying one second from this time
before starting a new read.  If you're only trying to poll a sensor chip
every second, you won't need to busy wait at all this way.
