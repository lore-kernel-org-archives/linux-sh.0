From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 05 Aug 2008 21:37:51 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support, v2.
Message-Id: <20080805143751.3c98b1ac.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080731104354.GA21764@linux-sh.org>
In-Reply-To: <20080731104354.GA21764@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: khali@linux-fr.org, xyzzy@speakeasy.org, i2c@lm-sensors.org, linux-sh@vger.kernel.org

On Thu, 31 Jul 2008 19:43:54 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> This adds support for the SMBus adapter found in the various FPGAs on
> the Renesas Highlander platforms. Particularly the R0P7780LC0011RL and
> R0P7785LC0011RL FPGAs.
> 
> Functionality is fairly restricted, in that only byte and block data
> transfers are supported. Normal/fast mode and IRQ/polling are also
> supported. Primarily used for various RTCs and thermal sensors.
> 
> This version incorporates all of the comments from Jean Delvare and
> Trent Piepho.
>
> ...
>
> +static int highlander_i2c_read(struct highlander_i2c_dev *dev)
> +{
> +	int i, cnt;
> +	u16 data[16];
> +
> +	if (highlander_i2c_wait_for_bbsy(dev))
> +		return -EAGAIN;
> +
> +	highlander_i2c_start(dev);
> +
> +	if (highlander_i2c_wait_xfer_done(dev)) {
> +		dev_err(dev->dev, "Arbitration loss\n");
> +		return -EAGAIN;
> +	}
> +
> +	/*
> +	 * The R0P7780LC0011RL FPGA needs a significant delay between
> +	 * data read cycles, otherwise the transciever gets confused and
> +	 * garbage is returned when the read is subsequently aborted.
> +	 *
> +	 * It is not sufficient to wait for BBSY.
> +	 *
> +	 * While this generally only applies to the older SH7780-based
> +	 * Highlanders, the same issue can be observed on SH7785 ones,
> +	 * albeit less frequently. SH7780-based Highlanders may need
> +	 * this to be as high as 1000 ms.
> +	 */
> +	if (iic_read_delay && time_before(jiffies, dev->last_read_time +
> +				 msecs_to_jiffies(iic_read_delay)))
> +		msleep_interruptible(jiffies_to_msecs((dev->last_read_time +
> +				msecs_to_jiffies(iic_read_delay)) - jiffies));

If this task has signal_pending(), msleep_interruptible() will
immediately return.

> +	cnt = (dev->buf_len + 1) >> 1;
> +	for (i = 0; i < cnt; i++) {
> +		data[i] = ioread16(dev->base + SMTRDR + (i * sizeof(u16)));
> +		dev_dbg(dev->dev, "read data[%x] 0x%04x\n", i, data[i]);
> +	}
> +
> +	smbus_read_data(data, dev->buf, dev->buf_len);
> +
> +	dev->last_read_time = jiffies;

In which case I assume that the above will screw up.

> +	return 0;
> +}
>
> ...
