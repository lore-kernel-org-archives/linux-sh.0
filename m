From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Date: Wed, 23 Mar 2016 10:43:32 +0000
Subject: Re: [PREEMPT-RT] FROZEN transition in hotplug notifier
Message-Id: <alpine.DEB.2.11.1603231142170.30089@hypnos>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Tue, 22 Mar 2016, Rich Felker wrote:
> On Tue, Mar 22, 2016 at 06:20:48PM +0100, Anna-Maria Gleixner wrote:
> > 
> > the hotplug notifier in arch/sh/kernel/cpu/sh4a/smp-shx3.c doesn't
> > handle the corresponding FROZEN transitions. Is there a reason for it?
> 
> Is this an issue you're hitting or just something you noticed reading
> the source? Not that this affects the validity of your observation,
> but I have no idea where to get SH-X3 hardware, whether anyone is
> actually using it, and whether such transitions make sense as
> something that can actually happen on the hardware.

In case CPUs of SH hardware can suspend/resume, the FROZEN states
should be considered. Normaly they are handled the same way than non
frozen states.

Anna-Maria
