From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Aug 2014 16:26:20 +0000
Subject: Re: Armadillo800EVA legacy defconfig seems busted on my board
Message-Id: <CAMuHMdUPCStACBvwC1mqC+Tuhcx4K7nc67-nZqmKXob0hFNT6w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
In-Reply-To: <CANqRtoQ2Epyhtu2yKCHJMG5VXjiOo6eWNFDTNtzwPEEtNnw8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Aug 26, 2014 at 1:00 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Aug 8, 2014 at 10:02 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Aug 8, 2014 at 1:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> On my r8a7740 Armadillo board I've been playing with multiplatform and
>>> CCF recently. While doing that I noticed that the defconfig doesn't
>>> seem to work.
>>>
>>> Maybe this is just my board - the boot loader seems unstable in
>>
>> When starting the kernel, it indeed sometimes hangs after
>>
>>         Doing init=/init

Which is the last line printed by the Hermit bootloader.

>> Usually this happens after cold boot, so remote controlled power switches
>> don't help here.
>
> Hm, I wonder what is causing these issues... INTC? =)

I accidentally found a way to reproduce this. I'm not 100% sure it's the same
cause, but the symptoms look the same.

If power domain D4 (Coresight-ETM) is powered down, the kernel crashes
when suspending from s2ram with:

    Internal error: Oops - undefined instruction: 0 [#1] ARM

dbg_cpu_pm_notify() calls reset_ctrl_regs(), which crashes as D4 is powered
down, and commit 0d352e3d006c9589 ("ARM: hw_breakpoint: trap undef
instruction exceptions in reset_ctrl_regs") doesn't seem to work...

Ater that, pressing the reset switch and booting a Linux kernel gives the
same symptoms as on cold boot.
Pressing the reset switch again and booting a Linux kernel works.

I tried dumping printk() output to RAM and inspecting it later with Hermit,
but no output was saved, so the kernel didn't get that far.

Some more investigation revealed:
  - Just powering down D4 and pressing reset triggers the issue, too,
  - Pressing the reset switch twice without trying to boot a Linux kernel
    in between also works. So it looks like a mis-initialization in Hermit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
