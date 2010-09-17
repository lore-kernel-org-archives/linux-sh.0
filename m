From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 17 Sep 2010 12:59:39 +0000
Subject: Re: [PATCH 0/5] fix SIU and Migo-R sound for 2.6.37
Message-Id: <20100917125939.GG4322@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <20100917121931.GC4322@rakim.wolfsonmicro.main>
 <Pine.LNX.4.64.1009171433270.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171433270.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Sep 17, 2010 at 02:35:09PM +0200, Guennadi Liakhovetski wrote:

> Ok, sorry, but in fact this patch and the rest of the series are 
> independent, so, it should be no problem just to pick it up from here, or 
> do I have to re-send anything?

I've not yet tried applying it but I'd anticipate some breakage trying
to do so due to the multi-component changes in the file in for-2.6.37.
I'll do so later today or tomorrow, if it applies fine there's no need
to resubmit.
