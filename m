From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 11 Mar 2014 17:57:41 +0000
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Message-Id: <25839523.lJE8x4ql34@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org> <2274545.CyQ67zvVqo@avalon> <CAMuHMdXEOygh0--niiLcXFgnRNPi_b0EGPKVBg2Q6Ws01YmNjw@mail.gmail.com>
In-Reply-To: <CAMuHMdXEOygh0--niiLcXFgnRNPi_b0EGPKVBg2Q6Ws01YmNjw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Geert,

On Tuesday 11 March 2014 18:44:21 Geert Uytterhoeven wrote:
> On Tue, Mar 11, 2014 at 5:32 PM, Laurent Pinchart wrote:
> > On Tuesday 11 March 2014 17:23:37 Geert Uytterhoeven wrote:
> >> On Tue, Mar 11, 2014 at 4:55 PM, Laurent Pinchart wrote:
> >> > Does this require drivers/sh/pm_runtime.c to be compiled in ?
> >> 
> >> Let's check...
> >> 
> >> My koelsch-legacy kernel has drivers/sh/pm_runtime.c compiled in.
> >> My koelsch-reference kernel hasn't.
> >> 
> >> However, under the -reference kernel many MSTP clocks (incl. MSIOF)
> >> seem to be enabled all the time, while under -legacy they are enabled and
> >> disabled on demand.
> > 
> > Is PM_RUNTIME enabled in both cases ?
> 
> Yes it is.
> 
> > There's something fishy in there that we should try to fix without too
> > further much delay. Ben Dooks has pointed out the problem a couple of
> > months ago, but the discussion on the mailing list just died.
> 
> Indeed. I'll look into it next week, unless someone beats me to it.
> 
> Note that I dropped Ben's patch to include drivers/sh, as I can't boot into
> userspace with it.

The patch also had the issue of not being compatible with multiplatform 
kernels, as it resulted in Renesas-specific code being executed for all 
platforms.

If you can find the old mail thread you can just reply to it (CC'ing me) and 
I'll make sure to refresh my memory and explain my concerns again.

-- 
Regards,

Laurent Pinchart

