From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Jan 2011 23:21:42 +0000
Subject: Re: Locking in the clk API
Message-Id: <1295652102.2148.314.camel@pasglop>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
	<4D3907BD.4040900@codeaurora.org>
	<AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>
	<alpine.LFD.2.00.1101211618170.8580@xanadu.home>
	<20110121220238.GE23151@n2100.arm.linux.org.uk>
	<AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
In-Reply-To: <AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 2011-01-21 at 14:28 -0800, Colin Cross wrote:
> Clocks that have a voltage dependency, or depend on a clock that has a
> voltage dependency, are non-atomic, everything else is atomic.  PLLs
> are atomic because they lock very fast (300 uS or 1ms) 

Some could argue that this is still way too slow for atomic context :-)

Cheers,
Ben.

