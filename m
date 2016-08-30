From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Aug 2016 21:13:07 +0000
Subject: Re: [PATCH v3 01/12] of: add vendor prefix for J-Core
Message-Id: <20160830211307.GB18526@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <b6d33800300bde8f1d9a7b88a715d741548fad4a.1464148904.git.dalias@libc.org>
 <CAL_JsqKWq-DBQMWof6hyh0_sS4OPOP7afJXYdaWTiqf15MpKAg@mail.gmail.com>
 <20160727053112.GY15995@brightrain.aerifal.cx>
 <20160804222757.GO15995@brightrain.aerifal.cx>
In-Reply-To: <20160804222757.GO15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>

On Thu, Aug 04, 2016 at 06:27:57PM -0400, Rich Felker wrote:
> On Wed, Jul 27, 2016 at 01:31:12AM -0400, Rich Felker wrote:
> > On Wed, May 25, 2016 at 08:18:06AM -0500, Rob Herring wrote:
> > > On Wed, May 25, 2016 at 12:43 AM, Rich Felker <dalias@libc.org> wrote:
> > > > The J-Core project (j-core.org) produces open source cpu and SoC
> > > > peripheral cores synthesizable as FPGA bitstreams or ASICs.
> > > >
> > > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > 
> > > Please add acks when posting subsequent versions.
> > > 
> > > > ---
> > > >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > > index 86740d4..9c070b8 100644
> > > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > > @@ -126,6 +126,7 @@ invensense  InvenSense Inc.
> > > >  isee   ISEE 2007 S.L.
> > > >  isil   Intersil
> > > >  issi   Integrated Silicon Solutions Inc.
> > > > +jcore  J-Core.org
> > > >  jedec  JEDEC Solid State Technology Association
> > > >  karo   Ka-Ro electronics GmbH
> > > >  keymile        Keymile GmbH
> > > > --
> > > > 2.8.1
> > 
> > Since this was previously acked, can I include it in my tree for
> > upstreaming? Or do you want me to submit the patch again?
> 
> Ping. Should this go upstream via me or someone else? It doesn't
> correspond to any specific driver subsystem.

If the maintainer has acked it, you can take it normally.

However, for this cycle I've now applied a patch fixing the 
alphabetizing of this file which surely will cause merge conflicts. So 
I've now applied this.

Rob
