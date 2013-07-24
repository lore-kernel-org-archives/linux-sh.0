From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:23:20 +0000
Subject: Re: EMEV2: debugging a Strange IRQ issue on SMP
Message-Id: <CANqRtoSSrxAHZ35HD_jKBOqGDZ46L=C8Opud2p_34yXYDERekw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51ED68B8.3070302@codethink.co.uk>
In-Reply-To: <51ED68B8.3070302@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ian,

On Tue, Jul 23, 2013 at 9:34 PM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> Update 2:
>
> The problem appears to have been "fixed" by adding a small (5, thus far)
> value to the next timer event to be set, in the sti timer code.
>
> With this hack, I get reliable timer IRQs. I will investigate further and
> submit a patch shortly.

Unless you've fixed this locally already, you may want to have a look at:

[PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP broadcast

Looking forward to see your patches!

Cheers,

/ magnus
