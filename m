From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 10 Mar 2008 18:41:00 +0000
Subject: Re: [SITE http://www.kernelarchive.com] - Request for kernels
Message-Id: <20080310184100.GA5727@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <20080310131700.382a6b3e.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080310131700.382a6b3e.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>, linux-main <linux-kernel@vger.kernel.org>

On Mon, Mar 10, 2008 at 01:17:00PM -0700, Kristoffer Ericson wrote:
> Greetings,
> 
> Hope Im not upsetting by posting this http link. My main thought about this site is not to compete with
> kernelnewbies or kerneltrap. instead its to give room to the linux kernel ports available (that rarely get any spotlight).
> Im going to hold record of what kernels work for a specific platform, maintainer, git repositories and so on.
> This is not a one day site, I intend to have this running for a long time since it doesn't cost me anything. It will 
> be free and open to anyone.
> 
> So Im asking maintainers to hand me kernels for their obscure machines. Im especially interested in handhelds and
> old-style computers. Examples :
> Amiga, Atari, spitz, collie, sparc, s390, powerpc, development boards... basicly anything non-x86.

An Amiga should (at least theoretically) run with an ftp.kernel.org 
kernel and the configuration you get with amiga_defconfig.

The same goes for all other platforms you mention.

There is a window between support for a platform being developed and it 
entering the main kernel tree, but that should only be a short window.

And in case a platform support stays long-term only in an external tree 
that's nothing that requires documentation - that's a problem that 
should be fixed.

> In mail, please supply any sources (git repositories, patches and so on).

cu
Adrian

BTW: Please correct the time setting on your computer.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

