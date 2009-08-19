From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 14:45:47 +0000
Subject: Re: [PATCH 3/3] Add FSI-AK464x sound support for ms7724se
Message-Id: <20090819144547.GB3323@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	<20090819120058.GB20227@rakim.wolfsonmicro.main>
	<aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
	<20090819140256.GA31305@rakim.wolfsonmicro.main>
	<aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
In-Reply-To: <aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 11:18:13PM +0900, Magnus Damm wrote:

> At this point on SuperH we first select processor and then board(s)
> after that. So the kernel is configured to run on one specific
> processor model. But the FSI block may show up in other processors and
> the pinmux configuration will most likely be different at that point.
> We usually keep the pinmux configuration in the board setup code and
> the let the driver "just work" and never touch any GPIOs unless the
> driver comes with GPIO support.

Hrm, OK.  In that case it's a bit of an odd way of doing pinmux
configuration but that's fine.
