From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 29 Jul 2013 11:42:39 +0000
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Message-Id: <1375098159.3340.29.camel@hornet>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
	 <51F2ADA2.2030503@wwwdotorg.org>
	 <Pine.LNX.4.64.1307262215110.27439@axis700.grange>
	 <51F2EBD4.1060603@wwwdotorg.org>
	 <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
	 <Pine.LNX.4.64.1307290903360.14405@axis700.grange>
	 <1375095053.3340.7.camel@hornet>
	 <Pine.LNX.4.64.1307291312300.14405@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307291312300.14405@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Mon, 2013-07-29 at 12:27 +0100, Guennadi Liakhovetski wrote:
> On Mon, 29 Jul 2013, Pawel Moll wrote:
> 
> > On Mon, 2013-07-29 at 08:18 +0100, Guennadi Liakhovetski wrote:
> > > A short addendum. At least with Renesas SoCs I see the situation in the 
> > > following way: new SoC versions appear relatively frequently. 
> > 
> > What frequency are we talking about? Once per year? Once per month? I'm
> > not trying to be picky, it really makes a difference...
> 
> Definitely not every month - not until now in the mainline at least. I 
> currently count 9 SoCs, added since 2010, which makes about 2-3 SoCs per 
> year.

So this is actually a slower rate that I've faced in my previous life
working for a silicon vendor ;-) And my experience is that the IPs were
different between the SoCs indeed but:

1. Not all of them at the same time (so no extra compatible values for
others).
2. When there was a change it required change in a driver as well (so
adding a compatible value is not an issue).
3. The changes were *completely* unpredictable (so even comprehensive
list of DT properties wouldn't help)

To summarize, count this as another vote for using compatible rather
then "universal & future-proof" set of properties. Unless there is a
very good rationale for it (I'm sure such cases exist)

Thanks!

Pawel


