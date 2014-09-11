From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Sep 2014 08:54:04 +0000
Subject: Re: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for v3.18
Message-Id: <5147898.LS8hxRrHzU@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1410396013.git.horms+renesas@verge.net.au>
 <2746360.e5Qbnl0Vc0@wuerfel>
 <CAMuHMdU30XE8A55m++W=Rf=0fVu3s07J=ki10bEuuDN4bgxqeA@mail.gmail.com>
In-Reply-To: <CAMuHMdU30XE8A55m++W=Rf=0fVu3s07J=ki10bEuuDN4bgxqeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 11 September 2014 10:46:02 Geert Uytterhoeven wrote:
> However, I don't see the warning with my current tree, nor with next-20140910,
> as both are selected with mackerel_defconfig, due to:
> 
>  config ARCH_RMOBILE
>         bool
>         select PM_RMOBILE if PM && !ARCH_SHMOBILE_MULTI
> 
> Perhaps this change hadn't trickled from Simon's tree into your tree, due
> to following a different merge path?

Ah, you are right, I was testing with another branch merged in that changed
some of the Kconfig statements in shmobile to work around randconfig build
problems. Apparently one of the patches in my branch was wrong, the
shmobile branches are all good.

Sorry for the noise.

	Arnd
