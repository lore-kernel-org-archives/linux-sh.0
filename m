From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Jun 2020 09:28:36 +0000
Subject: Re: Kernel doesn't boot on qemu-sh4
Message-Id: <CAMuHMdXeEUoZVDDK5QWuLDw6Spav3w0mzC2Ev6tN_8W3guptoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <364fae0d-6030-6741-d38a-3e6fd15fc4ca@physik.fu-berlin.de>
In-Reply-To: <364fae0d-6030-6741-d38a-3e6fd15fc4ca@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Adrian,

On Thu, Jun 4, 2020 at 10:54 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Has anyone had any success booting a current kernel on qemu-sh4?

Yes, I booted my local tree, based on renesas-drivers[*], on emulated
rts7751r2d 2 days ago.

> I have built a Debian kernel with both my patch to add __get_user_u64() as
> well as the two patches by Romain Naour [1,2] but the kernel still doesn't
> boot for me.
>
> Am I missing anything?

My local tree also has:
  1. https://marc.info/?l=linux-arch&m3337991312146&w=2
  2. https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/

If it still fails after that, I'll have a deeper look.

[*] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tag/?h=renesas-drivers-2020-06-02-v5.7

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
