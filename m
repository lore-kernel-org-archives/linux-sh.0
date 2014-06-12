From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 12 Jun 2014 15:33:04 +0000
Subject: Re: [PATCH] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <5399C830.8070607@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>	<87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>	<539815E6.2050304@codethink.co.uk>	<20140611165410.GK5099@sirena.org.uk>	<CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>	<20140611170233.GL5099@sirena.org.uk>	<5398A53D.3020706@wwwdotorg.org>	<20140611190444.GN5099@sirena.org.uk>	<5398AB07.4040304@wwwdotorg.org> <87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sinbdk44.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

On 06/11/2014 06:53 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current vendor-prefixes.txt already has
> "ak" prefix for Asahi Kasei Corp by
> ae8c4209af2cec065fef15d200a42a04130799f7
> (of: Add vendor prefix for Asahi Kasei Corp.)
> 
> It went through the appropriate review process,
> and is already in use.
> But, almost all Asahi Kasei chip driver is
> using "asahi-kasei" prefix today.

I'm fine with this patch, but just wanted to comment on this part of the
commit description:

What is in the drivers isn't relevant; that's not what drives the ABI.
The issue is that some *DTs* use ak and some use asahi-kasei, so both
those need to be supported.

That said, we should document which one of the two prefixes is
preferred, and use this for any new AK binding.

It would also be nice to ensure the preferred prefix is in all drivers'
of_match_tables, and remove the deprecated prefix from all drivers'
of_match_tables *except* where there's already a DT file that references
the deprecated vendor prefix.

