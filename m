From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Aug 2016 10:23:48 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <1815946.6MSqSqog7A@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org> <20160824214444.GZ15995@brightrain.aerifal.cx> <3621664.0azN3a5cxy@wuerfel>
In-Reply-To: <3621664.0azN3a5cxy@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wednesday, August 24, 2016 11:57:08 PM CEST Arnd Bergmann wrote:
> > I'm not familiar with those classifications, but from what I can tell,
> > BE32 describes it correctly. I'll see if I can get someone to verify
> > this. Is there a reason it's not widely used anymore? Perhaps
> > something related to supporting misaligned word-sized loads/stores?
> 
> The main problem I see is that you can't easily use MMIO registers that
> are not 32-bit wide -- you end up having to flip not just the register
> contents but also the lower bits of the address in order to reach
> the right contents of the register.
> 

Actually there is a much more serious problem with BE32/LE32 mode:
doing unaligned access to RAM is a huge pain at the HW level,
and also when emulating it in the kernel on CPUs that require
aligned access. In ARM THUMB2 mode, you can even have unaligned
32-bit instructions.

	Arnd

