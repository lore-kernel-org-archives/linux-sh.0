From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2014 15:52:29 +0000
Subject: Re: [ PATCH v2 00/17] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <CAMuHMdW5Yb-KULMjeojXUXgaNjfhseEMd331oxxP00=AnyQ4dg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Apr 15, 2014 at 4:49 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>>   - 13-17 are more or less RFCs: As we always have to call
>>     sh_pm_runtime_init(), I added .init_machine hooks in the generic support
>> code for all SoCs that didn't have it yet. I also included code to set up
>> SoC platform support while at it, as this will be useful later. Booting
>> using a generic "renesas,r*" DT was untested.
>
> I wonder whether we shouldn't wait until we get rid of the *_add_dt_devices()
> functions before applying those.

Sure, that's why they're marked RFC...

> As the goal is to remove the setup-*.c files, have you thought about where the
> sh_pm_runtime_init() calls should move to ?

cpg_mstp_clocks_init() would be nice ;-) Unfortunately it's way too early.

I'm looking for a way to tie this into the connection between devices and
MSTP gate clocks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
