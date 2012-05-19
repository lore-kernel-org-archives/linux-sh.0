From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 19 May 2012 02:13:55 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <20120519021354.GI24355@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
 <20120516072927.GN7988@linux-sh.org>
 <20120518225747.893F33E07C8@localhost>
In-Reply-To: <20120518225747.893F33E07C8@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, olof@lixom.net

On Fri, May 18, 2012 at 04:57:47PM -0600, Grant Likely wrote:
> On Wed, 16 May 2012 16:29:28 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> > After which point you can iterate and dispose of the virq mappings with
> > irq_dispose_mapping(). The lack of irq domain teardown functionality does
> > need to be addressed though.
> 
> Yes, that falls firmly in the "that's a bug" category.  I need to get
> some time to fix it if someone doesn't beat me to it.
> 
I've got some code done for it already, along with a batch of other
changes. I'll have the series out for you shortly as soon as I'm done
with some additional testing.
