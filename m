From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 09 Sep 2015 08:53:36 +0000
Subject: Re: [PATCH 1/2] irqchip: renesas-intc-irqpin: Propagate wake-up settings to parent
Message-Id: <alpine.DEB.2.11.1509091051280.3854@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be> <1441731636-17610-2-git-send-email-geert+renesas@glider.be> <alpine.DEB.2.11.1509082104330.3854@nanos> <CAMuHMdVU+ghBGxEw0qrZ611PwO1n808vcBXPEUxemGyJXS1Mjg@mail.gmail.com>
 <alpine.DEB.2.11.1509082149250.3854@nanos> <55EFF11A.1050400@ti.com>
In-Reply-To: <55EFF11A.1050400@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marc Zyngier <marc.zyngier@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Jason Cooper <jason@lakedaemon.net>, Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 9 Sep 2015, Grygorii Strashko wrote:
> On 09/08/2015 11:03 PM, Thomas Gleixner wrote:
> > So, yes a seperate locking class for that intc trainwreck is probably
> > required.
> > 
> 
> Just as an option, May be we can proceed with patch:
> [PATCH v2 2/6] genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
> http://www.spinics.net/lists/linux-omap/msg121262.html
> 
> As result, irq_chip_set_wake_parent() can be used here and no lockdep issues.

The driver in question is not using hierarchical irq domains. So what
would that patch solve?

Thanks,

	tglx
