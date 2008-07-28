From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 28 Jul 2008 21:24:40 +0000
Subject: Re: drivers/sh/maple/maple.c compile error
Message-Id: <1217280280.6875.14.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728202012.GD7713@cs181140183.pp.htv.fi>
	 <20080728204438.GC20019@linux-sh.org>
	 <1217278308.6875.3.camel@localhost.localdomain>
	 <20080728210121.GA27971@linux-sh.org>
	 <1217279595.6875.11.camel@localhost.localdomain>
In-Reply-To: <1217279595.6875.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Adrian Bunk <bunk@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2008-07-28 at 22:13 +0100, Adrian McMenamin wrote:
> On Tue, 2008-07-29 at 06:01 +0900, Paul Mundt wrote:
> > On Mon, Jul 28, 2008 at 09:51:48PM +0100, Adrian McMenamin wrote:
> > > On Tue, 2008-07-29 at 05:44 +0900, Paul Mundt wrote:
> > > > On Mon, Jul 28, 2008 at 11:20:12PM +0300, Adrian Bunk wrote:
> > > > > Commit 306cfd630a4d121cf4e08b894d8b4c4cf106e57e
> > > > > (maple: tidy maple_driver code by removing redundant connect/disconnect)
> > > > > causes the following compile error:

> > 
> 
> http://lkml.org/lkml/2008/6/15/121 - removes the references from
> keyboard
> http://lkml.org/lkml/2008/6/15/122 - removes the references from the
> headers
> 

Ah I see what the issue is now. My apologies, it seems I made a patch
and for some reason never submitted it. But will do so now.

