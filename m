From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:23:18 +0000
Subject: [PATCH 00/13] sh7724 clkdev lookup prototype
Message-Id: <20100510112318.14587.10085.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh7724 clkdev lookup prototype

[PATCH 01/13] sh: Skip uninitialized hwblk clocks
[PATCH 02/13] sh: Rework sh7724 hwblk index
[PATCH 03/13] sh: Rework sh7724 SCIF clock lookup
[PATCH 04/13] sh: Use clkdev for sh7724 hwblk clocks
[PATCH 05/13] sh: Allow registering clocks without name
[PATCH 06/13] sh: Get rid of sh7724 hwblk clock names
[PATCH 07/13] sh: Use clkdev for sh7724 div6 clocks
[PATCH 08/13] sh: Get rid of sh7724 div6 clock names
[PATCH 09/13] sh: Use clkdev for sh7724 div4 clocks
[PATCH 10/13] sh: Get rid of sh7724 div4 clock names
[PATCH 11/13] sh: Use clkdev for sh7724 main clocks
[PATCH 12/13] sh: Get rid of sh7724 main clock names
[PATCH 13/13] sh: Kill off clock lookup code

This is a prototype for sh7724 that shows how to kill off the
SH-specific clock lookup code. When all processors for SH
are updated like this, only clkdev will be used to lookup clocks.
In other words, the patches sync the SH behaviour with ARM.

The patches are pretty rough, and many must be updated further to
include all other SH processors. So please treat these patches
as prototypes for now. Just wanted to get the code out of the door
for feedback.

[PATCH 01/13] and [PATCH 05/13] may be useful right now though.

Let me know what you think and I'll update the rest of the code.

On top of this it is not so difficult to remove the now unused 
name" and "id" members of struct clk.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   19 --
 arch/sh/include/asm/hwblk.h            |    6 
 arch/sh/kernel/cpu/clock.c             |   44 ----
 arch/sh/kernel/cpu/hwblk.c             |    5 
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  287 +++++++++++++++++++++-----------
 5 files changed, 210 insertions(+), 151 deletions(-)
