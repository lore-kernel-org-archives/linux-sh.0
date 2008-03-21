From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 21 Mar 2008 05:11:44 +0000
Subject: Re: [PATCH] 1/2 Maple: Update bus driver to allow support of VMU device
Message-Id: <20080321051144.GA16926@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1205879413.6250.13.camel@localhost.localdomain> <1205880554.6250.25.camel@localhost.localdomain> <20080320135618.1a283b3e.akpm@linux-foundation.org> <1206051797.6274.17.camel@localhost.localdomain> <20080320153944.75b6edc1.akpm@linux-foundation.org> <1206053547.6274.28.camel@localhost.localdomain>
In-Reply-To: <1206053547.6274.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org, greg@kroah.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mtd@vger.kernel.org

On Thu, Mar 20, 2008 at 10:52:27PM +0000, Adrian McMenamin wrote:
> 
> On Thu, 2008-03-20 at 15:39 -0700, Andrew Morton wrote:
> > On Thu, 20 Mar 2008 22:23:17 +0000
> > Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> > 
> > > 
> > > > urgh, down_trylock().  And a secret, undocumented one too.
> > > > 
> > > > A trylock is always an exceptional thing.  How is *any* reader of this code
> > > > supposed to work out what the heck it's doing there?  Convert it into
> > > > down(), run the code and decrypt the lockdep warnings, I suspect.
> > > > 
> > > > <looks>
> > > > 
> > > > Nope, I can't see any other lock being held when we call this function.
> > > > 
> > > > The trylocks are an utter mystery to me.  Please don't write mysterious
> > > > code.
> > > > 
> > > 
> > > OK, I am sure this is my problem but I have no idea why you are
> > > describing down_trylock as undocumented
> > 
> > I'm describing your use of it!  I'm sitting here trying to work out why on
> > earth this code is using the highly unusual (and highly suspicious) trylock
> > idiom and this is far from clear.
> > 
> 
> OK, I understand your point now. Some comments wouldn't go amiss, for
> sure.
> 
Other than the fact the locking is bizarre and utterly incomprehensible,
why are you using a semaphore here at all? You're effectively using it as
a mutex, and you really should be using that API instead, especially for
the debugging capabilities. This patch set looks like an excellent stress
test for the mutex debugging code.
