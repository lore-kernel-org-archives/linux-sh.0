From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Aug 2009 23:43:27 +0000
Subject: Re: [alsa-devel] [PATCH v2 4/4] sh: add FSI driver support for ms7724se
Message-Id: <20090820234327.GA31542@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <utz02d78o.wl%morimoto.kuninori@renesas.com>
	<20090820190626.GH5032@sirena.org.uk>
In-Reply-To: <20090820190626.GH5032@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Thu, Aug 20, 2009 at 08:06:26PM +0100, Mark Brown wrote:
> On Thu, Aug 20, 2009 at 09:01:27PM +0900, Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> 
> > o become independent patch
> 
> It looks like this should have another change to register the CODEC as
> an I2C device?  Other than that it's fine from an ASoC point of view -
> is it OK to merge via ASoC due to the dependency on the platform data
> for the FSI?

I have other ms7724se patches queued up for 2.6.32, so the easiest thing
to do is just to leave this patch until the dependencies are upstream,
then I'll fold it in. This is how we usually handle these sorts of merge
dependencies anyways.
