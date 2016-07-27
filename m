From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jul 2016 07:59:43 +0000
Subject: Re: [PATCH v4 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <17153052.5VBjvy6GiN@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469594843.git.dalias@libc.org> <2cc63c8ecc2653f71bf9aec02501871e2407aae0.1469594844.git.dalias@libc.org>
In-Reply-To: <2cc63c8ecc2653f71bf9aec02501871e2407aae0.1469594844.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Wednesday, July 27, 2016 5:35:09 AM CEST Rich Felker wrote:
> +
> +static void __init jcore_pit_init(struct device_node *node)
> +{
> +       int err;
> +       __iomem void *pit_base;
> +       unsigned pit_irq;
> +       unsigned cpu;
> +       struct jcore_pit_nb *nb = 0;
> +       struct jcore_clocksource *cs = 0;
> +       struct jcore_pit __percpu *pit_percpu = 0;
> 

This no longer applies, as the return type of the init function is
now 'int', not 'void'.

	Arnd
