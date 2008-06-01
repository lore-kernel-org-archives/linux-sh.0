From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 01 Jun 2008 19:53:06 +0000
Subject: Re: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <20080601195306.GD7347@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
References: <20080531202239.GB7347@cs181133002.pp.htv.fi> <20080601053047.GA25429@linux-sh.org>
In-Reply-To: <20080601053047.GA25429@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, sam@ravnborg.org, hjl.tools@gmail.com, linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jun 01, 2008 at 02:30:47PM +0900, Paul Mundt wrote:
> On Sat, May 31, 2008 at 11:22:39PM +0300, Adrian Bunk wrote:
> > Minimal example demonstrating the problem:
> > 
> > $ sh64-linux-ar rcs tmp.o
> > $ sh64-linux-ld -EL -r -o tmp2.o tmp.o
> > $ sh64-linux-ld -EL -r -o out.o tmp2.o 
> > sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
> > $ 
> > 
> Yes, it's a binutils bug. I've hit this on SH-2A zImage builds too, and
> hacked together a patch for it. I'll see about fixing it up fo sh64 too
> and then posting it to the list.

Thanks  :-)
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

