From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Oct 2015 01:43:23 +0000
Subject: [PATCH] clocksource: sh_mtu2: Fix multiple shutdown call issue
Message-Id: <20151028014323.29894.70699.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: daniel.lezcano@linaro.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, chris.brandt@renesas.com, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

On the r7s72100 Genmai board the MTU2 driver currently triggers a common
clock framework WARN_ON(enable_count) when disabling the clock due to
the MTU2 driver after recent callback rework may call ->set_state_shutdown()
multiple times. A similar issue was spotted for the TMU driver and fixed in:
452b132 clocksource/drivers/sh_tmu: Fix traceback spotted in -next

On r7s72100 Genmai v4.3-rc7 built with shmobile_defconfig spits out the
following during boot:

sh_mtu2 fcff0000.timer: ch0: used for clock events
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:675 clk_core_disable+0x2c/0x6c()
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.3.0-rc7 #1
Hardware name: Generic R7S72100 (Flattened Device Tree)
Backtrace:
[<c00133d4>] (dump_backtrace) from [<c0013570>] (show_stack+0x18/0x1c)
 r6:c0621fde r5:00000009 r4:00000000 r3:00200040
 [<c0013558>] (show_stack) from [<c01c7aac>] (dump_stack+0x74/0x90)
 [<c01c7a38>] (dump_stack) from [<c00272fc>] (warn_slowpath_common+0x88/0xb4)
  r4:00000000 r3:00000000
  [<c0027274>] (warn_slowpath_common) from [<c0027400>] (warn_slowpath_null+0x24/0x2c)
   r8:c78c0400 r7:c7ee8df8 r6:00000000 r5:600001d3 r4:c7806480
   [<c00273dc>] (warn_slowpath_null) from [<c03a9320>] (clk_core_disable+0x2c/0x6c)
   [<c03a92f4>] (clk_core_disable) from [<c03aa0a0>] (clk_disable+0x40/0x4c)
    r4:c791be40 r3:00000000
    [<c03aa060>] (clk_disable) from [<c0395d2c>] (sh_mtu2_disable+0x24/0x50)
     r5:00000001 r4:c7963c00
     [<c0395d08>] (sh_mtu2_disable) from [<c0395d6c>] (sh_mtu2_clock_event_shutdown+0x14/0x1c)
      r4:c7963c40 r3:c0395d58
      [<c0395d58>] (sh_mtu2_clock_event_shutdown) from [<c007d7d0>] (clockevents_switch_state+0xc8/0x114)
      [<c007d708>] (clockevents_switch_state) from [<c007d834>] (clockevents_shutdown+0x18/0x28)
       r5:c7963c40 r4:c7963c40
       [<c007d81c>] (clockevents_shutdown) from [<c007dd58>] (clockevents_exchange_device+0x70/0x78)
        r4:00000000 r3:00000000
	[<c007dce8>] (clockevents_exchange_device) from [<c007e578>] (tick_check_new_device+0x88/0xe0)
	 r5:00000000 r4:c7963c40
	 [<c007e4f0>] (tick_check_new_device) from [<c007daf0>] (clockevents_register_device+0xac/0x120)
	  r7:00000000 r6:a0000153 r5:c06ffe98 r4:c7963c40
	  [<c007da44>] (clockevents_register_device) from [<c0395be8>] (sh_mtu2_probe+0x230/0x350)
	   r6:00000000 r5:c7963c00 r4:c791b040 r3:c06ff134
	   [<c03959b8>] (sh_mtu2_probe) from [<c028b6f0>] (platform_drv_probe+0x50/0x98)

Reported-by: Chris Brandt <chris.brandt@renesas.com>
Fixes: 19a9ffb ("clockevents/drivers/sh_mtu2: Migrate to new 'set-state' interface")
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clocksource/sh_mtu2.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/drivers/clocksource/sh_mtu2.c
+++ work/drivers/clocksource/sh_mtu2.c	2015-10-27 16:20:07.350513000 +0900
@@ -280,7 +280,9 @@ static int sh_mtu2_clock_event_shutdown(
 {
 	struct sh_mtu2_channel *ch = ced_to_sh_mtu2(ced);
 
-	sh_mtu2_disable(ch);
+	if (clockevent_state_periodic(ced))
+		sh_mtu2_disable(ch);
+
 	return 0;
 }
 
