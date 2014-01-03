From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jan 2014 16:07:02 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: Koelsch: Add QSPI support
Message-Id: <CAMuHMdVzawC2ccXCwyLSe7u0Uaa0qpLwaO+3dqQiSrmOcGdTCA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
 <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
 <52C6EAA7.7050200@cogentembedded.com>
In-Reply-To: <52C6EAA7.7050200@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 3, 2014 at 5:51 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       platform_device_register_resndata(&platform_bus, "qspi", 0,
>
>    As I understood, there's single QSPI controller, so why you pass 0, and
> not -1 here?

Indeed, there's only a single QSPI instance.
However, I choose to use "0" for consistency with Lager.
Mach-shmobile seems to use a mix of 0 and -1.

If the maintainer prefers -1, I can change that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
