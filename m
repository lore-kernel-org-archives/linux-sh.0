From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 16:17:01 +0000
Subject: Re: sh kexec build error
Message-Id: <20080728161701.GA17350@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080728130613.GB30612@cs181140183.pp.htv.fi> <20080728131444.GA15942@linux-sh.org> <20080728161004.GH30612@cs181140183.pp.htv.fi>
In-Reply-To: <20080728161004.GH30612@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 28, 2008 at 07:10:04PM +0300, Adrian Bunk wrote:
> On Mon, Jul 28, 2008 at 10:14:44PM +0900, Paul Mundt wrote:
> > On Mon, Jul 28, 2008 at 04:06:13PM +0300, Adrian Bunk wrote:
> > > Commit 3ab83521378268044a448113c6aa9a9e245f4d2f (kexec jump)
> > > causes the following build error on sh:
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > >   CC      kernel/kexec.o
> > > {standard input}: Assembler messages:
> > > {standard input}:1518: Error: offset to unaligned destination
> > > make[2]: *** [kernel/kexec.o] Error 1
> > > 
> > > <--  snip  -->
> > > 
> > > If I understand the assembler correctly it fails at
> > > include/asm-sh/kexec.h:59
> > > 
> > Indeed. This should fix it:
> 
> 
> I can confirm that your patch fixes the compilation.
> 
Thanks for testing, I'll roll it in with my next batch of updates.
