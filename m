From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 27 May 2009 12:10:42 +0000
Subject: Re: [linux-pm] [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <20090527121042.GD1970@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 27, 2009 at 07:06:25PM +0900, Magnus Damm wrote:

> These patches extend platform device and driver interfaces to
> allow architectures to implement platform device runtime pm.

> Have a look at the last patch for a SuperH mockup that shows how
> it all fits together. We need this or a similar interface to be able
> to enter deep sleep states on SuperH. I believe other architectures
> have similar requirements.

ARM definitely does.  The OMAP SoCs are probably furthest along in
software support for this sort of functionality but it's pretty much
standard for modern ARMs.  I'd CC in the ARM list but it's subscribers
only, though the OMAP folks are also over on linux-omap@vger.kernel.org
which isn't.
