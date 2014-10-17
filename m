From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Oct 2014 05:15:50 +0000
Subject: Re: [Issue] access cpu_cycles PMU conter in r8a7791
Message-Id: <CANqRtoTNogcSuZRZLkJtPs8bzqHQ5uXnAwFdBdCuH4WMdOL9WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <543E64EC.7090009@cn.fujitsu.com>
In-Reply-To: <543E64EC.7090009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Chai Wen,

On Wed, Oct 15, 2014 at 2:13 PM, Chai Wen <chaiw.fnst@cn.fujitsu.com> wrote:
> Hi developers,
>
> Sorry for some disturbing.
>
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

I'm not aware of any known issue like this, however I do notice that
you are using a rather old kernel version. The kernel version may be
unrelated to the root cause of your issue, however from a community
stand point I recommend that you try to reproduce this issue on the
latest upstream with the most recent boot loader for your board. If
upstream is not working then we need to fix that first.

Cheers,

/ magnus
