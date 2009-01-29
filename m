From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Jan 2009 09:14:05 +0000
Subject: Re: [PATCH 00/05] sh: timer patches
Message-Id: <20090129091404.GA15172@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090122095521.31653.35942.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090122095521.31653.35942.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2009 at 06:55:21PM +0900, Magnus Damm wrote:
> sh: timer patches
> 
> [PATCH 01/05] sh: rework clocksource and sched_clock
> [PATCH 02/05] sh: tmu disable support
> [PATCH 03/05] sh: fix no sys_timer case
> [PATCH 04/05] sh: CMT platform driver V6
> [PATCH 05/05] sh: CMT platform data for sh7723/sh7722/sh7366/sh7343
> 
> These patches are my latest iteration of SuperH timer changes.
> 
> Patch 1-3 are quite obvious and have no special dependencies.
> 
> The CMT driver patch implements a simplified CMT driver. The
> clocksource and early platform driver dependencies have been
> removed temporarily to make it possible to merge the driver
> without waiting for bits in -mm.
> 
> The CMT platform data patch depends on the serial port patches.
> 
> And on top of all this I have some early platform driver patches.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

I've applied the series, along with a number of cleanups on the
architecture side.
