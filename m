From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 25 Aug 2016 08:07:08 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <alpine.DEB.2.20.1608250947120.5714@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org> <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org> <57BDCE5D.2050609@linaro.org> <20160824174001.GW15995@brightrain.aerifal.cx>
In-Reply-To: <20160824174001.GW15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>

Rich,

On Wed, 24 Aug 2016, Rich Felker wrote:
> I don't think that's a correct characterization. Rather the percpu
> infrastructure just means something completely different from what you
> would expect it to mean. It has nothing to do with the hardware but
> rather with kernel-internal choice of whether to do percpu devid
> mapping inside the irq infrastructure, and the choice at the
> irq-requester side of whether to do this is required to match the
> irqchip driver's choice. I explained this better in another email
> which I could dig up if necessary, but the essence is that
> request_percpu_irq is a misnamed and unusably broken API.

I slowly get tired about your permanent ranting about misnamed, misdesigned
and unusable code in the kernel.

The percpu infrastructure was designed explicitely to reflect the hardware and
is not a random kernel internal choice. It's there to handle the situation
where a single interrupt number is actually available on each CPU.

ARM has a very clear distinction between PPI (per processor interrutps) and
SPI (shared peripheral interrupts). So we end up with the following interrupt
space:

IRQ	CPU0	CPU1
0	PPI	PPI
...	...	...
15	PPI	PPI

16	SPI	SPI
...
N	SPI	SPI

The fundamental difference between PPI and SPI is that PPIs originate from the
CPU itself or are injected as IPIs targeted to a particular CPU. Each CPU has
its own interrupt controller to mask/ack/... PPIs.

The SPIs have a shared interrupt controller and therefor are globally shared
between all cpus.

The percpu infrastructure reflects exaclty this scenario and allows us to
handle PPIs with the same irq number (which makes a lot of sense) seperately
on each CPU.

So how does this not reflect the hardware?

If your particular hardware has the old scheme of seperate interrupt numbers
for per cpu interrupts, then you can simply use the normal interrupt scheme
and request a seperate interrupt per cpu.

Just because something does not fit your needs and does not match your SH
blinkered worldview does not make it misnamed, misdesigned and unusable.

If you want to work with this community you really should start to talk
constructive with us and stop this unjustified ranting attitude.

Thanks,

	tglx




