From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 22 Apr 2008 08:06:28 +0000
Subject: Re: Please add ack in intc
Message-Id: <20080422100628.13e57d39.Kristoffer.Ericson@Gmail.com>
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
> >  Ive tried all modes (level / edge) but it only seems to work right when I use edge and ack the interrupt. without it I get endless
> >  interrupts that basicly freeze the hardware.
> 
> To get level triggered interrupt support you may have to configure the
> chip itself that is hooked up to the IRQ. Do you have any data sheets
> for the chips hooked up to the IRQs?
> 
> Also, which drivers are using these interrupts at this point? As a
> stop-gap solution, is it possible to ack the the interrupt from the
> driver? Or are you using some standard driver?
> 
> I remember some broken PINT code in older kernels. Is your hardware
> platform using PINT?
> 
> Thanks,

Magnus, you got any update on this?

> 
> / magnus


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
