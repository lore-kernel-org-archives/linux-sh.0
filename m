From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 09 Oct 2016 11:03:10 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <alpine.DEB.2.20.1610091301390.5222@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
In-Reply-To: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sun, 9 Oct 2016, Rich Felker wrote:
> Ideas for improvement are welcome -- for example the
> irq_is_percpu(irq_desc_get_irq(desc)) thing looks rather silly but I

See the other mail.

> didn't see a better way without poking through abstractions -- but
> overall I think this both solves the timer stall issue that I wasted
> other people's time on, and addresses the concerns about the J-Core
> AIC driver being oblivious to whether an irq is per-cpu.

You could put that knowledge into the device tree so you can decide at
mapping time whether it is per cpu or not.

Thanks,

	tglx


