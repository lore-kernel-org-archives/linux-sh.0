From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 13:26:47 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <20090914132646.GC21091@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 02:12:34PM +0900, Nobuhiro Iwamatsu wrote:
> 2009/8/28 Matt Fleming <matt@console-pimps.org>:
> > Index: gas/config/tc-sh.c
> > =================================> > RCS file: /cvs/src/src/gas/config/tc-sh.c,v
> > retrieving revision 1.132
> > diff -u -r1.132 tc-sh.c
> > --- gas/config/tc-sh.c ?24 Jul 2009 11:45:00 -0000 ? ? ?1.132
> > +++ gas/config/tc-sh.c ?27 Aug 2009 20:09:14 -0000
> > @@ -156,6 +156,11 @@
> > ?#define ENCODE_RELAX(what,length) (((what) << 4) + (length))
> > ?#define GET_WHAT(x) ((x>>4))
> >
> > +/* Truncate and sign-extend at 32 bits, so that building on a 64-bit host
> > + ? gives identical results to a 32-bit host. ?*/
> > +#define TRUNC(X) ? ? ? ((long) (X) & 0xffffffff)
> > +#define SEXT(X) ? ? ? ? ? ? ? ?((TRUNC (X) ^ 0x80000000) - 0x80000000)
> > +
> > ?/* These are the three types of relaxable instruction. ?*/
> > ?/* These are the types of relaxable instructions; except for END which is
> > ? ?a marker. ?*/
> > @@ -4183,7 +4188,7 @@
> > ? ? ? ?val = ((val >> shift)
> > ? ? ? ? ? ? ? | ((long) -1 & ~ ((long) -1 >> shift)));
> > ? ? }
> > - ?if (max != 0 && (val < min || val > max))
> > + ?if (max != 0 && (SEXT(val) < min || SEXT(val) > max))
> > ? ? as_bad_where (fixP->fx_file, fixP->fx_line, _("offset out of range"));
> > ? else if (max != 0)
> > ? ? /* Stop the generic code from trying to overlow check the value as well.
> 
> I think that I should cope in a kernel, because this problem is thing
> by the limit of mov.
> # mov of this case supports only 8bit.
> 
The whole reason that the toolchain patch is necessary is because 64-bit
hosts weren't doing sign extension on a truncated 32-bit value, which is
a legitimate bug.

As far as the mov size, a manually sign extended value is perfectly
acceptable, and any toolchain should be intelligent enough to get the
size calculation right. It's obviously not entirely elegant, but it's
much less confusing than running in to situations where the same
immediate is used and it may or may not be sign extended, depending on
which instruction it gets used with. That ambiguity is what this approach
solves, and I think it is definitely worthwhile trying to keep it as
simple as possible to prevent sign extension bugs from popping up.

If you've ever had to chase a sign extension bug, you will appreciate the
value of this (especially given the sometimes rather inconsistent
instruction set).
