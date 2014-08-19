From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Aug 2014 07:07:49 +0000
Subject: Re: [PATCH 4/8] ARM: shmobile: Initial r8a7794 and Alt device tree
Message-Id: <CAMuHMdXXB7ADbodpST7RyOsV0+r0XodnwSx2JXoDhhXFoW0GTA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <0d0771ab2bd5f57a62db91f26bba1e9f522d16cb.1380530437.git.horms+renesas@verge.net.au>
In-Reply-To: <0d0771ab2bd5f57a62db91f26bba1e9f522d16cb.1380530437.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 19, 2014 at 2:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> +     aliases {
>>> +             serial10 = &scif2;
>>> +     };
>>
>> Ulrich, Magnus, Larurent,
>>
>> I'm wondering if this alias is necessary as there is no precedence
>> in mainline for the console being on serial port 10.
>
> My take on this is that we should follow latest common upstream
> convention, which I believe is using serial0 for the debug port.

iff "serial0" is the label of the debug port on the board...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
