From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Mar 2015 00:55:43 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: armadillo: fixup CPU settings
Message-Id: <20150327005542.GA27069@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
 <20150326173628.GX3572@sirena.org.uk>
In-Reply-To: <20150326173628.GX3572@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Lars-Peter Clausen <lars@metafoo.de>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

Hi Mark,

On Thu, Mar 26, 2015 at 10:36:28AM -0700, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 01:05:02AM +0000, Kuninori Morimoto wrote:
> 
> > So, I think keeping current FSI driver as-is is more safety for old boards.
> > I tested these patches on latest Mark's branch 
> 
> Simon, are these OK for me to apply or do you want to apply them?

These changes do not appear to conflict with anything I have queued up for
v4.1 so assuming that you are targeting that release please feel free to
take them. (My only worry here is about conflicts.)

Acked-by: Simon Horman <horms+renesas@verge.net.au>


