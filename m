From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Aug 2011 01:46:26 +0000
Subject: Re: LCDC problem after commit 794d78fea51504bad3880d14f354a9847f318f25
Message-Id: <CANqRtoTF+CmjgRyqusAw5G4JZg99RwfaD8s8RA8CB63o_otSyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080125.34329.rjw@sisk.pl>
In-Reply-To: <201108080125.34329.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael,

On Mon, Aug 8, 2011 at 8:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Unfortunately, after commit 794d78fea51504bad3880d14f354a9847f318f25
> (drivers: sh: late disabling of clocks V2) the LCDC screen on my
> Mackerel board goes off (late) during boot and cannot be turned on
> by any way AFAICS (the backlight remains on, though).
>
> It looks like the late disabling of clocks interacts badly with the
> clock management done by PM domains.

This is most likely showing a so-far-not-handled clock dependency for
the LCDC hardware. I'll have a look.

Thanks,

/ magnus
