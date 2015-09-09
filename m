From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Sep 2015 01:45:10 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150909014510.GA9291@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Tue, Sep 08, 2015 at 02:06:17AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/02/2015 10:26 AM, Geert Uytterhoeven wrote:

[snip]

> >>   It seems to me that the above basically splits the single interrupt
> >>   in Gen2 into two.
> >>
> >>   This is the default mode for the hardware and the mode it ends up
> >>   in using the current driver implementation (+ this series which doesn't
> >>   alter the initialisation of the hardware).
> 
>    This is also assuming that the bootloader doesn't change it. Are we sure
> it doesn't?

If it is important I can check with regards to the current uboot (plans).

From my point of view it is a reasonable assumption to make.

[snip]

> >>But for now:
> >>* Only describe the interrupts that are used and default to mode 1 with the
> >>   data interrupt and;
> >>* Defer defining properties to switch to combinations
> >>
> >>I am all ears for other ideas.
> >
> >I think there should be either a single multiplexed interrupt (for Gen2),
> >or a list of named interrupts ("ch%u"), of which ch22/ch23 and ch24 are
> >mandatory (for Gen3).
> 
>    No, all IRQs should be mandatory. Otherwise we're into describing the
> config. again, not the real hardware.

That is fine by me.

[snip]
