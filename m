From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Nov 2015 09:27:06 +0000
Subject: Re: [PATCH 1/3] clk: shmobile: r8a7795: Add PCIe clocks
Message-Id: <CAMuHMdXA9ctySc1bisnqY7vE--yk9xqkRZWM5FXvDETJ6B-Dkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446485499-26733-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446485499-26733-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

On Tue, Nov 3, 2015 at 10:05 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 03 November 2015 07:49, Geert wrote:
>> On Mon, Nov 2, 2015 at 6:31 PM, Phil Edworthy <phil.edworthy@renesas.com>
>> wrote:
>> > --- a/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
>> > +++ b/drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
>> > @@ -120,6 +120,8 @@ static const struct mssr_mod_clk r8a7795_mod_clks[]
>> __initconst = {
>> >         { "sys-dmac1",          218,    R8A7795_CLK_S3D1        },
>> >         { "sys-dmac0",          219,    R8A7795_CLK_S3D1        },
>> >         { "scif2",              310,    R8A7795_CLK_S3D4        },
>> > +       { "pcie0",              318,    R8A7795_CLK_S3D1        },
>>
>> "pcie1"
>>
>> > +       { "pcie1",              319,    R8A7795_CLK_S3D1        },
>>
>> "pcie0"
>
> Thanks for finding this, though I am not sure who this patch should be sent to
> as the r8a7795 cpg mssr driver has not been accepted yet afaik. For the
> moment I've sent it to the sh-ml so that people can test PCIe.

If you don't mind, I could integrate it in v6 of the r8a7795 cpg mssr driver.

Note that there are more additions to r8a7795_mod_clks[] in the pipeline.
Once the driver has been accepted, these should go in through the clock
maintainers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
