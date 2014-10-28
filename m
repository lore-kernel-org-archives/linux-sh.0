From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Oct 2014 09:32:32 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <CAMuHMdUnwT7a1Gewz3AW-R9EaQBfYkJ2y7ZQ6uW4GaxBAHXzXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tue, Oct 28, 2014 at 10:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 28, 2014 at 08:59:28AM +0100, Geert Uytterhoeven wrote:
>> On Tue, Oct 28, 2014 at 1:41 AM, Simon Horman <horms@verge.net.au> wrote:
>> > I have noticed that there appears to be a regression between v3.17 and
>> > v3.18-rc1 such that non-multiplatform APE6EVM (ape6evm_defconfig) no longer
>> > boots.  This appears to be the case using both reference DT (MACH_APE6EVM)
>>
>> How does it manifest itself?
>> If you don't get any console output, have you tried my early debug patch?
>
> IIRC, there was no console output.
> I have not tried any out-of tree debug code :)

Perhaps it should just move in-tree?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
