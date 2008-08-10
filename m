From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Aug 2008 15:13:42 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support, v2.
Message-Id: <20080810171342.14844957@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080731104354.GA21764@linux-sh.org>
	<20080810162931.3d9221af@hyperion.delvare>
	<20080810145053.GA9412@renesas.com>
In-Reply-To: <20080810145053.GA9412@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <paul.mundt@renesas.com>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-sh@vger.kernel.org

On Sun, 10 Aug 2008 23:50:54 +0900, Paul Mundt wrote:
> On Sun, Aug 10, 2008 at 04:29:31PM +0200, Jean Delvare wrote:
> > On Thu, 31 Jul 2008 19:43:54 +0900, Paul Mundt wrote:
> > > +static int iic_force_poll, iic_force_normal;
> > > +static int iic_timeout = 1000, iic_read_delay = 0;
> > 
> > There's a comment in the driver that says that this delay is needed for
> > several devices. So I'm a bit surprised that the default value is 0.
> > Shouldn't the default be such that the driver works on all devices by
> > default?
> > 
> The main issue is that it's highly device specific, not just platform
> specific. On most of the references boards we've shipped to customers,
> there's no need for a delay, so the default is simply to leave that off,
> and to allow people to extend it if they start witnessing problems.
> 
> Internally we have many different variations both of the board and the
> FPGA, a lot of which have very differing timing characteristics. For the
> general case a 0 or close to 0 read delay should be sufficient.
> Originally I was going to just leave the delay at 250 or something like
> that, but that failed to work for the boards that had problems, and
> needlessly penalized the ones that didn't (and we have no way of
> detecting from the platform if we're on a troublesome board or not). For
> customer references that use a silicon option for the same controller,
> there's no need for the delay.
> 
> Obviously one thing we could try to do is do a few dummy reads and see if
> any of them are aborted to try and auto-calculate a meaningful default
> delay, but in general it's pretty much all over the place. Given that, I
> think just leaving it configurable and documenting the problem cases
> should be fine. I'll be the first person to get an email when there's a
> problem anyways :-)
> 
> > > +	strlcpy(adap->name, "HL FPGA I2C adapter", I2C_NAME_SIZE);
> > 
> > I2C_NAME_SIZE isn't the size of i2c_adapter.name. Use
> > sizeof(adap->name) instead (as your original code was doing.)
> > 
> Thanks, I'm not sure why that got changed, I'll switch it back.
> 
> > > +MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
> > > +MODULE_PARM_DESC(iic_force_normal, "Force normal mode (100 kHz), default is fast mode (400 kHz)");
> > > +MODULE_PARM_DESC(iic_timeout, "Set timeout value in msecs (default 1000 ms)");
> > > +MODULE_PARM_DESC(iic_read_delay, "Delay between data read cycles (default 0 ms)");
> > 
> > In general I am curious why all these are module parameters instead of
> > platform device attributes. Shouldn't the platform code know the
> > correct values? If so, that would be less error prone than leaving it
> > on the user to pass the right parameters to the module.
> > 
> Hopefully that's answered above. Let me know if you have any other
> concerns or suggestions.

OK. I've fixed the strlcpy size issue myself, together with a couple
checkpatch warnings. The resulting patch is there:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-renesas-highlander-fpga-smbus-support.patch
It is queued for 2.6.28.

-- 
Jean Delvare
