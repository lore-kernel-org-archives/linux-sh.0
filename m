From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Mon, 12 May 2014 13:47:39 +0000
Subject: Re: [PATCH 1/6] ARM: shmobile: sh73a0: Common clock framework DT description
Message-Id: <CAO3366zZJX38KqPJo8EvGedMTa0zt7wC6cfw+Kc3oXLLs8V9gQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399386233-11928-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1399386233-11928-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 6, 2014 at 9:30 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, May 6, 2014 at 4:23 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
>> +               extal2_clk: extal2_clk {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0>;
>> +                       /* This value must be overriden in the board dts. */
>> +                       clock-frequency = <0>;
>
> I know we have this dummy value for R-Car Gen2 too, but shouldn't it just
> be left out of the .dtsi?

Fine with me, if that works.

>> +                       renesas,clock_enable_on_init;   /* ? */
>
> "/* ? */"?

"?"! :) (Actually, I don't remember why I put that there. It may be
related to the fact that this attribute is currently unimplemented,
yet stuff still works just fine, leaving me to wonder whether it is
necessary at all.)

>> +                       clock-output-names >> +                               "scifa6", "cmt1", "fsi", "irda", "iic1",
>> +                               "usb", "flctl", "sdhi0", "sdhi1", "mmcif0", "sdhi2",
>> +                               "tpu0", "tpu1", "tpu2", "tpu3";
>> +               };
>
> "tpu4" is missing at the end.

Indeed.

CU
Uli
