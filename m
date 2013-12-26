From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Dec 2013 21:20:23 +0000
Subject: Re: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
Message-Id: <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-3-git-send-email-wsa@the-dreams.de>
 <20131224024855.GC22401@verge.net.au>
In-Reply-To: <20131224024855.GC22401@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 24, 2013 at 3:48 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Dec 18, 2013 at 10:31:58PM +0100, Wolfram Sang wrote:
>> From: Wolfram Sang <wsa@sang-engineering.com>
>>
>> Tested with RIIC2 on a genmai board. Others untested but hopefully
>> trivial enough to be added.
>>
>> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>> Acked-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> V2: adapt to established sorting
>
> Thanks. This seems safe enough and I will queue it up.

Note that after dropping these lines:

       CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
       CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
       CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
       CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),

i2c stopped working.

Before:

of_irq_parse_one: dev=/i2c@fcfee800/eeprom@50, index=0
at24 2-0050: 16384 byte 24c128 EEPROM, writable, 64 bytes/write
i2c-riic fcfee800.i2c: registered with 400000Hz bus speed

After:

i2c-riic fcfee800.i2c: missing controller clock
i2c-riic: probe of fcfee800.i2c failed with error -2

Am I missing some other patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
