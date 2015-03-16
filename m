From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Mar 2015 14:39:03 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC da9063/da9210 Regulator Quirk for v4.1
Message-Id: <7585731.d24O9krsnY@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 16 March 2015 08:03:07 Simon Horman wrote:
> Renesas ARM Based SoC da9063/da9210 Regulator Quirk for v4.1
> 
> The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
> da9210 regulators.  Both regulators have their interrupt request lines
> tied to the same interrupt pin (IRQ2) on the SoC.
> 
> After cold boot or da9063-induced restart, both the da9063 and da9210
> seem to assert their interrupt request lines.  Hence as soon as one
> driver requests this irq, it gets stuck in an interrupt storm, as it
> only manages to deassert its own interrupt request line, and the other
> driver hasn't installed an interrupt handler yet.
> 
> To handle this, install a quirk that masks the interrupts in both the
> da9063 and da9210.  This quirk has to run after the i2c master driver
> has been initialized, but before the i2c slave drivers are initialized.
> As it depends on i2c, select I2C if one of the affected platforms is
> enabled in the kernel config.
> 

Pulled into next/soc, thanks!

	Arnd
