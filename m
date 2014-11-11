From: Kevin Hilman <khilman@kernel.org>
Date: Tue, 11 Nov 2014 15:45:37 +0000
Subject: Re: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
Message-Id: <7hioiloi5a.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141110230301.GV4068@piout.net>
	<1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
	(Boris Brezillon's message of "Tue, 11 Nov 2014 14:33:36 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
> should not be passed as the last argument of
> irq_alloc_domain_generic_chips.
>
> Then pass the correct handler (handle_fasteoi_irq) to
> irq_alloc_domain_generic_chips instead of manually re-setting it in the
> initialization loop.
>
> And eventually initialize default irq flags to the pseudo standard:
> IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
> Hello Kevin,
>
> This patch has not been tested yet but it should solve the issue you've
> experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.
>
> I'll test it tomorrow and let you know if it actually works.

Well, it at least boots on my xplained and my sama5d35-ek:

Tested-by: Kevin Hilman <khilman@linaro.org>

I'll let Jason pick this up as a fix through his tree.

Kevin
