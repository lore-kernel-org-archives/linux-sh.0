From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Mar 2012 09:03:41 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Message-Id: <20120330090341.GG26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120330084402.19597.63655.sendpatchset@w520> <20120330084744.GF26543@linux-sh.org> <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
In-Reply-To: <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-i2c@vger.kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, w.sang@pengutronix.de, rjw@sisk.pl, ben-linux@fluff.org, khali@linux-fr.org

On Fri, Mar 30, 2012 at 05:53:35PM +0900, Magnus Damm wrote:
> On Fri, Mar 30, 2012 at 5:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Fri, Mar 30, 2012 at 05:44:02PM +0900, Magnus Damm wrote:
> >> +static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
> >> + ? ? { .compatible = "renesas,rmobile-iic", },
> >> + ? ? {},
> >> +};
> >> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
> >> +
> > Given that this block predates R-Mobile, using the rmobile naming here is
> > pretty dubious. I suppose you can have it as an alias, though.
> 
> Sure, but creating new code based an old naming conventions seem rather
> odd too.
> 
Devices should be named what they are, not what the marketing people tell
you they should be. Retroactively attempting to label parts that pre-date
rmobile as being rmobile-related is non-sensical. The driver itself
you'll note is not called i2c-rmobile for precisely this reason.

Furthermore, there are also ARM-based SH-Mobile parts that pre-date the
R-Mobile line that also use this driver, so it's hardly an architecture
issue.

> Of course, if you think it is cramping your SH device tree style then
> we can easily add a "renesas-shmobile-iic" entry as well.
> 
I obviously don't mind if you wish to use the rmobile naming convention
going forward, as the new parts have obviously dropped with the shmobile
naming convention, and it's likely you'll even be able to infer different
capabilities between rmobile vs shmobile. That's not sufficient cause to
prefer one over the other though, so you're still going to have to keep
things balanced. Simply having two aliases seems to me to be the easiest
solution.
