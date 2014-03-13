From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2014 11:37:24 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <CAMuHMdXOoTeEb=WhbYULCjbFFuj-TaCt+ycGHjzH=3jqwKEjaQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Thu, Mar 13, 2014 at 12:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> Yes, now it disables the hardware clock bits for all clocks that are not
>> in
>> use according to CCF:
>
> Do you have the drivers/sh fix in?

No, I removed that due to bad interaction with userspace:

Unhandled fault: imprecise external abort (0x1406) at 0x00000000

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
