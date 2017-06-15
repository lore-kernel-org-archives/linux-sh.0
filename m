From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jun 2017 06:26:08 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <CAMuHMdUSOkL0Kn=3XitnnBGKvw-XsTeLi9uCSSpmJ_qR6arieQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Thu, Jun 15, 2017 at 3:07 AM, Rob Landley <rob@landley.net> wrote:
> On 06/14/2017 08:48 AM, John Paul Adrian Glaubitz wrote:
>> On Sun, May 14, 2017 at 09:46:07PM -0500, Rob Landley wrote:
>>> I refer to the previous thread, which is still the case:
>>>
>>> http://www.spinics.net/lists/linux-sh/msg51190.html
>>>
>>> I poked at QEMU's internals to see if there was an easy way to fiddle
>>> with stuff, but A) ttySC1 appears to be the only serial type the board
>>> emulates, B) the ttySC0 instance is broken, dunno why.
>>
>> I gave it a try myself now and I can't get the emulated machine to
>> boot or show any output over the serial console.
>>
>> It hangs here:
>>
>> root@nofan:~/sh4-system> qemu-system-sh4 -M r2d -m 1000M -drive file=sh4-system.img,format=qcow2 -nographic -append "root=/dev/sda1 rw console=ttySC0 earlyprintk=sh-sci.1" -kernel vmlinux-3.18.0-trunk-sh7751r
>> long read to SH7750_WCR1_A7 (0x000000001f800008) ignored
>> long read to SH7750_WCR2_A7 (0x000000001f80000c) ignored
>> long read to SH7750_WCR3_A7 (0x000000001f800010) ignored
>> long read to SH7750_MCR_A7 (0x000000001f800014) ignored
>> long read to SH7750_MCR_A7 (0x000000001f800014) ignored
>>
>> Any ideas?
>
> By default qemu-system-sh4 outputs to the broken first serial port
> (which Linux apparently has no driver for) instead of the second serial
> port that Linux does have a driver for. I have no idea why it does that,
> but you have to add extra command line options to work around it:

The first serial port is a SCI, which should be supported by the sh-sci
driver, too.

Perhaps the issue is that using the first port as a serial console depends
on the bootloader initializing it?
Does it work as a normal serial port from userspace?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
