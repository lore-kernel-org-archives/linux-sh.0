From: Chris Ball <cjb@laptop.org>
Date: Thu, 14 Jul 2011 19:27:03 +0000
Subject: Re: [PATCH 0/2] mmc: tmio: two bug-fixes
Message-Id: <m2pqlcslx4.fsf@bob.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1107141828470.10688@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1107141828470.10688@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 14 Jul 2011 18:39:02 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ian Molton <ian@mnementh.co.uk>, Simon Horman <horms@verge.net.au>

Hi Guennadi,

On Thu, Jul 14 2011, Guennadi Liakhovetski wrote:
> There go two more bug-fixes for tmio on top of my earlier patches from 
> today, so, should still be easy enough to trace. So, to pull them 
> together, the previous ones were
>
> [PATCH v3] mmc: tmio: fix recursive spinlock, don't schedule with
> interrupts disabled
> [PATCH v3] mmc: tmio: maximize power saving
>
> And now follow
>
> [PATCH 1/2] mmc: tmio: fix a recently introduced bug in DMA code
> [PATCH 2/2] mmc: tmio: fix a deadlock

Pushed these four plus "mmc: sh_mmcif: maximize power saving" to
mmc-next for 3.1.  Thanks!

By the way, feel free to send me a MAINTAINERS update taking over
TMIO if you'd like to; you've been doing the work.  :-)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
