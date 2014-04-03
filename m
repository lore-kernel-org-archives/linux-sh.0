From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Apr 2014 09:40:46 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo-reference dts: enable RTC
Message-Id: <CAMuHMdUqPHQK_Cn0Mx8OvyAP-ROPf-Cq2M9STAf5vBCXx=T=UA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1378900273-10188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 3, 2014 at 10:30 AM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> On Thu, Apr 3, 2014 at 2:11 AM, Simon Horman <horms@verge.net.au> wrote:
>> I am a little confused about i2c2 appearing below as
>> the documentation that I have only seems to refer to
>> the presence of i2c0 and i2c1.
>
> This thing doesn't use any of the SoC I2C controllers, it's just
> hooked up to two GPIO pins. The board docs don't give much detail, but
> I found the relevant info in the Android vendor kernel, which is where
> this "bus" is called i2c2. The name is arbitrary, though.

Table 3.1 does mention "I2C2 (GPIO) For RTC only", and the docs also
mention it's a s35390a.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
