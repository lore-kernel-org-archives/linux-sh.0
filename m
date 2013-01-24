From: Chris Ball <cjb@laptop.org>
Date: Thu, 24 Jan 2013 16:03:07 +0000
Subject: Re: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Message-Id: <87k3r2h8lg.fsf@laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
	<Pine.LNX.4.64.1301241630160.7826@axis700.grange>
	<87pq0uh9ob.fsf@laptop.org>
	<Pine.LNX.4.64.1301241649560.7826@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1301241649560.7826@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 24 Jan 2013 16:58:34 +0100 (CET)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Thu, Jan 24 2013, Guennadi Liakhovetski wrote:
> I tried to keep this binding similar to others, that I proposed in "mmc: 
> add DT bindings for more MMC capability flags." Actually, the above is 
> indeed wrong, I would call it "cap-sdio-irq." And in that patch I tried to 
> keep binding names resembling as closely as possible respective MMC_CAP_* 
> flags. I think, it would have been better if "enable-sdio-wakeup" and 
> "keep-power-in-suspend" were also named, following the same rule, but it's 
> too late now. Anyway, I'm not too concerned about the names. We can use 
> "enable-sdio-irq" too if you like.

I see.  Okay, let's go with your proposed cap-* for each MMC_CAP_*, and
the pm_caps can stay as they are.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
