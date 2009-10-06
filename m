From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Oct 2009 04:07:28 +0000
Subject: Re: SH ATAPI IDE Driver
Message-Id: <20091006040728.GA18906@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
In-Reply-To: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 06, 2009 at 12:42:18PM +0900, ivy kim wrote:
> It seems that there is no atapi driver for SH7724.
> I'm writing this atapi driver for our company's own SH7724 platform
> called 'REVE'.
> I've wrote one driver, ide-sh.c based on ide-platform.c and succeeded
> in IDE disk chip ID reading.

For starters, no new drivers should be written aimed at drivers/ide,
libata is what you should be working with instead, aiming your driver at
drivers/ata (you can see many other pata drivers there for examples on
getting started, including ones that deal with ATAPI).

> It seems that there is no document on 'Writing IDE device driver'...also.

All of the libata documentation is in-kernel, and you can generate pdfs
with 'make pdfdocs', or you can just read through the DocBook file in
Documentation/DocBook/libata.tmpl.

If you run in to further issues, you may also wish to subscribe to or Cc
the linux-ide@vger.kernel.org mailing list, where all IDE and libata
related discussion takes place:

	http://vger.kernel.org/vger-lists.html#linux-ide
