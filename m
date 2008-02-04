From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 04 Feb 2008 08:23:44 +0000
Subject: Re: [PATCH] SH/Dreamcast - fix regressions, whitespace and memory
Message-Id: <1202113424.6489.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202068847.6262.7.camel@localhost.localdomain>
	 <20080204011034.GA22021@linux-sh.org>
In-Reply-To: <20080204011034.GA22021@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>


On Mon, 2008-02-04 at 10:10 +0900, Paul Mundt wrote:
> On Sun, Feb 03, 2008 at 08:00:47PM +0000, Adrian McMenamin wrote:
> > From: Adrian McMenamin
> > 
> This is useless if you are submitting the patch, especially if you're
> missing a mail address.
> 

From Documentation/SubmittingPatches

The canonical patch message body contains the following:
  * 
  *   - A "from" line specifying the patch author.
  * 


> > This patch fixes the regression noted here:
> > http://lkml.org/lkml/2008/1/26/189 as well as whitespace issues in the
> > previous commit of this driver and the memory leaks noted here:
> > http://lkml.org/lkml/2008/2/2/143 (as well as one or two other minor
> > cleanups).
> > 
> The subject notes 3 specific things that are being addressed, but you've
> rolled this all in to one patch which makes it utterly impossible to
> figure out what you're actually fixing. At the very least, split this in
> to 3 different patches, each dealing with one of the things noted in the
> subject. The fact that regressions is plural also suggests you may want
> to split this down in to smaller patches that deal with specific
> regressions if they are not directly related.
> 

What would be the point of submitting patches of broken code just to
remove the whitespace your previous commit added to all the lines?


> > Signed off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > 
> Do not invent new sign-off tags, see Documentation/SubmittingPatches.
> Scripts do end up having to parse this stuff.


Yes, sorry for that.

