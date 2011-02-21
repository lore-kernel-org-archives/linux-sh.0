From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Mon, 21 Feb 2011 23:29:11 +0000
Subject: Re: [PATCH 2/2] clk: Generic support for fixed-rate clocks
Message-Id: <201102220729.13708.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1298256658.862488.956979497586.2.gpush@pororo>
	<4D62C237.1020803@bluewatersys.com>
In-Reply-To: <4D62C237.1020803@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ryan,

> If we never need to dynamically create fixed clocks (which seems
> unlikely) then rate can be const.

There's been a few cases where I've needed to set the rate of a fixed clock 
during boot - for example when a clock rate varies between boards, it may be 
defined in a platform-wide file, but have the rate modified early (ie, 
clk_foo.rate = 32678) in a board file.

Also, if we're parsing clocks from the device tree (or any other discovery 
mechanism), we'll need to modify rate.

Cheers,


Jeremy
