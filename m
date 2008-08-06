From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 02:42:33 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support, v2.
Message-Id: <20080806024233.GB581@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080731104354.GA21764@linux-sh.org> <20080805143751.3c98b1ac.akpm@linux-foundation.org>
In-Reply-To: <20080805143751.3c98b1ac.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: khali@linux-fr.org, xyzzy@speakeasy.org, i2c@lm-sensors.org, linux-sh@vger.kernel.org

On Tue, Aug 05, 2008 at 02:37:51PM -0700, Andrew Morton wrote:
> On Thu, 31 Jul 2008 19:43:54 +0900
> Paul Mundt <lethal@linux-sh.org> wrote:
> > +	/*
> > +	 * The R0P7780LC0011RL FPGA needs a significant delay between
> > +	 * data read cycles, otherwise the transciever gets confused and
> > +	 * garbage is returned when the read is subsequently aborted.
> > +	 *
> > +	 * It is not sufficient to wait for BBSY.
> > +	 *
> > +	 * While this generally only applies to the older SH7780-based
> > +	 * Highlanders, the same issue can be observed on SH7785 ones,
> > +	 * albeit less frequently. SH7780-based Highlanders may need
> > +	 * this to be as high as 1000 ms.
> > +	 */
> > +	if (iic_read_delay && time_before(jiffies, dev->last_read_time +
> > +				 msecs_to_jiffies(iic_read_delay)))
> > +		msleep_interruptible(jiffies_to_msecs((dev->last_read_time +
> > +				msecs_to_jiffies(iic_read_delay)) - jiffies));
> 
> If this task has signal_pending(), msleep_interruptible() will
> immediately return.
> 
> > +	cnt = (dev->buf_len + 1) >> 1;
> > +	for (i = 0; i < cnt; i++) {
> > +		data[i] = ioread16(dev->base + SMTRDR + (i * sizeof(u16)));
> > +		dev_dbg(dev->dev, "read data[%x] 0x%04x\n", i, data[i]);
> > +	}
> > +
> > +	smbus_read_data(data, dev->buf, dev->buf_len);
> > +
> > +	dev->last_read_time = jiffies;
> 
> In which case I assume that the above will screw up.
> 
Ah, right. Yes, that should be switched to msleep instead. Feel free to
drop the _interruptible part from the patch, or I can send an update if
you prefer.
