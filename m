From: Chris Ball <cjb@laptop.org>
Date: Tue, 19 Apr 2011 01:57:41 +0000
Subject: Re: [PATCH] MMC: fix a race between card-detect rescan and clock-gate work instances
Message-Id: <m3fwpfq9s3.fsf@pullcord.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152006110.18593@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 15 Apr 2011 20:08:19 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>

Hi Guennadi,

On Fri, Apr 15 2011, Guennadi Liakhovetski wrote:
> Currently there is a race in the MMC core between a card-detect
> rescan work and the clock-gating work, scheduled from a command
> completion. Fix it by removing the dedicated clock-gating mutex and
> using the MMC standard locking mechanism instead.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Thanks, pushed to mmc-next with Linus' ACK and a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
