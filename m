From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Aug 2011 06:44:00 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index enum
Message-Id: <CANqRtoSTridT50KXHQHLhP94_QMCNvfCYO0nxhH_BskE9gw2kg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
	<1313716221-20136-5-git-send-email-horms@verge.net.au>
	<CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
	<20110819052004.GB17548@verge.net.au>
In-Reply-To: <20110819052004.GB17548@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 2:20 PM, Simon Horman <horms@verge.net.au> wrote:
...
> Moreover, I think that there needs to be some agreement between Guennadi
> and yourself with regards to what IRQ combinations are valid before I (or
> anyone else) can implement something that is acceptable to you both. And
> I think that in the mean time the current implementation is reasonable
> given that it works with all current use-cases (and several non-existent
> ones too).

The most common use cases for SDHI are:

Soldered-on SD/MMC hardware:
1) SDIO module (for wifi for instance)
Data IRQ + SDIO IRQ

2) eMMC chip
Data IRQ

External SD/MMC slot:
3) On hardware platforms with GPIO hotplug:
Data IRQ + SDIO IRQ

4) On hardware platforms without GPIO hotplug:
Hotplug IRQ + Data IRQ + SDIO IRQ

Legacy support:
5) Common ISR
All present IRQs

To keep things simple and flexible I would prefer if the platform
device could freely specify which interrupts to make use of. And still
have the legacy behavior.

Thanks,

/ magnus
