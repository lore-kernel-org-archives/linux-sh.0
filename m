From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 16 Jul 2014 11:59:42 +0000
Subject: Re: ARM: shmobile: r7s72100: genmai: CONFIG_MACH_GENMAI
Message-Id: <1741462.gsq1khyh60@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405509309.4408.36.camel@x220>
In-Reply-To: <1405509309.4408.36.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Paul,

On Wednesday 16 July 2014 13:15:09 Paul Bolle wrote:
> Commit bec652e2fbfe ("ARM: shmobile: r7s72100: genmai: Remove legacy
> board file") is included in linux-next as of next-20140716.
> 
> It removed the Kconfig symbol MACH_GENMAI (twice!). It also removed its
> macro from a Makefile. It did not touch its macro from
> arch/arm/mach-shmobile/Makefile.boot.

That was a mistake, sorry.

> Is the trivial patch to remove CONFIG_MACH_GENMAI from that Makefile
> queued somewhere?

Not yet. I've just sent "[PATCH] ARM: shmobile: Remove MACH_GENMAI from 
Makefile.boot" to the linux-sh mailing list.

-- 
Regards,

Laurent Pinchart

