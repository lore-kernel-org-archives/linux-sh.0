From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 02 Apr 2008 19:32:49 +0000
Subject: Re: Please add ack in intc
Message-Id: <20080402191807.50adf44c.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080322222933.af8a3f29.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080322222933.af8a3f29.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2 Apr 2008 11:09:00 +0900
"Magnus Damm" <magnus.damm@gmail.com> wrote:

> Hi Kristoffer,
> 
> On Sun, Mar 23, 2008 at 2:29 PM, Kristoffer Ericson
> <kristoffer.ericson@gmail.com> wrote:
> > Magnus could you please add an ack into the intc IRQ code, so far I've been unable to silence the interrupts (IRQ0->IRQ5) by any
> >  other means. This should affect 7705-7709-7729 atleast, so would be worth it.
> 
> Yeah, adding code to ack the edge triggered interrupts sounds like a good idea.
> 

Goodie.

> >  Ive tried all modes (level / edge) but it only seems to work right when I use edge and ack the interrupt. without it I get endless
> >  interrupts that basicly freeze the hardware.
> 
> To get level triggered interrupt support you may have to configure the
> chip itself that is hooked up to the IRQ. Do you have any data sheets
> for the chips hooked up to the IRQs?
> 

I believe Ive tried everything essentially, just refuses to work unless edge and acked.

> Also, which drivers are using these interrupts at this point? As a
> stop-gap solution, is it possible to ack the the interrupt from the
> driver? Or are you using some standard driver?
> 

Well, currently for HP6xx theres 3 drivers needing it : touchscreen, powerbutton and hd64461 IRQ.
The HD64461 is quite unaffected by it since the main IRQ (using demux) just ignores spurious IRQ's.

Touchscreen and powerbutton are hp6xx-only drivers so I could add ack manually I guess. My main concern is that
this will come back and bite us in the ass for other platforms. For instance got a harp mobytel dev board
that Im pretty sure will need the same fix.

I got documentation for everything, its available from git://jlime.org/jlime.git under /datasheets/Jornada600-series/.
You could just clone this if you want to take a closer look at the sh7709/hd66461 manuals.

> I remember some broken PINT code in older kernels. Is your hardware
> platform using PINT?

Shouldnt be using any PINT at all.

> 
> Thanks,
> 
> / magnus


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
