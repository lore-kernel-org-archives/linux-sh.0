From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 May 2012 14:39:26 +0000
Subject: [PATCH 00/03] clocksource: Emma Mobile STI V2 patches
Message-Id: <20120509143926.27521.20342.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, johnstul@us.ibm.com, rjw@sisk.pl, lethal@linux-sh.org, gregkh@linuxfoundation.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: Emma Mobile STI V2 patches

[PATCH 01/03] clockevents: Make clockevents_config() a global symbol
[PATCH 02/03] clocksource: em_sti: Emma Mobile STI driver V2
[PATCH 03/03] clocksource: em_sti: Add DT support

This is the second version of Emma Mobile STI driver. Now with
significantly cleaner clockevent intergration and DT support.

The driver is implemented as a regular platform device which makes
use of the STI hardware and provides both clocksource and clockevent
interfaces with a single 48-bit hardware counter.

It is worth mentioning that the driver makes use of clockevents_config()
to update the timer frequency after registration time. This is done to
save power by making sure that unused timer hardware is stopped whenever
possible.

The reason behind allowing the driver to use clockevents_config() is in
detail as follows. The clock associated with the timer gets enabled when
starting the clocksource/clockevent and it gets disabled when the
clocksource or clockevent gets stopped. Due to the design of the clock
framework the rate of the clock is only known after the clock has been
enabled. And to save power the clock is only enabled when it is known
that it will be used - and to know that the clocksource/clockevent needs
to be registered first. This in turn means that we are unaware of the
frequency at registration time. Which leads to that it is not sufficient
to use a fixed frequency at registration time but we must instead make
sure the frequency is updated after each clk_enable().

Many thanks to Thomas Gleixner for very useful V1 feedback.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   12 
 drivers/clocksource/Makefile   |    2 
 drivers/clocksource/em_sti.c   |  843 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clockchips.h     |    1 
 kernel/time/clockevents.c      |    3 
 5 files changed, 859 insertions(+), 2 deletions(-)

 
