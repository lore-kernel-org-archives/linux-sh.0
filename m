From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Feb 2008 21:54:52 +0000
Subject: Re: [PATCH] sh: trapped io support
Message-Id: <20080206215452.GC13945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080206151929.27099.5627.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080206151929.27099.5627.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 07, 2008 at 06:44:59AM +0900, Paul Mundt wrote:
> On Thu, Feb 07, 2008 at 12:19:29AM +0900, Magnus Damm wrote:
> > +static int from_user(void *dst, void *src, int cnt)
> > +{
> > +	return copy_from_user(dst, src, cnt);
> > +}
> > +
> > +static int to_user(void *dst, void *src, int cnt)
> > +{
> > +	return copy_to_user(dst, src, cnt);
> > +}
> > +
> > +static struct mem_access user_mem_access = {
> > +	from_user,
> > +	to_user,
> > +};
> > +
> The argument ordering and everything in these is exactly the same, why
> don't you use copy_to_user()/copy_from_user() in your structure here
> instead of these no-op wrappers?
> 
Or rather, just make copy_to_user()/copy_from_user() inlines rather than
macros so they can be used here. If you're already certain about the
access, you can also use the __copy_to/from_user() variants which can be
dropped in here assuming you can live without the access_ok()
verification.
