From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Aug 2009 12:39:11 +0000
Subject: Re: [alsa-devel] [PATCH v2 1/4] Add SuperH FSI driver support for
Message-Id: <20090820123911.GA10046@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
 <20090820152212.b8be38b9.jhnikula@gmail.com>
In-Reply-To: <20090820152212.b8be38b9.jhnikula@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Aug 20, 2009 at 03:22:12PM +0300, Jarkko Nikula wrote:

> I'm not familiar with the SH but this arch specific header file
> sh_fsi.h should go either into sound/soc/sh or if generic enough, then
> somewhere under arch/sh/include/.

It needs to go under include, either with the sound stuff or with the
arch stuff since it contains platform data that boards are going to need
to set.  I don't really mind which myself, both schemes are in use.
