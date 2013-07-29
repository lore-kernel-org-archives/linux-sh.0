From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 29 Jul 2013 10:57:16 +0000
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Message-Id: <1375095436.3340.13.camel@hornet>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
	 <51F2ADA2.2030503@wwwdotorg.org>
In-Reply-To: <51F2ADA2.2030503@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Fri, 2013-07-26 at 18:10 +0100, Stephen Warren wrote:
> > +- uhs-sdr12: the host supports UHS SDR12 mode
> > +- uhs-sdr25: the host supports UHS SDR25 mode
> > +- uhs-sdr50: the host supports UHS SDR50 mode
> > +- uhs-sdr104: the host supports UHS SDR104 mode
> > +- uhs-ddr50: the host supports UHS DDR50 mode
> > +- ddr-1v2: the host can support DDR, using 1.2V VccQ
> > +- ddr-1v8: the host can support DDR, using 1.8V VccQ

I understand that they are equivalent of the mmc caps #defines. Having
absolutely no UHS knowledge (nor access to the spec) I'm just wondering
if some of them couldn't be derived from the "environment", being the
way the host is wired up?

An example would be the classic OCR VDD fields - the voltage range bits
are taken from the regulator "vmmc" supply (see
mmc_regulator_get_supply()).

Of course I this may be completely wrong approach here...

Pawel


