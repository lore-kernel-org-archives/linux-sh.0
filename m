From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Apr 2009 03:44:51 +0000
Subject: Re: [PATCH] sh_cmt: use remove_irq() and remove clockevent workaround
Message-Id: <20090402034451.GA11576@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090401141107.32445.63752.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090401141107.32445.63752.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 01, 2009 at 11:11:07PM +0900, Magnus Damm wrote:
> Update the sh_cmt driver to make use of recent irq and clockevent changes:
>  - use remove_irq() together with setup_irq()
>  - remove mult workaround since WARN_ON() now has been moved

On Wed, Apr 01, 2009 at 11:20:58PM +0900, Magnus Damm wrote:
> Modify the intc code to install a disable callback. The current
> solution without a disable callback results in use of the
> generic default_disable() function. This function is a no-op
> so suspend_device_irqs() will not disable any intc interrupts
> at suspend time without this patch. Also, install enable and
> shutdown callbacks while at it.

On Wed, Apr 01, 2009 at 11:30:59PM +0900, Magnus Damm wrote:
> Add set_irq_wake() support to intc using sysdev and suspend.
> 
> The intc controllers are put on a list at registration time
> and registered as sysdev devices later on during the boot.
> 
> The sysdev class suspend callback is used to find irqs with
> wakeup enabled belonging to our intc controller. Such irqs
> are simply enabled so wakeup interrupts may reach the cpu.

On Wed, Apr 01, 2009 at 11:39:20PM +0900, Magnus Damm wrote:
> Modify the sh_keysc driver to use enable/disable_irq_wake()
> during suspend and resume. These functions are used to enable
> the sh_keysc interrupt in the interrupt controller so the
> keypad can be used to wakeup the system from suspend.

On Wed, Apr 01, 2009 at 11:45:17PM +0900, Magnus Damm wrote:
> Modify the sh_rtc driver to use set_irq_wake() during suspend
> and resume. These functions are used to enable the rtc interrupts
> in the interrupt controller so the rtc can be used to wakeup the
> system from suspend.

On Wed, Apr 01, 2009 at 11:49:41PM +0900, Magnus Damm wrote:
> Add wakeup support to the migor_ts driver. If user space has enabled
> wakeup, use set_irq_wake() during suspend and resume. With this patch
> the migor_ts driver can be used to wake the system from suspend.

All applied, thanks.
