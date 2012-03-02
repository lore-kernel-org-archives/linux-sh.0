From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 02 Mar 2012 23:27:45 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <201203030027.46029.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, February 29, 2012, Simon Horman wrote:
> On Wed, Feb 29, 2012 at 12:59:36AM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 28, 2012, Simon Horman wrote:
> > > On Tue, Feb 28, 2012 at 03:09:09PM +0900, Paul Mundt wrote:
> > > > On Tue, Feb 28, 2012 at 02:23:45AM +0100, Rafael J. Wysocki wrote:
> > > > > However, having looked at both sh_tmu and sh_cmt I don't see why the former
> > > > > should break things (during boot), while the latter doesn't, so I've done
> > > > > some more testing and, surprisingly enough, it turns out that disabling runtime
> > > > > PM in sh-sci makes the boot hang with sh_tmu enabled go away.  So perhaps sh_tmu
> > > > > is just a messenger here and the real problem is with sh-sci.
> > > > > 
> > > > > I think that more investigation is needed.
> > > > > 
> > > > Do you see any different behaviour with early printk enabled vs disabled?
> > > > We did have the ordering issues before with the pm calls hanging or
> > > > oopsing in the early path, but all of those should have been fixed
> > > > already. There have been quite a few sh-sci changes though, so if it
> > > > worked previously it should be bisectable at least.
> > > 
> > > Hi Paul, Hi Rafael,
> > > 
> > > I asked Hiep-san (CCed) to see if there was any difference booting a
> > > 3.3-rc3 on a Mackerel without earlyprintk in the kernel commandline.
> > > I tested 3.3-rc5 as well. There does not seem to be any change in behaviour,
> > > other than that specificly relating the bootconsole.
> > > 
> > > Without earlyprintk
> > > ...
> > > SuperH SCI(F) driver initialized
> > > sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> > > sh-sci sh-sci.0: start latency exceeded, new value 6916 ns
> > > console [ttySC0] enabled
> > > [no more output]
> > > 
> > > With earlyprintk
> > > ...
> > > SuperH SCI(F) driver initialized
> > > sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> > > sh-sci sh-sci.0: start latency exceeded, new value 5917 ns
> > > console [ttySC0] enabled, bootconsole disabled
> > > console [ttySC0] enabled, bootconsole disabled
> > > [no more output]
> > 
> > OK, I know what the problem is.
> > 
> > The enabling of sh_tmu apparently triggers the dev_warn() in
> > GENPD_DEV_TIMED_CALLBACK() for sh-sci.0, which leads to a deadlock in the
> > runtime PM core, because synchronous runtime resume for the device is then
> > run from its own runtime suspend callback.
> > 
> > I have an idea how to fix this, but it's going to take a couple of days
> > due to my time constraints.
> 
> Thanks Rafael,
> 
> please don't hesitate to let me know if you need more testing done.

Below is a patch that fixes the boot problem for me.  Please test if it
works for you too.

Unfortunately, we can't detect that deadlock at the core level (at least
I'm not aware of any generally reliable method of doing that) so it has to
be taken care of by the driver.  The alternative would be to remove all
diagnostic messages from runtime PM callbacks that may be used in a
console runtime resume code path, but I think that would be overkill
(those messages are actually useful for other types of devices).

However, this patch only addresses the boot issue, but then, if sh_tmu is
enabled, runtime PM involving the A4R domain and system-level PM lead to
nasty crashes.  Since Paul doesn't like the idea of enabling sh_tmu only
if PM is not enabled, I propose to make it actively fail all PM operations
that would lead to the removal of power from TMU devices.  This is done
in a second patch that will be sent in a reply to this message.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: sh-sci / PM: Avoid deadlocking runtime PM

The runtime PM of sh-sci devices is enabled when sci_probe() returns,
so the pm_runtime_put_sync() executed by driver_probe_device()
attempts to suspend the device.  Then, in some situations, a
diagnostic message is printed to the console by one of the runtime
suspend routines handling the sh-sci device, which causes synchronous
runtime resume to be started from the device's own runtime suspend
callback.  This causes rpm_resume() to be run eventually, which sees
the RPM_SUSPENDING status set by rpm_suspend() and waits for it to
change.  However, the device's runtime PM status cannot change at
that point, because the routine that has set it waits for the
rpm_suspend() to return.  A deadlock occurs as a result.

To avoid that make sci_init_single() increment the device's
runtime PM usage counter, so that it cannot be suspended by
driver_probe_device().  That counter has to be decremented
eventually, so make sci_startup() do that before starting to
actually use the device and make sci_shutdown() increment it
again before returning to balance the incrementation carried out by
sci_startup().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/tty/serial/sh-sci.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux/drivers/tty/serial/sh-sci.c
=================================--- linux.orig/drivers/tty/serial/sh-sci.c
+++ linux/drivers/tty/serial/sh-sci.c
@@ -1710,6 +1710,8 @@ static int sci_startup(struct uart_port
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	pm_runtime_put_noidle(port->dev);
+
 	sci_port_enable(s);
 
 	ret = sci_request_irq(s);
@@ -1737,6 +1739,8 @@ static void sci_shutdown(struct uart_por
 	sci_free_irq(s);
 
 	sci_port_disable(s);
+
+	pm_runtime_get_noresume(port->dev);
 }
 
 static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
@@ -2075,6 +2079,7 @@ static int __devinit sci_init_single(str
 		sci_init_gpios(sci_port);
 
 		pm_runtime_irq_safe(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 
