From: Saravana Kannan <skannan@codeaurora.org>
Date: Tue, 01 Feb 2011 20:57:57 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <4D4873D5.70203@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>	<20110201105449.GY1147@pengutronix.de>	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>	<20110201140024.GZ1147@pengutronix.de>	<20110201151418.GN31216@n2100.arm.linux.org.uk>	<20110201152203.GE1147@pengutronix.de>
	<20110201152820.GQ31216@n2100.arm.linux.org.uk>
In-Reply-To: <20110201152820.GQ31216@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 02/01/2011 07:28 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 04:22:03PM +0100, Uwe Kleine-K=F6nig wrote:
>> Full ack.  (I wonder if you misunderstood me or wanted to put my
>> statement into more words.  Jassi didn't like that a clk_enable without
>> a previous clk_prepare worked on some platforms and on others it
>> doesn't.  With BUG_ON(clk->ops->prepare&&  !clk->prepare_count) in
>> clk_enable we have exactly this situation.)
>
> Even with a NULL clk->ops->prepare function, we still want drivers to
> have called clk_prepare().  So we can do something like:
>
> 	if (WARN_ON(clk->prepare_count =3D 0))
> 		return -EINVAL;
>
> in clk_enable() should be sufficient and noisy enough not to be missed.

This code will only catch the error when it actually happens and will=20
even miss catching some of them (if timed right -- unprepare happens in=20
the other core after this check is executed).

I really wish there was something better we could do to help driver devs=20
catch errors of calling enable without calling prepare(). Some thing=20
like spin lock debug, or the might_sleeps() inside mutexes, etc.

Hmm... Jeremy, how about doing a similar check in the unprepare code?=20
You could WARN/BUG ON the prepare count going to zero when the enable=20
count is still non-zero?

Thanks,
Saravana

--=20
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
