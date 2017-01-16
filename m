From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 16 Jan 2017 14:40:44 +0000
Subject: Re: Resolving glibc namespace conflicts with R0..Rn
Message-Id: <f48128c6-86f6-f460-4aa1-57ccacb09ebd@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <e35765d0-5daa-7289-4d35-0b416013494c@physik.fu-berlin.de>
In-Reply-To: <e35765d0-5daa-7289-4d35-0b416013494c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/16/2017 03:36 PM, Rich Felker wrote:
>> Apparently, the only big user which would suffer breakage would be gdb but since
>> there is currently not official SH support in gdb anyway, I think we're good
>> to go.
> 
> I'm fine with this change. Apparently we don't have the plain Rn
> macros on musl at all, perhaps for this very reason.

Ok, great. I have already opened a bug report for that:

> https://sourceware.org/bugzilla/show_bug.cgi?id!053

I can build a package with the registers renamed to test it.

> Of course what I'd like even better is to get rid of the REG_* macros
> too except in the case where the application explicitly requests them.
> A similar issue hit us recently for x86 due to g++ auto-defining
> _GNU_SOURCE and subtle differences in how we defined the REG_* macros:
> 
> http://www.openwall.com/lists/musl/2017/01/03/7
> 
> Exposing junk like this made sense when you only got it by including
> sys/ucontext.h, but not now that signal.h is expected to expose
> ucontext_t. And unfortunately it's not just macros but types used in
> the definition of ucontext_t that are namespace-polluting. So I don't
> see any really good outs without breaking compatibility with stuff.
> musl exposes opaque fake mcontext_t when _BSD_SOURCE and _GNU_SOURCE
> are off, but in practice one or both is usually on...

I agree. But I guess that would require a more involved discussion :).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
