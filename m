From: Simon Horman <horms@verge.net.au>
Date: Sat, 09 Jan 2010 00:00:09 +0000
Subject: Re: [PATCH] Makefile: do not override LC_CTYPE
Message-Id: <20100109000008.GB2319@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20100108115745.GA14758@sepie.suse.cz>
 <1262952988-16563-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1262952988-16563-1-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Marek <mmarek@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <mhiramat@redhat.com>, Roland Dreier <rdreier@cisco.com>, Sam Ravnborg <sam@ravnborg.org>, Sergei Trofimovich <slyfox@inbox.ru>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hi Michal,

sorry for messing up your email address in one of the previous threads.

On Fri, Jan 08, 2010 at 01:16:28PM +0100, Michal Marek wrote:
> Setting LC_CTYPE=C breaks localized messages in some setups. With only
> LC_COLLATE=C and LC_NUMERIC=C, we get almost all we need, except for not
> so defined character classes and tolower()/toupper(). The former is not
> a big issue, because we can assume that e.g. [:alpha:] will always
> include a-zA-Z and we only ever process ASCII input. The latter seems
> only affect arch/sh/tools/gen-mach-types, which we can handle separately.
> 
> So after this patch the meaning of ranges like [a-z], the behavior of
> sort and join, etc. should be the same everywhere and at the same time
> gcc should be able to print localized waring and error messages.
> LC_NUMERIC=C might not be necessary, but setting it doesn't hurt.
> 
> Reported-by: Simon Horman <horms@verge.net.au>
> Reported-by: Sergei Trofimovich <slyfox@inbox.ru>
> Signed-off-by: Michal Marek <mmarek@suse.cz>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> 
> Note: if this still breaks for someone, we will simply set LC_ALL=C.

Personally I think it would be much better to set the locale explicitly
as needed, where needed, such as the LC_ALL=C sledgehammer that you
have inserted into arch/sh/tools. Or at a slightly higher level,
offer an awk-wrapper, as it seems to be the main (only?) cause of concern.

Surely the goal isn't to alter the user-experience - to the extent that a
build has a user-experience - but to force some tools to behave as desired.

Just an opinion. The patch below seems to work fine for me.

> 
>  Makefile               |    3 +--
>  arch/sh/tools/Makefile |    2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 09a320f..a7b4351 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -18,10 +18,9 @@ MAKEFLAGS += -rR --no-print-directory
>  
>  # Avoid funny character set dependencies
>  unexport LC_ALL
> -LC_CTYPE=C
>  LC_COLLATE=C
>  LC_NUMERIC=C
> -export LC_CTYPE LC_COLLATE LC_NUMERIC
> +export LC_COLLATE LC_NUMERIC
>  
>  # We are using a recursive build, so we need to do a little thinking
>  # to get the ordering right.
> diff --git a/arch/sh/tools/Makefile b/arch/sh/tools/Makefile
> index 558a56b..2082af1 100644
> --- a/arch/sh/tools/Makefile
> +++ b/arch/sh/tools/Makefile
> @@ -13,4 +13,4 @@
>  include/generated/machtypes.h: $(src)/gen-mach-types $(src)/mach-types
>  	@echo '  Generating $@'
>  	$(Q)mkdir -p $(dir $@)
> -	$(Q)$(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
> +	$(Q)LC_ALL=C $(AWK) -f $^ > $@ || { rm -f $@; /bin/false; }
> -- 
> 1.6.5.3
