From: Kevin Hilman <khilman@ti.com>
Date: Thu, 26 Jul 2012 21:45:52 +0000
Subject: Re: [RFC][PATCH 0/14] PM / shmobile: Pass power domain information via DT (was: Re: [RFD] PM: Device
Message-Id: <87mx2mmc1b.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201207032302.17805.rjw@sisk.pl> <201207242237.28051.rjw@sisk.pl>
	<201207251300.34892.arnd@arndb.de> <201207260032.40159.rjw@sisk.pl>
	<87vchb4ar8.fsf@ti.com>
	<20120726210952.GG4560@opensource.wolfsonmicro.com>
In-Reply-To: <20120726210952.GG4560@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Thu, 26 Jul 2012 22:09:53 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arnd Bergmann <arnd@arndb.de>, devicetree-discuss@lists.ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Linux-sh list <linux-sh@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Jul 25, 2012 at 05:38:35PM -0700, Kevin Hilman wrote:
>
>> That being said, I'm not sure why ti,hwmods is being used as an example
>> for powerdomains.  hwmods describe the integration of SoC IP blocks
>> (base addr, IRQ, DMA channel etc., which are being moved to DT) as well
>> as a bunch of SoC specific PM register descriptions.  This stuff is
>> SoC-specific PM register layout, so being very SoC specific, it has the
>> 'ti' prefix in the DT binding.
>
> I think the thing here is that one aspect of that SoC integration is
> which power domain the blocks are in.  Describing which power domain an
> IP is in isn't a million miles away from describing which hwmod applies
> to an IP.

Not a million miles, just a million transistors. ;)

Ideally, we will eventually have a representation that can map
from regulators all the way down to IP blocks.  regulator --> voltage
domain --> power domain --> clock domain --> clocks --> IP block.

Currently we have bindings for regulators,  IP blocks (ti,hwmods on
OMAP) and clocks are in progress.  Eventually, we'll need everything
else in between.

Kevin



