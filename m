From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 08 Sep 2015 17:26:31 +0000
Subject: Re: [PATCH 0/2] irqchip: renesas: Propagate wake-up settings to parent
Message-Id: <55EF1A47.2040904@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 08/09/15 18:00, Geert Uytterhoeven wrote:
> 	Hi Thomas, Jason, Marc,
>
> The renesas-intc-irqpin and renesas-irqc interrupt controllers are
> cascaded to GICs, but their drivers don't propagate wake-up settings to
> their parent interrupt controllers.
>
> Since commit aec89ef72ba6c944 ("irqchip/gic: Enable SKIP_SET_WAKE and
> MASK_ON_SUSPEND"), the GIC driver masks interrupts during suspend, and
> wake-up through gpio-keys now fails on r8a73a4/ape6evm,
> r8a7740/armadillo and sh73a0/kzm9g.
>
> Fix this by propagating wake-up settings to the parent interrupt
> controllers. There's no need to handle irq_set_irq_wake() failures, as
> the renesas-intc-irqpin and renesas-irqc interrupt controllers are
> always cascaded to GICs, and the GIC driver always sets SKIP_SET_WAKE
> since the aforementioned commit.
>

Ah so, we have the first culprit. I expect many more to come, as I had
seen many drivers didn't bother to enable wakeup source correctly.

> These fixes are meant for v4.3, as commit aec89ef72ba6c944 is already
> upstream.
>

Looks fine to me, so for the series:
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Note that masking GIC interrupts during suspend has another side effect:
> before, if no_console_suspend was enabled, the system woke up on console
> activity. This is no longer the case, but that's not a bug.
>

It's very much similar to IRQF_NO_SUSPEND flag which keeps the IRQ
enabled but doesn't guarantee wakeup. no_console_suspend doesn't suspend
console but doesn't mean it can wake up. I expected this to come up :)
IIUC, it was added to help in debugging the suspend path.

Regards,
Sudeep
