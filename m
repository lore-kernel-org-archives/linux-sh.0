From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Jun 2014 07:35:05 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <CAMuHMdUi0DJjXPsScQ1jHGCqAQW9F9yCUdj7cEcZr4enR=3jmg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 10, 2014 at 9:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> +#define R8A7790_CLK_SSI                        5
>
> Should this be called R8A7790_CLK_SSI_ALL?

>> +#define R8A7790_CLK_SCU                        17
>
> Should this be called R8A7790_CLK_SCU_ALL?

>> +#define R8A7790_CLK_SRC9               22
>> +#define R8A7790_CLK_SRC8               23
>> +#define R8A7790_CLK_SRC7               24
>> +#define R8A7790_CLK_SRC6               25
>> +#define R8A7790_CLK_SRC5               26
>> +#define R8A7790_CLK_SRC4               27
>> +#define R8A7790_CLK_SRC3               28
>> +#define R8A7790_CLK_SRC2               29
>> +#define R8A7790_CLK_SRC1               30
>> +#define R8A7790_CLK_SRC0               31
>
> Should these be called R8A7790_CLK_SCU_SRC[0-9]?

If forgot: in case the above are changed, the values in "clock-output-names"
should be renamed, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
