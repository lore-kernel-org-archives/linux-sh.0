From: "Jeongdo Son" <sohn9086@gmail.com>
Date: Mon, 10 Mar 2008 01:45:36 +0000
Subject: Re: [BUG REPORT] smc911x: Auto negotiation NOT supported
Message-Id: <59fd4ce80803091845g2979c23ayfa1e53ce221ef846@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <59fd4ce80803062200n203e5cd7o152be120adbdb717@mail.gmail.com>
	 <87a5b0800803070354x391ff718u3af9664804526da1@mail.gmail.com>
In-Reply-To: <87a5b0800803070354x391ff718u3af9664804526da1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Newton <will.newton@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>

Hi, Will

Thanks for your reply.

On Fri, Mar 7, 2008 at 8:54 PM, Will Newton <will.newton@gmail.com> wrote:
>  Are you getting interrupts from the chip? Sounds like it could be you
>  have missed and interrupt somewhere - check where your interrupt
>  polarities and where you are acking/clearing them down.
>

I think there's no problem with getting interrupts.
Because the driver works well while eth0 is configured for DHCP mode.
Only static IP allocation occurs the problem.

Here is the /proc/interrupts.
(The interrupt for eth0 is recognized as IRQ 9)
~ $ cat /proc/interrupts
           CPU0
  3:         46  sh7780-irl3210-level     rtc-62423a period
  6:         67  sh7780-irl3210-level     r8a66597_hcd:usb1
  9:         96  sh7780-irl3210-level     eth0
 12:          0  sh7780-irl3210-level     fb0
 13:          0  sh7780-irl3210-level     fb0
 28:      11366          sh7780-level     periodic timer
 38:          0          sh7780-level     DMAC Address Error
 40:          0          sh7780-level     SCI Receive Error
 41:         62          sh7780-level     SCI Receive Data Full
 42:          0          sh7780-level     SCI Break
 43:       1901          sh7780-level     SCI Transmit Data Empty
 68:          1          sh7780-level     yenta
Err:          0

Regards,
Jeongdo Son
