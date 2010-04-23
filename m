From: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
Date: Fri, 23 Apr 2010 11:16:18 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <h2hea710c1b1004230416ycd079c20gc930ea50dd9ccb3c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> The obvious remaining question would be are you sure that your serial
> port is really on ttySC1? Most of the SH7780 boards placed the console on
> ttySC0 by default, so make sure that you aren't just being bitten by a
> bogus defconfig setting.

Yes, I checked this too, and with older versions of the kernel I was
also using ttySC1.

> If you have board support patches that you've applied to the kernel then
> you might also want to try backing those off and simply booting with the
> default machvec with SH7780 support enabled. Given that the serial port
> is an SoC property you shouldn't have any difficulty getting a console
> even if you have no other board support built in.

Just tried with the latest official branch, and unfortunately no luck.
earlyprintk=bios,keep performs the same as our branch with respect to
the SCI.

> You may also want to disable sh-bios support in the off chance that this
> is clobbering something it shouldn't be (note that sh-bios support itself
> is almost never tested these days, and in the past it has always been a
> source of inconsistency).

Did that too, did not help with "earlyprintk=sh-sci.1" or
"earlyprintk=sh-sci.0" at all. :( Nothing is displayed, but the NFS
activity testifies that the kernel boots.

> If all else fails then we'll simply have to debug the init path, but I
> suspect you're being bitten by something completely unrelated given that
> none of the other SH7780's exhibit any sort of difficulty.

Indeed, this looks very strange to me too. Sorry for being clueless,
but I'm rather new to kernel programming and debugging - what would
you recommend me to try next?

Thanks,
Alex.
