From: Rich Felker <dalias@libc.org>
Date: Mon, 16 Jan 2017 14:36:21 +0000
Subject: Re: Resolving glibc namespace conflicts with R0..Rn
Message-Id: <20170116143621.GF1533@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <e35765d0-5daa-7289-4d35-0b416013494c@physik.fu-berlin.de>
In-Reply-To: <e35765d0-5daa-7289-4d35-0b416013494c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jan 15, 2017 at 01:21:49PM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> We're currently running into a name conflict issue when building Firefox on sh4
> with the R0..Rn register names. Apparently, there have been several packages which
> were affected by this issue with the result that glibc upstream decided to resolve
> this issue on ARM by renaming Rn to REG_Rn [1]. The discussion in the Firefox bugtracker
> regarding the issue can be followed here [2].
> 
> Would it be possible to make this change in glibc on SH as well?
> 
> Apparently, the only big user which would suffer breakage would be gdb but since
> there is currently not official SH support in gdb anyway, I think we're good
> to go.

I'm fine with this change. Apparently we don't have the plain Rn
macros on musl at all, perhaps for this very reason.

Of course what I'd like even better is to get rid of the REG_* macros
too except in the case where the application explicitly requests them.
A similar issue hit us recently for x86 due to g++ auto-defining
_GNU_SOURCE and subtle differences in how we defined the REG_* macros:

http://www.openwall.com/lists/musl/2017/01/03/7

Exposing junk like this made sense when you only got it by including
sys/ucontext.h, but not now that signal.h is expected to expose
ucontext_t. And unfortunately it's not just macros but types used in
the definition of ucontext_t that are namespace-polluting. So I don't
see any really good outs without breaking compatibility with stuff.
musl exposes opaque fake mcontext_t when _BSD_SOURCE and _GNU_SOURCE
are off, but in practice one or both is usually on...

Rich
