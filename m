From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2014 13:24:24 +0000
Subject: Re: [PATCH][resend] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
	<539815E6.2050304@codethink.co.uk>
	<20140611165410.GK5099@sirena.org.uk>
	<CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
	<20140611170233.GL5099@sirena.org.uk>
	<5398A53D.3020706@wwwdotorg.org>
	<20140611190444.GN5099@sirena.org.uk>
	<5398AB07.4040304@wwwdotorg.org>
	<87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
	<878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
	<20140922130026.GK3290@leverpostej>
In-Reply-To: <20140922130026.GK3290@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Hi Mark,

On Mon, Sep 22, 2014 at 3:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Given all that, I think we should get rid of the "ak" prefix entirely,
> fix up the seaboard dts, and leave the legacy matching for "ak,ak8975"
> up to the i2c framework. However, that would imply deleting from
> vendor-prefixes.txt (if we want people to be warned on use of "ak"), and
> that's not a good precedent to set.

Instead of deleting, we can deprecate, like was done for powervr:

powervr PowerVR (deprecated, use img)

Still missing is an update for checkpatch to warn when a deprecated
vendor prefix is used.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
