From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2014 10:14:21 +0000
Subject: Re: [Issue] access cpu_cycles PMU conter in r8a7791
Message-Id: <CAMuHMdWMsOKxhfh1UPfGFKR+gLKDnYUVrMnrEHQ4QFrDid2GUA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <543E64EC.7090009@cn.fujitsu.com>
In-Reply-To: <543E64EC.7090009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wen-san,

On Wed, Oct 15, 2014 at 2:13 PM, Chai Wen <chaiw.fnst@cn.fujitsu.com> wrote:
> I am planing to use pmu counter cpu_cycles to measure the elapsed time of some small pieces of code.
> But I found that I can not make the PMU work properly.
>
> My cpu is called r8a7791, a 2-core cpu. And the kernel version is 3.10.31.
> The following is my simple code to test it and its result.
>
> I found that no matter what's the scale of this loop:
>         for (i = 0; i < loops; i++) {
>                 __asm__ __volatile__("mov r0, r0\n\t");
>         }
>         the cycles counts got via:
>         __asm__ __volatile__("MRC p15, 0, %0, c9, c13, 0\n\t" : "=r"(count));
>         are not significantly different from each other. I am confused about these values.
>
> Any comment or help is appreciated, thanks a lot.
>
> ============
> num of counters: 6
> before count: 0
> loops is 100 takes cycles 104665
> num of counters: 6
> before count: 0
> loops is 500 takes cycles 104650
> num of counters: 6
> before count: 0
> loops is 1000 takes cycles 104827
> num of counters: 6
> before count: 0
> loops is 5000 takes cycles 120351
> num of counters: 6
> before count: 0
> loops is 10000 takes cycles 105041
> num of counters: 6
> before count: 0
> loops is 50000 takes cycles 115470
> num of counters: 6
> before count: 0
> loops is 100000 takes cycles 107905
> num of counters: 6
> before count: 0
> loops is 500000 takes cycles 120427
> num of counters: 6
> before count: 9
> loops is 1000000 takes cycles 145033

I get similar results when compiling your test program as a loadable
module. When built-in, the results look saner, but still not perfect.

After wrapping everything in local_irq_save(flags) / local_irq_restore(flags),
and moving the printk() outside the measurement loop, it looks much better:

On r8a7791:

num of counters: 6
before count: 0
loops is 100 takes cycles 26
num of counters: 6
before count: 0
loops is 1000 takes cycles 265
num of counters: 6
before count: 0
loops is 10000 takes cycles 2656
num of counters: 6
before count: 0
loops is 100000 takes cycles 26563
num of counters: 6
before count: 0
loops is 1000000 takes cycles 265625
num of counters: 6
before count: 0
loops is 10000000 takes cycles 2656250
num of counters: 6
before count: 0
loops is 100000000 takes cycles 26562500

On r8a7740:

num of counters: 6
before count: 0
loops is 100 takes cycles 5
num of counters: 6
before count: 0
loops is 1000 takes cycles 40
num of counters: 6
before count: 0
loops is 10000 takes cycles 391
num of counters: 6
before count: 0
loops is 100000 takes cycles 3907
num of counters: 6
before count: 0
loops is 1000000 takes cycles 39063
num of counters: 6
before count: 0
loops is 10000000 takes cycles 390626
num of counters: 6
before count: 0
loops is 100000000 takes cycles 3906255

Thanks a lot for your test code, I was just about to do high-resolution
measurements on r8a7740 anyway ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
