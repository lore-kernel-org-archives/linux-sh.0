From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 01 Feb 2011 13:05:56 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
In-Reply-To: <20110201105449.GY1147@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

2011/2/1 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:

.....

> Do you plan to handle the case that clk_enable is called while prepare
> isn't completed (considering the special case "not called at all")?
> Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?
Sounds better than the second option.

> Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> before calling clk->ops->enable?
That might result in a driver working on some platforms(those have
atomic clk_prepare)
and not on others(those have sleeping).


Njoi!
