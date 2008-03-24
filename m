From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Date: Mon, 24 Mar 2008 11:21:31 +0000
Subject: Re: [PATCH] 2/3 mtd: add support for flash on the SEGA Dreamcast Visual Memory Unit
Message-Id: <20080324112131.GA2392@logfs.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
	<20080322183200.GD19347@logfs.org>
	<1206211147.6324.48.camel@localhost.localdomain>
	<20080322185600.GE19347@logfs.org>
	<1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
	<20080322183200.GD19347@logfs.org>
	<1206211147.6324.48.camel@localhost.localdomain>
	<20080324020832.GA13935@linux-sh.org>
In-Reply-To: <20080324020832.GA13935@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, Adrian McMenamin <adrian@newgolddream.dyndns.info>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>

On Mon, 24 March 2008 11:08:32 +0900, Paul Mundt wrote:
>
> I've hit the same issues with Adrian's patches in the past, but I've
> weighed this against a couple of factors:
>=20
> 	- Is it reasonably isolated.
> 	- Does it break anything else.
> 	- Is it more likely to get pointed at and fixed in-tree or out.

I tend to agree with one condition: There needs to be a prospect of
improvement.  My two preferred variants would be one person doing
everything or two people, one improving the code and the other testing
on hardware to detect and prevent regressions.

For a moment I was contemplating just taking the mtd driver and doing
the work myself.  But two things stopped me short.  For one, I didn't
find the referenced header anywhere.  Secondly I lack any hardware to
test the result.

But more to the point, I cannot come to terms with Adrian.  So either
one of us has to be replaced - and I cannot see a lot of volunteers - or
we are currently lacking the prospect of improvement.  Hence my bad
feeling about this code.

Hopefully I just caught Adrian on the wrong foot.

> With that said, the current code obviously needs quite a bit of work
> before it can be merged. I'm obviously coming in to this thread late, so
> it would be helpful to have a pointer to the initial review comments.

Thread starts here:
http://lists.infradead.org/pipermail/linux-mtd/2008-March/020880.html

J=C3=B6rn

--=20
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
