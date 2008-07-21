From: Stuart MENEFY <stuart.menefy@st.com>
Date: Mon, 21 Jul 2008 12:39:12 +0000
Subject: Re: where are initcalls defined?
Message-Id: <48848370.2050504@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <488453DB.70101@spesonline.com>
In-Reply-To: <488453DB.70101@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Luca

Luca Santini wrote:
> I'm trying to port kernel 2.6.26 to edosk7760 board.
> my kernel hangs up during initcalls;
> with a little debugging i found that with a minimal config (only ext2 fs 
> for example)
> skipping the 71th initcalls my kernel continues to boot until
> 
> 
> [    1.665032] No filesystem could mount root, tried:  ext2
> [    1.670330] Kernel panic - not syncing: VFS: Unable to mount root fs 
> on unknown-block(1,0)
> 
> 
> where can i found the initcalls vector list ?

The initcalls table is built by the linker by concatenating all
the .initcall<level>.init sections. These are created by the
<level>_initcall macros.

The easiest way to debug this sort of problem is to run with the
initcall_debug kernel command line option, which will print the
name of each function before calling it.

Stuart

