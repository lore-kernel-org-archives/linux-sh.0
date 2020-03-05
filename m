From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 05 Mar 2020 15:49:22 +0000
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
Message-Id: <456fddd9-c980-b0f2-9dd0-19befee7861e@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <202003021038.8F0369D907@keescook>
 <20200305151010.835954-1-nivedita@alum.mit.edu>
 <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
 <31d1567c4c195f3bc5c6b610386cf0f559f9094f.camel@perches.com>
 <3c628a5a-35c7-3d92-b94b-23704500f7c4@physik.fu-berlin.de>
 <20200305154657.GA848330@rani.riverdale.lan>
In-Reply-To: <20200305154657.GA848330@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>, "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>, kernel-hardening@lists.openwall.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/5/20 4:46 PM, Arvind Sankar wrote:
> Not really too late. I can do s/pr_info/pr_devel and resubmit.
> 
> parisc for eg actually hides this in #if 0 rather than deleting the
> code.
> 
> Kees, you fine with that?

But wasn't it removed for all the other architectures already? Or are these
changes not in Linus' tree yet?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
