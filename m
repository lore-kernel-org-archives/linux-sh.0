From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Aug 2009 19:06:26 +0000
Subject: Re: [alsa-devel] [PATCH v2 4/4] sh: add FSI driver support for
Message-Id: <20090820190626.GH5032@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <utz02d78o.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <utz02d78o.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Thu, Aug 20, 2009 at 09:01:27PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

> o become independent patch

It looks like this should have another change to register the CODEC as
an I2C device?  Other than that it's fine from an ASoC point of view -
is it OK to merge via ASoC due to the dependency on the platform data
for the FSI?
