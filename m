From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Aug 2011 10:48:44 +0000
Subject: Re: LCDC problem after commit 794d78fea51504bad3880d14f354a9847f318f25
Message-Id: <CANqRtoTwMHfCu8u5A4djQKeonOtMVKZob7a+Ww7U6qHsmGBB_g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080125.34329.rjw@sisk.pl>
In-Reply-To: <201108080125.34329.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael,

[Dropped Linux-PM list, added Laurent and Damian]

On Mon, Aug 8, 2011 at 10:46 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Aug 8, 2011 at 8:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Unfortunately, after commit 794d78fea51504bad3880d14f354a9847f318f25
>> (drivers: sh: late disabling of clocks V2) the LCDC screen on my
>> Mackerel board goes off (late) during boot and cannot be turned on
>> by any way AFAICS (the backlight remains on, though).
>>
>> It looks like the late disabling of clocks interacts badly with the
>> clock management done by PM domains.
>
> This is most likely showing a so-far-not-handled clock dependency for
> the LCDC hardware. I'll have a look.

Further investigation shows that this only triggers when the MERAM is
enabled in the kernel configuration using CONFIG_FB_SH_MOBILE_MERAM=y.
So this seems more related to MERAM power management than LCDC.

Digging a bit deeper makes it clear that the sh_mobile_meram.c driver
in upstream doesn't seem to include any Runtime PM code. I recall
seeing various versions posted to the mailing list.

Laurent [CC], can you please provide us with a list of outstanding
LCDC/MERAM patches to make this work as expected? I realize there are
quite a few outstanding LCDC patches, but if possible please provide a
list of the bare minimum to make this work with 3.1-rc.

I suspect that Damian [CC] is busy, but if time allows perhaps he can
share his ideas as well.

When looking into this I noticed that the MERAM parent clock
assignment seems broken:

static struct clk mstp_clks[MSTP_NR] = {
	...
	[MSTP113] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 13, 0), /* MERAM */

Judging by the "Clock Assignment to Modules" table in the CPGA chapter
of the sh7372 data sheet, this should probably be &div4_clks[DIV4_S]
or &div4_clks[DIV4_B]. But before dealing with the parent accounting
we need to have Runtime PM support included in the MERAM driver.

Cheers,

/ magnus
