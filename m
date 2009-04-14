From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Tue, 14 Apr 2009 07:16:15 +0000
Subject: Re: [RFC][patch] filesystem: Vmufat filesystem, version 4
Message-Id: <1239693375.6538.5.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1239654768.6542.10.camel@localhost.localdomain>
	 <20090413210030.GA14847@linux-sh.org>
	 <1239658604.6542.28.camel@localhost.localdomain>
	 <20090413215949.GD14847@linux-sh.org>
	 <1239692429.6538.2.camel@localhost.localdomain>
	 <20090414070314.GB29075@linux-sh.org>
In-Reply-To: <20090414070314.GB29075@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Josef 'Jeff' Sipek <jeffpc@josefsipek.net>, Sam Ravnborg <sam@ravnborg.org>

On Tue, 2009-04-14 at 16:03 +0900, Paul Mundt wrote:

> > 
> Everything about the on-disk format is tied to the VMU. Until that sinks
> in, don't bother sending me email, thanks.

No, everything in the file system is dependent on the specification. The
specification is not dependent on the hardware. Those are the facts.


