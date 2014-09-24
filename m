From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2014 13:46:50 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: Initial Alt board device tree
Message-Id: <CAMuHMdWDQXeHnpXu2=GxryEiAvVSBz-jCqLb+Z4htV7A-yyd9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
 <a742795be9ceae2853ca71f216193f29da151da8.1410396013.git.horms+renesas@verge.net.au>
 <CAMuHMdXx7OmH0WC_MxsYB0X4=yomLtf+HoE8YUBo0aTPHT2zNQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXx7OmH0WC_MxsYB0X4=yomLtf+HoE8YUBo0aTPHT2zNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 24, 2014 at 2:24 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Sep 11, 2014 at 2:57 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
>
>> +/ {
>> +       model = "Alt";
>> +       compatible = "renesas,alt", "renesas,r8a7794";
>> +
>> +       aliases {
>> +               serial0 = &scif2;
>
> Is this correct, i.e. does "scif2" match "ttySC0" below?
>
>> +       };
>> +
>> +       chosen {
>> +               bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
>> +       };

To answer my own question: the alias means that "ttySC0" will be mapped to
the scif2 hardware block, using of_alias_get_id().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
