From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 22 Oct 2015 16:34:27 +0000
Subject: Re: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
Message-Id: <20151022163427.GG26603@e104818-lin.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
 <CAMuHMdWyvaecQHOzFnxVZus_Pfkxjw1XfkGdcLK=D2ThaoJMzA@mail.gmail.com>
 <20151021202907.GN32532@n2100.arm.linux.org.uk>
 <20151022092629.GQ32532@n2100.arm.linux.org.uk>
 <5628C0DD.50900@huawei.com>
 <20151022111307.GS32532@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1510221429300.7380@nanos>
In-Reply-To: <alpine.DEB.2.11.1510221429300.7380@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 22, 2015 at 02:43:34PM +0200, Thomas Gleixner wrote:
> On Thu, 22 Oct 2015, Russell King - ARM Linux wrote:
> > The solutions are:
> > * A patch to restore the pr_debug() which Thomas applies, and Catalin
> >   and myself then pull Thomas' tree again, which potentially creates
> >   a messier history.
> > 
> > * Catalin drops the ARM64 change and Thomas' tree from the ARM64 tree,
> >   Thomas drops the original commit, and we start again doing it
> >   correctly.
> > 
> > Which is up to Catalin and Thomas.
> 
> I'd have to do a revert as it's in the middle of other changes. So I
> prefer to do an incremental fix.
> 
> I committed the change into the irq/for-arm branch and pushed it out.

I pulled the branch again into arm64 for-next/core. Thanks.

-- 
Catalin
