From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Feb 2008 01:10:34 +0000
Subject: Re: [PATCH] SH/Dreamcast - fix regressions, whitespace and memory leaks in Maple Bus driver
Message-Id: <20080204011034.GA22021@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202068847.6262.7.camel@localhost.localdomain>
In-Reply-To: <1202068847.6262.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

On Sun, Feb 03, 2008 at 08:00:47PM +0000, Adrian McMenamin wrote:
> From: Adrian McMenamin
> 
This is useless if you are submitting the patch, especially if you're
missing a mail address.

> This patch fixes the regression noted here:
> http://lkml.org/lkml/2008/1/26/189 as well as whitespace issues in the
> previous commit of this driver and the memory leaks noted here:
> http://lkml.org/lkml/2008/2/2/143 (as well as one or two other minor
> cleanups).
> 
The subject notes 3 specific things that are being addressed, but you've
rolled this all in to one patch which makes it utterly impossible to
figure out what you're actually fixing. At the very least, split this in
to 3 different patches, each dealing with one of the things noted in the
subject. The fact that regressions is plural also suggests you may want
to split this down in to smaller patches that deal with specific
regressions if they are not directly related.

> Signed off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
Do not invent new sign-off tags, see Documentation/SubmittingPatches.
Scripts do end up having to parse this stuff.
