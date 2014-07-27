From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 27 Jul 2014 10:36:47 +0000
Subject: Re: [PATCH] ASoC: rsnd: Protect register accesses with a spinlock instead of a mutex
Message-Id: <53D4D63F.6010701@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On 23/07/14 22:19, Laurent Pinchart wrote:
> The hardware registers are accessed from atomic contexts (the
> rsnd_soc_dai_trigger function, for instance, is called with the PCM
> substream spinlock held). They thus can't be protected by a mutex.
> 
> Protect regmap register accesses with a spinlock instead of a mutex by
> setting the fast_io flag.

I reported this ages ago.

I ended up removing regmap entirely, it just locks the machine
solid and provides no useful functionality for the driver.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
