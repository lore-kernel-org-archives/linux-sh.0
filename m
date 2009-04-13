From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Apr 2009 21:00:30 +0000
Subject: Re: [RFC][patch] filesystem: Vmufat filesystem, version 4
Message-Id: <20090413210030.GA14847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1239654768.6542.10.camel@localhost.localdomain>
In-Reply-To: <1239654768.6542.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Josef 'Jeff' Sipek <jeffpc@josefsipek.net>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Apr 13, 2009 at 09:32:48PM +0100, Adrian McMenamin wrote:
> I know this still has issues that others have raised but I wanted to
> post a version before the end of the long weekend...
> 
Make sure all of the folks that had comments are included in the Cc on
future versions. If they haven't seen the updated version and are
therefore unable to comment on it, that is not an indicator that the
issues have been addressed.

Reviewing code is tedious work at best, making people that have taken the
time to participate in review do even more work to find updated versions
that may or may not have addressed their issues is remarkably poor
etiquette at best, especially when they haven't completed their review.

Timing is also not so important. This code has been in development off
and on for the last 7 years, another weekend isn't going to make any
difference. Additionally, rushing through versions when you know they
haven't taken all of the concerns under advisement is only going to
discourage people from taking the time out to review anyways.

Unless you plan on hacking on this for another 7 years, you may wish to
heed some of these points, especially now that things are finally
starting to take better shape. It would be a shame to see this bitrot
now given that all of the heavy lifting is effectively done.

> A few people commented that this is a bit long for a single file - but
> it is comparable to other files in the filesystem hierarchy - comments
> welcome.
> 
Ultimately you have to think about whether splitting it up makes sense or
not. Given that there are a lot of VMU related bits here that are separate
from the file system itself, it wouldn't hurt to break things out a bit
more logically. It's a lot to take in at once, especially for folks that
aren't familiar with all of the different aspects that the fs touches
upon.

Furthermore, the fact other file systems haven't done so is not an excuse
for you not to, especially as their reasons for doing so might be valid
(you of course haven't bothered citing what other file systems you are
referring to, so one can only vaguely postulate, though at least the
arguments for things like cramfs do not apply to vmufat).

You should also think about whether you really want to go down the road
of decoupling this from the VMU device dependencies. vmufat is not and
never will be a general purpose file system, the on-disk format,
limitation in block numbering, etc. are all directly tied to the VMU
itself. Since you cited emulators as a potential user, these should be
emulating the VMU itself anyways before you worry about layering vmufat
on top of it. Trying to position this as a general purpose file system
will bring you a world of pain you really don't want.
