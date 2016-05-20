From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 22:34:57 +0000
Subject: Re: [PATCH v2 03/12] of: add J-Core interrupt controller bindings
Message-Id: <20160520223456.GV21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
 <CAMuHMdVs9=8BGwmCBuYch2abJBnCLKoEx7i3EMghW3UUjXc7dA@mail.gmail.com>
In-Reply-To: <CAMuHMdVs9=8BGwmCBuYch2abJBnCLKoEx7i3EMghW3UUjXc7dA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Fri, May 20, 2016 at 10:04:26AM +0200, Geert Uytterhoeven wrote:
> On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> > +Additional properties required for aic1:
> > +
> > +- reg : Memory region for configuration.
> > +
> > +- cpu-offset : For SMP, the offset to the per-cpu memory region for
> > +  configuration, to be scaled by the cpu number.
> 
> Does cpu-offset apply to aic1 only?

The current kernel driver doesn't have any reason to _need_ cpu-offset
for aic2, but since there are registers there that a driver (even a
non-Linux one) may want to use, I think it makes sense that it should
be present in the bindings.

Rich
