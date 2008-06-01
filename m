From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 01 Jun 2008 05:30:47 +0000
Subject: Re: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <20080601053047.GA25429@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080531202239.GB7347@cs181133002.pp.htv.fi>
In-Reply-To: <20080531202239.GB7347@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: sam@ravnborg.org, hjl.tools@gmail.com, linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, May 31, 2008 at 11:22:39PM +0300, Adrian Bunk wrote:
> Minimal example demonstrating the problem:
> 
> $ sh64-linux-ar rcs tmp.o
> $ sh64-linux-ld -EL -r -o tmp2.o tmp.o
> $ sh64-linux-ld -EL -r -o out.o tmp2.o 
> sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
> $ 
> 
Yes, it's a binutils bug. I've hit this on SH-2A zImage builds too, and
hacked together a patch for it. I'll see about fixing it up fo sh64 too
and then posting it to the list.
