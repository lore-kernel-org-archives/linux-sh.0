From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 20 Sep 2010 09:29:08 +0000
Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: lowercase wm8978 codec name to
Message-Id: <20100920092908.GA3414@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171214281.4988@axis700.grange>
 <20100917125319.GF4322@rakim.wolfsonmicro.main>
 <1284970372.3403.15.camel@odin>
In-Reply-To: <1284970372.3403.15.camel@odin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

On Mon, Sep 20, 2010 at 09:12:52AM +0100, Liam Girdwood wrote:

> Fwiw, the reason for the "-codec" suffix was to distinguish codec
> devices from their other multi-function IC siblings. It also makes sense

Yes, MFDs do need something to distinguish them.

> here to use convention with the device naming too (even if the device is
> single purpose).

I don't find it adds much more than making the name longer to type - we
always use the name in a context where it's fairly obvious that the
device is a CODEC.
