From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Aug 2009 03:03:36 +0000
Subject: Re: [PATCH] sh: LCDC SYS bus access wait fix
Message-Id: <20090813030335.GB2701@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090806151629.5142.26006.sendpatchset@rx1.opensource.se>
	<20090806151227.5103.31166.sendpatchset@rx1.opensource.se>
	<20090806150343.4770.1714.sendpatchset@rx1.opensource.se>
	<20090806145843.4475.33947.sendpatchset@rx1.opensource.se>
	<20090806145130.4409.69037.sendpatchset@rx1.opensource.se>
	<20090806143438.4005.17251.sendpatchset@rx1.opensource.se>
	<20090806142812.3947.24083.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090806151629.5142.26006.sendpatchset@rx1.opensource.se>
	<20090806151227.5103.31166.sendpatchset@rx1.opensource.se>
	<20090806150343.4770.1714.sendpatchset@rx1.opensource.se>
	<20090806145843.4475.33947.sendpatchset@rx1.opensource.se>
	<20090806145130.4409.69037.sendpatchset@rx1.opensource.se>
	<20090806143438.4005.17251.sendpatchset@rx1.opensource.se>
	<20090806142812.3947.24083.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, tony@atomide.com, kyungmin.park@samsung.com, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org

On Thu, Aug 06, 2009 at 11:28:12PM +0900, Magnus Damm wrote:
> Update the SuperH Mobile LCDC driver to wait for SYS bus to
> become idle after reading or writing. This is needed by the
> kfr2r09 board, but also fixes potential problems on other
> boards making use of the LCDC in a SYS configuration.

On Thu, Aug 06, 2009 at 11:34:38PM +0900, Magnus Damm wrote:
> Fix the SuperH Mobile LCDC driver to make use of the full
> 18-bit DRD field in the LDDRDR register. Without this patch
> only 16-bit register access is possible. Needed by 18-bit
> SYS panels such as the one used on kfr2r09.

On Thu, Aug 06, 2009 at 11:51:30PM +0900, Magnus Damm wrote:
> This patch adds support for the WQVGA LCD display used by
> the KFR2R09 board. The LCD module is a TX07D34VM0AAA made
> by Hitachi, and this module is made up by a R61517 chip
> together with a 240x400 pixel display. The screen is
> attached to the SuperH Mobile LCDC using a 18-bit SYS bus.
> 
> The register settings used by the SYS panel setup code are
> based on an out-of-tree driver which apart from duplicating
> all LCDC driver code and writing to non-existing hardware
> registers also never was posted for upstream merge.

On Thu, Aug 06, 2009 at 11:58:43PM +0900, Magnus Damm wrote:
> This patch adds support for the NAND flash chip
> attached to CS4 on the KFR2R09 board. The device is
> driven by the platform device driver "onenand-flash".

On Fri, Aug 07, 2009 at 12:03:43AM +0900, Magnus Damm wrote:
> This patch adds support for LED9, LED10 and LED11 on
> the Solution Engine 7724 board. If CONFIG_PM is enabled
> then these LEDs are used to show the hardware sleep
> mode used by the processor. Useful to debug cpuidle.

On Fri, Aug 07, 2009 at 12:12:27AM +0900, Magnus Damm wrote:
> This patch moves all the romImage related header files into
> the mach/ directory.

On Fri, Aug 07, 2009 at 12:16:29AM +0900, Magnus Damm wrote:
> This patch moves the Migo-R specific header file from
> mach-common/ into mach-migor/ and removes unused cruft.

All applied, thanks.
