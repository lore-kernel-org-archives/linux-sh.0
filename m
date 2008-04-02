From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 02 Apr 2008 01:20:56 +0000
Subject: Re: [i2c] [PATCH] i2c: SuperH Mobile I2C Bus Controller V4
Message-Id: <aec7e5c30804011820v3a0d49fetb6d74ea74d78c0ae@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080328093530.32474.78684.sendpatchset@rx1.opensource.se>
	 <20080329175732.GA9638@fluff.org.uk>
In-Reply-To: <20080329175732.GA9638@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: i2c@lm-sensors.org, akpm@linux-foundation.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hi Ben,

On Sun, Mar 30, 2008 at 2:57 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Fri, Mar 28, 2008 at 06:35:30PM +0900, Magnus Damm wrote:
>  > This is V4 of the SuperH Mobile I2C Controller Driver. A simple Master
>  > only driver for the I2C block included in processors such as sh7343,
>  > sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c732b rtc.

>  How many IRQs can one controller have?

Four IRQs per channel for this particular version of I2C controller.

>  I note that you do not call clk_enable() or clk_disable() for this
>  clock, is this some form of global always-on clock, or is an
>  assumption that some other driver is holding the clock open for you?

Nice catch. I'll add code that does clk_enable() and clk_disable().

>  > +     size = (res->end - res->start) + 1;
>
>  hmm, has no-one done as res_size() macro yet?

It's been on my TODO list forever. =)

>  > +MODULE_LICENSE("GPL");
>
>  IIRC, your header license says GPL v2, so this should be changed to
>  agree with that statement.

Uhm, right. Thanks for pointing that out.

>  Overall, the code looks fine other than a few comments could be added
>  and possibly some function descriptions before their declerations so
>  that you can get an idea of what is going on in them.

I'll fix up things and repost. Thanks for your review!

/ magnus
