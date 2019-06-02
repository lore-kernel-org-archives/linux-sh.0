From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 02 Jun 2019 11:29:08 +0000
Subject: Re: [linux-stable-rc:linux-5.0.y 1434/2350] arch/sh/kernel/cpu/sh2/clock-sh7619.o:undefined referenc
Message-Id: <87y32kp6nv.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201905301509.9Hu4aGF1%lkp@intel.com>
	<92c0e331-9910-82e9-86de-67f593ef4e5d@infradead.org>
	<20190531100004.0b1f4983@canb.auug.org.au>
	<871s0cqx33.wl-ysato@users.sourceforge.jp>
	<20190602174314.09f5f337@canb.auug.org.au>
In-Reply-To: <20190602174314.09f5f337@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Randy Dunlap <rdunlap@infradead.org>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, "Sasha Levin (Microsoft)" <sashal@kernel.org>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Sun, 02 Jun 2019 16:43:14 +0900,
Stephen Rothwell wrote:
> 
> [1  <text/plain; US-ASCII (quoted-printable)>]
> Hi Yoshinori,
> 
> On Sun, 02 Jun 2019 16:13:04 +0900 Yoshinori Sato <ysato@users.sourceforge.jp> wrote:
> >
> > Since I created a temporary sh-next, please get it here.
> > git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/sh-next
> 
> I have added that tree to linux-next from tomorrow.  However, thet is
> no sh-next tag in that tree, so I used the sh-next branch.  I don't
> think you need the back merge of Linus' tree.

Oh sorry. I created sh-next branch in this git repository.

> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.
> 
> -- 
> Cheers,
> Stephen Rothwell 
> sfr@canb.auug.org.au
> [2 OpenPGP digital signature <application/pgp-signature (7bit)>]
> No public key for 015042F34957D06C created at 2019-06-02T16:43:14+0900 using RSA

-- 
Yosinori Sato
