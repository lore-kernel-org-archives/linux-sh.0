From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 03 Jul 2015 14:17:13 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <alpine.DEB.2.11.1507031612410.3916@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana> <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
In-Reply-To: <20150703133245.GA19284@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 3 Jul 2015, Wolfram Sang wrote:

> 
> > So with high res timers it boots. Can you please provide the output of
> > /proc/timer_list for that case?

> Tick Device: mode:     1
> Per CPU device: 0
> Clock Event Device: e0180000.timer
>  max_delta_ns:   131071523464982
>  min_delta_ns:   61035
>  mult:           70369
>  shift:          31
>  mode:           3
>  next_event:     40760000000 nsecs
>  set_next_event: em_sti_clock_event_next
>  set_mode:       em_sti_clock_event_mode
>  event_handler:  hrtimer_interrupt
>  retries:        0

So this is a single core machine and uses the em_sti timer w/o the
broadcast nonsense. In Simons case it looks like em_sti is used as
broadcast device.

Though the issues you see in the highres=n case might be the same as
the ones Simon is observing.

So in that nohz=y highres=n case, does adding idle=poll on the command
line fix the issue?

Thanks,

	tglx
