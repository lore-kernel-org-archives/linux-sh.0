From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 May 2009 04:11:56 +0000
Subject: Re: [BUG] Error in copy_process, when enable CONFIG_PROVE_LOCKING.
Message-Id: <20090518041155.GA18919@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
In-Reply-To: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 12, 2009 at 01:15:22PM +0100, Stuart MENEFY wrote:
> Nobuhiro Iwamatsu wrote:
> > Error in copy_process, when enable CONFIG_PROVE_LOCKING.
> > This error has p->hardirqs_enabled in kernel.fork.c
> > 
> >  987 #ifdef CONFIG_PROVE_LOCKING
> >  988     DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
> >  989     DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
> >  990 #endif
> >  991     retval = -EAGAIN;
> > 
> > The error message is as follows.
> > I am debuging this. Please teach if you know the revision method of
> > this problem.
> 
> As it happens I was looking at this recently. I think there are some
> missing calls to trace_hardirqs_on/off in the assembly
> code. Unfortunately my kernel is quite different from the mainline in
> this area, but you could try this patch which is an *untested* forward
> port of the code I'm currently running successfully.
> 
This deadlocks for me with PROVE_LOCKING enabled, though it is certainly
an improvement over what we had before. I'll try and debug it a bit more
over the next few days when I get some spare cycles. If you have your
kernel source available somewhere it would certainly make comparing the
differences easier.
