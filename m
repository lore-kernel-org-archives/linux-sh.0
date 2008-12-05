From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 05 Dec 2008 02:47:15 +0000
Subject: Re: [PATCH] Add icb clk setting for SH7723 on sh_mobile_lcdcfb.c
Message-Id: <aec7e5c30812041847o36dbe8bdp8457ac70bb2ec3eb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch.

On Fri, Dec 5, 2008 at 10:56 AM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> ICB clock is needed when you use LCDC on SH7723
> This patch add support it.
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

The LCDC can be used with or without the ICB on sh7723. Right now
we're using it perfectly fine without the ICB.

What is your goal with using the ICB? I suspect it's to reduce bus
load. Do you have any performance numbers?

In general, improving the LCDC driver is a good idea. For instance I'd
like to use deferred io together with one shot update mode for SYS
panel configurations. I hope that will save quite a bit of power.

I think adding ICB support is a good idea too, but your patch seems to
treat the problem as sh7723-specific. It's really not, look at sh7366
for instance. Also, you probably need more code than that to get the
ICB working, right?

Adding ICB support in general is a quite difficult task since there
are many hardware blocks that are affected. And I really think we
should benchmark these things to see that we implement them correctly.
The problem is much bigger than just adding support for an extra clock
in the LCDC, so let's discuss more how to support the ICB properly.

Thanks,

/ magnus
