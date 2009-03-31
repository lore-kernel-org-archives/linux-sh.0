From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 Mar 2009 08:42:10 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <20090331084210.GB31415@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 30, 2009 at 09:02:54AM +0200, Francesco VIRLINZI wrote:
> Hi Magnus, Yoshii-san
> >Francesco, can you convince yoshii-san why we should add support for
> >an interpreter? =)
> >  
> I can try ;-)
> Than: I would push the interpreter solution because it will allow us to 
> be free in the future.
> If all the issue on 'cache preload' 'interpreter-instruction' are 
> resolved in 'one-shot' right now
> in the future for each new SOC we will have only to resolve 'what it 
> has to be done' and not 'how'....
> This simplifies our development flow because we don't have to rediscover 
> the wheel with always the same
> issue.
> I know the interpreter will not allow 'optimized code' but I think the 
> suspend assembly code doesn't have
> to be fast, it has to be right and for this reason I think it has to be 
> written one time for ever...
> Moreover an assembly code SOC oriented can not be seen as 'general 
> purpose' solution while the interpreter
> can be 'theoretically' used by everybody.

There are trade-offs either way. I tend to agree with Yoshii-san that
pushing the interpreter for everyone is a mistake, although I don't
disagree that it might be useful for some parts in the future. The real
question comes down to how different are the requirements for those
parts, and if there is not going to be any effort to push support
upstream for them, then there is hardly any reason to make the rest of
the in-tree parts suffer the pain of dealing with the interpreter.

We need to see hard requirements here, in technical detail, not
hand-waving about needing to be flexible for parts and requirements that
never materialize. Assembly stubs do work for the vast majority of cases
we have today, and the current model fits the CPU/board split pretty
well.

While I don't mind supporting multiple methods to support suspend (ie,
the interpreter for parts that want it, and common assembly stubs for
those that don't), we do not want to force all of the existing parts to
deal with it if they don't wish to.

The burden of proof is on you to point out why we need the interpreter,
rather than rationale for keeping it out-of-tree.

I am all for keeping the code as flexible and accomodating as possible,
but I draw the line at making upstream components suffer to accomodate
out-of-tree components that have no effort being put behind them to get
them merged.

Still, if the interpreter is clean enough, there is no harm in supporting
it as an optional component.
