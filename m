From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 23 Sep 2011 22:58:37 +0000
Subject: Re: [BUG] on sh7372 (mackerel) with today's Linus' (github) master
Message-Id: <201109240058.37907.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Saturday, September 24, 2011, Rafael J. Wysocki wrote:
> Hi,
> 
> On Friday, September 23, 2011, Guennadi Liakhovetski wrote:
> > Hi
> > 
> > Not a very pleasant message from an -rc7 kernel:
> 
> Well, I wonder why I can't reproduce this.
> 
> > [    9.906250] BUG: sleeping function called from invalid context at /home/lyakh/software/project/24/src/linux-2.6/kernel/mutex.c:271
> > [    9.906250] in_atomic(): 1, irqs_disabled(): 128, pid: 167, name: modprobe
> > [    9.906250] 3 locks held by modprobe/167:
> > [    9.906250]  #0:  (&__lockdep_no_validate__){......}, at: [<c0176114>] __driver_attach+0x48/0x94
> > [    9.906250]  #1:  (&__lockdep_no_validate__){......}, at: [<c0176124>] __driver_attach+0x58/0x94
> > [    9.906250]  #2:  (&(&pcd->lock)->rlock){......}, at: [<c017f0d4>] pm_clk_resume+0x28/0x88
> > [    9.906250] Backtrace: 
> > [    9.906250] [<c0012434>] (dump_backtrace+0x0/0x110) from [<c024f8f0>] (dump_stack+0x18/0x1c)
> > [    9.906250]  r6:00000000 r5:cf0dde20 r4:cf798000 r3:60000093
> > [    9.906250] [<c024f8d8>] (dump_stack+0x0/0x1c) from [<c001da88>] (__might_sleep+0x100/0x120)
> > [    9.906250] [<c001d988>] (__might_sleep+0x0/0x120) from [<c025192c>] (mutex_lock_nested+0x2c/0x2fc)
> > [    9.906250]  r4:c0356808
> > [    9.906250] [<c0251900>] (mutex_lock_nested+0x0/0x2fc) from [<c01a5a44>] (clk_get_sys+0x2c/0xf4)
> > [    9.906250]  r8:00000000 r7:00000000 r6:00000000 r5:cf0dde20 r4:c0356808
> > [    9.906250] [<c01a5a18>] (clk_get_sys+0x0/0xf4) from [<c01a5b34>] (clk_get+0x28/0x2c)
> > [    9.906250] [<c01a5b0c>] (clk_get+0x0/0x2c) from [<c017f094>] (pm_clk_acquire+0x18/0x30)
> > [    9.906250] [<c017f07c>] (pm_clk_acquire+0x0/0x30) from [<c017f0f8>] (pm_clk_resume+0x4c/0x88)
> > [    9.906250]  r4:cf0dcf40 r3:00000000
> > [    9.906250] [<c017f0ac>] (pm_clk_resume+0x0/0x88) from [<c017c6b8>] (rpm_callback+0x4c/0x6c)
> > [    9.906250]  r8:cf798000 r7:c0333be0 r6:c0333be0 r5:c0333b50 r4:c017f0ac
> > [    9.906250] r3:00000001
> > [    9.906250] [<c017c66c>] (rpm_callback+0x0/0x6c) from [<c017d3f0>] (rpm_resume+0x300/0x3d4)
> > [    9.906250]  r6:00000000 r5:c03520c8 r4:c0333b50 r3:c0331fb8
> > [    9.906250] [<c017d0f0>] (rpm_resume+0x0/0x3d4) from [<c017d750>] (__pm_runtime_resume+0x50/0x68)
> > [    9.906250] [<c017d700>] (__pm_runtime_resume+0x0/0x68) from [<bf016834>] (sh_mobile_i2c_xfer+0x3c/0x37c [i2c_sh_mobile])
> > [    9.906250]  r7:00000002 r6:00000009 r5:cf799cc0 r4:cf64f800
> > [    9.906250] [<bf0167f8>] (sh_mobile_i2c_xfer+0x0/0x37c [i2c_sh_mobile]) from [<bf0016ec>] (i2c_transfer+0x98/0xe4 [i2c_core])
> > [    9.906250] [<bf001654>] (i2c_transfer+0x0/0xe4 [i2c_core]) from [<bf001bb0>] (i2c_smbus_xfer+0x3cc/0x504 [i2c_core])
> > [    9.906250] [<bf0017e4>] (i2c_smbus_xfer+0x0/0x504 [i2c_core]) from [<bf001fdc>] (i2c_smbus_read_byte_data+0x3c/0x4c [i2c_core])
> > [    9.906250] [<bf001fa0>] (i2c_smbus_read_byte_data+0x0/0x4c [i2c_core]) from [<bf0910d8>] (tca6416_read_reg+0x48/0x8c [tca6416_keypad])
> > [    9.906250] [<bf091090>] (tca6416_read_reg+0x0/0x8c [tca6416_keypad]) from [<bf091500>] (tca6416_keypad_probe+0x1dc/0x3a0 [tca6416_keypad])
> > [    9.906250]  r7:00000030 r6:c033d204 r5:cf3dd800 r4:cf1ff0a0
> > [    9.906250] [<bf091324>] (tca6416_keypad_probe+0x0/0x3a0 [tca6416_keypad]) from [<bf0005cc>] (i2c_device_probe+0x7c/0xa4 [i2c_core])
> > [    9.906250] [<bf000550>] (i2c_device_probe+0x0/0xa4 [i2c_core]) from [<c0176010>] (driver_probe_device+0xd0/0x18c)
> > [    9.906250]  r6:bf091878 r5:cf64f054 r4:cf64f020 r3:bf000550
> > [    9.906250] [<c0175f40>] (driver_probe_device+0x0/0x18c) from [<c017613c>] (__driver_attach+0x70/0x94)
> > [    9.906250]  r7:00000000 r6:bf091878 r5:cf64f054 r4:cf64f020
> > [    9.906250] [<c01760cc>] (__driver_attach+0x0/0x94) from [<c01757a4>] (bus_for_each_dev+0x54/0x84)
> > [    9.906250]  r6:00000000 r5:c01760cc r4:bf091878 r3:00000000
> > [    9.906250] [<c0175750>] (bus_for_each_dev+0x0/0x84) from [<c0175e34>] (driver_attach+0x20/0x28)
> > [    9.906250]  r6:bf002df8 r5:cf3ef440 r4:bf091878
> > [    9.906250] [<c0175e14>] (driver_attach+0x0/0x28) from [<c017506c>] (bus_add_driver+0xa8/0x228)
> > [    9.906250] [<c0174fc4>] (bus_add_driver+0x0/0x228) from [<c01767c8>] (driver_register+0xb0/0x140)
> > [    9.906250] [<c0176718>] (driver_register+0x0/0x140) from [<bf0009a4>] (i2c_register_driver+0x48/0xb4 [i2c_core])
> > [    9.906250]  r8:00000001 r7:00000000 r6:00000001 r5:bf093000 r4:bf091850
> > [    9.906250] r3:bf002df8
> > [    9.906250] [<bf00095c>] (i2c_register_driver+0x0/0xb4 [i2c_core]) from [<bf093018>] (tca6416_keypad_init+0x18/0x24 [tca6416_keypad])
> > [    9.906250]  r5:bf093000 r4:bf0918c4
> > [    9.906250] [<bf093000>] (tca6416_keypad_init+0x0/0x24 [tca6416_keypad]) from [<c0009374>] (do_one_initcall+0xa0/0x170)
> > [    9.906250] [<c00092d4>] (do_one_initcall+0x0/0x170) from [<c005583c>] (sys_init_module+0xd24/0xf48)
> > [    9.906250]  r9:0000001b r8:00000001 r7:cf5793a0 r6:00000001 r5:bf09190c
> > [    9.906250] r4:bf0918c4
> > [    9.906250] [<c0054b18>] (sys_init_module+0x0/0xf48) from [<c000efc0>] (ret_fast_syscall+0x0/0x30)
> > [    9.960937] input: tca6408-keys as /devices/platform/i2c-sh_mobile.0/i2c-0/0-0020/input/input0
> 
> There is a bug in pm_clk_suspend() (and analogously in pm_clk_resume())
> that calls pm_clk_acquire() under a spinlock, but pm_clk_acquire()
> calls clk_get().
> 
> I'm not sure how to fix this at the moment.  We may need to revert commits
> b7ab83e and 5a50a01, although I would hate that, because it would require us
> to fix sh-sci runtime PM in a different way.
> 
> I'll try to figure out something over the weekend.

