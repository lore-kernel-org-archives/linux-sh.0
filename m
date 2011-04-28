From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 28 Apr 2011 07:03:16 +0000
Subject: Re: [PATCH] input: sh_keysc: Switch to threaded IRQ handler
Message-Id: <20110428070315.GA2629@core.coreip.homeip.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421133824.8698.22092.sendpatchset@t400s>
 <20110428062952.GF31734@core.coreip.homeip.net>
 <BANLkTi=t0p-m-nNssH8dF6K00aX+6mt60w@mail.gmail.com>
In-Reply-To: <BANLkTi=t0p-m-nNssH8dF6K00aX+6mt60w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, simon@horms.net, linux-sh@vger.kernel.org

On Thu, Apr 28, 2011 at 03:46:16PM +0900, Magnus Damm wrote:
> On Thu, Apr 28, 2011 at 3:29 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Apr 21, 2011 at 10:38:24PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Update the KEYSC driver to make use of threaded IRQs
> >> with IRQF_ONESHOT.
> >>
> >
> > Explanation of why this is needed is missing.
> >
> > Thanks.
> 
> Sorry for not giving you a more complete commit message.
> 
> The reason for this change is to improve interrupt latency. This
> driver is using udelay() in the ISR to make sure the hardware has
> stabilized. Without using interrupt threads this delay may affect the
> latency of the rest of the system.
> 
> Would you like me to resend a V2?

No, I'll just put the above in.

Thanks.

-- 
Dmitry
