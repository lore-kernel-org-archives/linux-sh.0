From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 14:04:20 +0000
Subject: Re: [alsa-devel] [PATCH 2/3] Add ak464x codec support
Message-Id: <20090819140419.GB19168@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <uk51059ln.wl%morimoto.kuninori@renesas.com> <74d0deb30908190652h78df814dlc6eda9c81be9b424@mail.gmail.com>
In-Reply-To: <74d0deb30908190652h78df814dlc6eda9c81be9b424@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org

On Wed, Aug 19, 2009 at 03:52:08PM +0200, pHilipp Zabel wrote:

> AK4641 only seems to have registers 0x00 to 0x13, so if it is
> sufficiently different to warrant a separate driver, maybe this driver
> should be renamed to AK4643 or whatever is the lowest numbered AK464x
> that has the register layout in your patch.

Or more generally what other CODECs are covered by the driver?
