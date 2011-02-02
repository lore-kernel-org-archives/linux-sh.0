From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 02 Feb 2011 02:31:53 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <AANLkTik_QFqas7yTWDpWhMfxfdOvKNh--DDFxY8x8v51@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
	<20110201140024.GZ1147@pengutronix.de>
	<20110201151418.GN31216@n2100.arm.linux.org.uk>
	<20110201152203.GE1147@pengutronix.de>
	<20110201152820.GQ31216@n2100.arm.linux.org.uk>
In-Reply-To: <20110201152820.GQ31216@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

2011/2/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Feb 01, 2011 at 04:22:03PM +0100, Uwe Kleine-König wrote:
>> Full ack.  (I wonder if you misunderstood me or wanted to put my
>> statement into more words.  Jassi didn't like that a clk_enable without
>> a previous clk_prepare worked on some platforms and on others it
>> doesn't.  With BUG_ON(clk->ops->prepare && !clk->prepare_count) in
>> clk_enable we have exactly this situation.)
>
> Even with a NULL clk->ops->prepare function, we still want drivers to
> have called clk_prepare().  So we can do something like:
>
>        if (WARN_ON(clk->prepare_count = 0))
>                return -EINVAL;
>
> in clk_enable() should be sufficient and noisy enough not to be missed.
>
> I'd avoid BUG_ON() here as that will take the system down, which may
> increase the chances of getting useful bug reports.

Having thought about it, I think it's not necessary to immediately catch
drivers that work on some platforms and not on others -- a mere comment
'please add clk_prepare' during code review or a patch adding 'clk_prepare'
later upon stumbling across a platform on which the driver doesn't work,
should be OK. Let us not fret about it.

That leaves us with only having to ensure that :-
a) No two calls to clk_prepare/unprepare _hooks_ are consecutive.
b) clk_prepare is done on the clock (not necessarily by the driver
    under consideration) before calls to clk_enable.

I think (a) is already easily managed by having the prepare_count,
and (b) can be reasonably managed by what Russell suggests above.

So, FWIW, I am for the idea.

Njoi!
