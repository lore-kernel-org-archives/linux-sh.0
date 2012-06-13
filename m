From: Chris Ball <cjb@laptop.org>
Date: Wed, 13 Jun 2012 09:40:04 +0000
Subject: Re: [PATCH v4] mmc: add a function to get regulators, supplying card's power
Message-Id: <87fw9zzh1n.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1206121743260.6800@axis700.grange>
	<4FD84DAA.30201@stericsson.com>
	<Pine.LNX.4.64.1206131024300.17854@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206131024300.17854@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 13 Jun 2012 10:28:22 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi,

On Wed, Jun 13 2012, Guennadi Liakhovetski wrote:
>> > +struct mmc_supply {
>> > +	struct regulator *vmmc;		/* Card power supply */
>> > +	struct regulator *vqmmc;	/* Optional Vccq supply */
>> > +};
>> 
>> I believe your intention is to provide this functionality for the host drivers
>> as the common way of handling card regulators. Then, I would suggest to
>> include these two new regulators in the mmc_host struct, instead of having
>> this in a separate struct, which then also needs to be handled by every host
>> driver.
>
> I have no strong preference about this. Having an additional struct is how 
> I interpreted Mark's proposal:
>
> http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus876
>
> but I'm also fine with putting it in mmc_host. Chris, what's your 
> preference?

I think Mark was just trying to help with your observation that the
changes are messy.  I don't see any compelling reasons to avoid adding
these to mmc_host -- does anyone else feel strongly?

So, I'd say go ahead and post an updated patch that uses mmc_host,
and we can see if Mark has any thoughts.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
