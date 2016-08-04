From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 22:27:57 +0000
Subject: Re: [PATCH v3 01/12] of: add vendor prefix for J-Core
Message-Id: <20160804222757.GO15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <b6d33800300bde8f1d9a7b88a715d741548fad4a.1464148904.git.dalias@libc.org>
 <CAL_JsqKWq-DBQMWof6hyh0_sS4OPOP7afJXYdaWTiqf15MpKAg@mail.gmail.com>
 <20160727053112.GY15995@brightrain.aerifal.cx>
In-Reply-To: <20160727053112.GY15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>

On Wed, Jul 27, 2016 at 01:31:12AM -0400, Rich Felker wrote:
> On Wed, May 25, 2016 at 08:18:06AM -0500, Rob Herring wrote:
> > On Wed, May 25, 2016 at 12:43 AM, Rich Felker <dalias@libc.org> wrote:
> > > The J-Core project (j-core.org) produces open source cpu and SoC
> > > peripheral cores synthesizable as FPGA bitstreams or ASICs.
> > >
> > > Signed-off-by: Rich Felker <dalias@libc.org>
> > 
> > Please add acks when posting subsequent versions.
> > 
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > index 86740d4..9c070b8 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > @@ -126,6 +126,7 @@ invensense  InvenSense Inc.
> > >  isee   ISEE 2007 S.L.
> > >  isil   Intersil
> > >  issi   Integrated Silicon Solutions Inc.
> > > +jcore  J-Core.org
> > >  jedec  JEDEC Solid State Technology Association
> > >  karo   Ka-Ro electronics GmbH
> > >  keymile        Keymile GmbH
> > > --
> > > 2.8.1
> 
> Since this was previously acked, can I include it in my tree for
> upstreaming? Or do you want me to submit the patch again?

Ping. Should this go upstream via me or someone else? It doesn't
correspond to any specific driver subsystem.

Rich
