From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 01:41:26 +0000
Subject: Re: [PATCH 00/04] ARM: mach-shmobile: Add run-time IRQ handler support
Message-Id: <20110107014126.GD22477@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 28, 2010 at 05:26:43PM +0900, Magnus Damm wrote:
> ARM: mach-shmobile: Add run-time IRQ handler support
> 
> [PATCH 01/04] ARM: mach-shmobile: Enable CONFIG_MULTI_IRQ_HANDLER
> [PATCH 02/04] ARM: mach-shmobile: Run-time IRQ handler for INTCA
> [PATCH 03/04] ARM: mach-shmobile: Run-time IRQ handler for GIC
> [PATCH 04/04] ARM: mach-shmobile: Rely on run-time IRQ handlers
> 
> These patches add run-time IRQ handler support for R-Mobile and
> SH-Mobile processors. Nothing out of the ordinary really, except
> merge dependency fun. Built on top of rmobile-latest plus below.
> 
> Depends on:
> "[PATCH 01/07] ARM: Introduce asm/hardware/entry-macro-gic.S"
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idd75/1
> 
> "[PATCH] ARM: Allow machine to specify it's own IRQ handlers at run-time"
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?ide32/1
> 
> "[PATCH] ARM: Subarch IRQ handler macros V3"
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?ide38/1
> 
> "[PATCH] ARM: mach-shmobile: Use shared GIC entry macros"
> https://patchwork.kernel.org/patch/426981/
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