Well, since nobody seems to execute anything that may sleep under
clocks_mutex, perhaps we can do something like this:

---
 drivers/clk/clkdev.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Index: linux/drivers/clk/clkdev.c
=================================--- linux.orig/drivers/clk/clkdev.c
+++ linux/drivers/clk/clkdev.c
@@ -21,7 +21,7 @@
 #include <linux/clkdev.h>
 
 static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
+static DEFINE_SPINLOCK(clocks_lock);
 
 /*
  * Find the correct struct clk for the device and connection ID.
@@ -64,12 +64,13 @@ static struct clk_lookup *clk_find(const
 struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
 	struct clk_lookup *cl;
+	unsigned long flags;
 
-	mutex_lock(&clocks_mutex);
+	spin_lock_irqsave(&clocks_lock, flags);
 	cl = clk_find(dev_id, con_id);
 	if (cl && !__clk_get(cl->clk))
 		cl = NULL;
-	mutex_unlock(&clocks_mutex);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 
 	return cl ? cl->clk : ERR_PTR(-ENOENT);
 }
@@ -91,20 +92,24 @@ EXPORT_SYMBOL(clk_put);
 
 void clkdev_add(struct clk_lookup *cl)
 {
-	mutex_lock(&clocks_mutex);
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
 	list_add_tail(&cl->node, &clocks);
-	mutex_unlock(&clocks_mutex);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 EXPORT_SYMBOL(clkdev_add);
 
 void __init clkdev_add_table(struct clk_lookup *cl, size_t num)
 {
-	mutex_lock(&clocks_mutex);
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
 	while (num--) {
 		list_add_tail(&cl->node, &clocks);
 		cl++;
 	}
-	mutex_unlock(&clocks_mutex);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 }
 
 #define MAX_DEV_ID	20
@@ -167,9 +172,11 @@ EXPORT_SYMBOL(clk_add_alias);
  */
 void clkdev_drop(struct clk_lookup *cl)
 {
-	mutex_lock(&clocks_mutex);
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks_lock, flags);
 	list_del(&cl->node);
-	mutex_unlock(&clocks_mutex);
+	spin_unlock_irqrestore(&clocks_lock, flags);
 	kfree(cl);
 }
 EXPORT_SYMBOL(clkdev_drop);
