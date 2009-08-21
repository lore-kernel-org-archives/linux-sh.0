From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 21 Aug 2009 01:09:18 +0000
Subject: Re: [alsa-devel] [PATCH v2 4/4] sh: add FSI driver support for ms7724se
Message-Id: <ufxbmnfb5.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <utz02d78o.wl%morimoto.kuninori@renesas.com>
	<20090820190626.GH5032@sirena.org.uk>
In-Reply-To: <20090820190626.GH5032@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lethal@linux-sh.org
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org


Dear Mark

Thank you

> It looks like this should have another change to register the CODEC as
> an I2C device?  Other than that it's fine from an ASoC point of view -
> is it OK to merge via ASoC due to the dependency on the platform data
> for the FSI?

I think you can not apply this patch to
your git branch without merge from Paul's git.
Because there are a lot of patches for
${LINUX}/arch/sh/boards/mach-se/7724/setup.c
in current Paul's git
This patch is based on Paul's git

and I'm sorry I will send v3 patch

Best regards
--
Kuninori Morimoto
 
