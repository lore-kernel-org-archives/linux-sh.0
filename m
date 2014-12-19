From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Dec 2014 00:03:00 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <CANqRtoQbtp_vgmcooiWpUvBMP7txGeYVGT-oLkRfMiM6Y51BQg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
	<CAMuHMdUzys9pbEjUybyDP-3=uemLZuP5WgXeyONxGmADUJJL4A@mail.gmail.com>
	<CANqRtoRTcC_ixjY_Qr1T=2Jhh9qu_5+=Z3YRBDUJX8HWHP6Nog@mail.gmail.com>
	<2855304.l47b4KVhTf@avalon>
In-Reply-To: <2855304.l47b4KVhTf@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Laurent,

On Wed, Dec 17, 2014 at 11:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Magnus, you have told me that you've performed tests on Marzen with
> CONFIG_PREEMPT_NONE and with both TWD enabled and disabled. If you could
> perform the same tests with CONFIG_PREEMPT instead without noticing any
> regression I think we can merge your patch. Whatever breakage it has caused in
> the past is likely hidden somewhere beyond eyesight.

I've now successfully boot tested the different PREEMPT settings on
r8a7779 Marzen multiplatform. Everything seems to work as expected.

Compared to before I've been a bit more lazy, so I've kept the timer
config to default which means TWD and TMU enabled. The kernel tree is
renesas-devel-20141218-v3.18 which is v3.18 plus local integration
stuff including TWD DT. I've applied this patch too.

Thanks,

/ magnus
