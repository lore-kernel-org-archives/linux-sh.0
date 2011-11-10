From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 10 Nov 2011 03:47:05 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: sh7372 A4R suspend/resume order fix
Message-Id: <20111110034704.GB7271@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111091914120.4188@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111091914120.4188@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 10, 2011 at 11:14:42AM +0900, Magnus Damm wrote:
> On Thu, Nov 10, 2011 at 8:30 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, November 09, 2011, Guennadi Liakhovetski wrote:
> >> I took the liberty to reimplement the original fix by Magnus in a
> >> different way. I didn't quite like the idea of rewriting platform data,
> >> which could and, probably, should actually be const, on each
> >> domain-suspend. Instead, checking in resume, whether a valid state
> >> snapshot is available seemed a bit prettier to me:-) The maintainer is, of
> >> course, free to choose whichever version he prefers, they both
> >>
> >> "Fix issue in v3.2-rc1 on the sh7372 Mackerel board."
> >
> > Magnus, Paul, which one do you want me to take?
> 
> I prefer leaving the INTCS code as-is - unaware of calling order and
> putting the workaround in the Runtime PM code. In the end the ordering
> issue is related to Runtime PM and not INTCS. If someone knows a
> better way to fix the Runtime PM code then I'd be happy to accept
> that. But I don't like putting the workaround in INTCS.
> 
Agreed. While I don't much care for the approach taken by this patch
either, keeping it insular at the framework level until the need for it
can be resolved in the runtime PM code seems like a reasonable stop-gap.
I would rather not paper over this in the platform code since it'll
invariably lead to more instances that need to be audited and cleaned up
later on, in addition to being more error prone.
