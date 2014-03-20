From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2014 12:13:28 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <CAMuHMdW+p3gdZ8k3RmOWNws5A1gSiUJM3KEJK_NTM93K+zPqqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Mar 20, 2014 at 1:01 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 20 March 2014 09:56:17 Ben Dooks wrote:
>> On 19/03/14 20:06, Geert Uytterhoeven wrote:
>> > This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
>> > running a multi-platform ARM kernel including support for shmobile.
>> > Before this code was only enabled for legacy shmobile kernels, leading to
>> > disabled clocks in multiplatform kernels, depending on implicit reset
>> > state or on the bootloader.
>> >
>> >    [1/5] drivers: sh: pm_runtime does not need idle callback
>> >    [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
>>
>> I thought there was already a of capable intc driver in the
>> irq drivers directory?
>
> I think Ben's point is that drivers/sh/intc might be completely unneeded for
> ARM.

http://www.spinics.net/lists/linux-sh/msg30067.html

"Furthermore, the core intc parts are used by sh7372/mackerel and
 sh73a0/kzm9g (and arch/sh) only, so I'm gonna restrict it to
 ARCH_SHMOBILE_LEGACY and SUPERH only."

Despite the names, sh7372 and sh73a0 are ARM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
