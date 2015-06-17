From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 17 Jun 2015 09:06:15 +0000
Subject: Re: [PATCH] i2c-tools: enable static use of libi2c
Message-Id: <20150617110615.7c7cb411@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1434420079-3029-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434420079-3029-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hallo Wolfram,

On Tue, 16 Jun 2015 04:01:19 +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> When debugging embedded systems, it is often nice to simply TFTP the
> desired i2ctool to the target without the hazzle of dealing with shared
> libs. Using -static is overkill, too, so let's add a switch which will
> only link functions from libi2c statically.

Fine with me.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Makefile        | 2 ++
>  tools/Module.mk | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 252a126..6d36f2f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,6 +33,8 @@ CFLAGS		+= -Wall
>  SOCFLAGS	:= -fpic -D_REENTRANT $(CFLAGS)
>  
>  BUILD_STATIC_LIB ?= 1
> +# Uncomment to use static libi2c
> +#USE_STATIC_LIB := 1

Any reason for not using ?= as above, with the default being unset?
That way BUILD_STATIC_LIB and USE_STATIC_LIB can both be controlled
using the same mechanism, and can be changed from their default value
on the command line (without patching the Makefile.)

>  
>  KERNELVERSION	:= $(shell uname -r)
>  
> diff --git a/tools/Module.mk b/tools/Module.mk
> index d14bb0c..8efddbb 100644
> --- a/tools/Module.mk
> +++ b/tools/Module.mk
> @@ -12,7 +12,11 @@ TOOLS_DIR	:= tools
>  TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
>  		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
>  		   -W -Wundef -Wmissing-prototypes -Iinclude
> +ifeq ($(USE_STATIC_LIB),1)
> +TOOLS_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
> +else
>  TOOLS_LDFLAGS	:= -Llib -li2c
> +endif

Unrelated to your patch, but shouldn't this -Llib rather been written
-L$(LIB_DIR)?

Also it might make sense to check if USE_STATIC_LIB is set when
BUILD_STATIC_LIB isn't and complain about it?

>  
>  TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
>  


-- 
Jean Delvare
SUSE L3 Support
