From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 11 Jan 2011 14:34:06 +0000
Subject: Re: Locking in the clk API
Message-Id: <20110111143406.GC22390@atrey.karlin.mff.cuni.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
	<201101111211.30172.jeremy.kerr@canonical.com>
	<20110111090311.GM12078@pengutronix.de>
	<20110111092842.GJ12552@n2100.arm.linux.org.uk>
In-Reply-To: <20110111092842.GJ12552@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi!

> Another solution occurs to me: clk_enable() which returns -EAGAIN if
> it's called in an atomic context but needs to sleep, and let the driver
> deal with the clock not being enabled when it wants it.  The down side
> is it requires the driver to have additional code to sort out such a
> problem.

I do not think that "atomic context" is possible to reliably detect
inside a function like that.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
