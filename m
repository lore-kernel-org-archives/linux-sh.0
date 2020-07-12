From: Rob Landley <rob@landley.net>
Date: Sun, 12 Jul 2020 10:58:26 +0000
Subject: Re: [PATCH] SUPERH: Replace HTTP links with HTTPS ones
Message-Id: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709021737.22667-1-grandmaster@al2klimov.de>
In-Reply-To: <20200709021737.22667-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>, ysato@users.sourceforge.jp, dalias@libc.org, broonie@kernel.org, sboyd@kernel.org, arnd@arndb.de, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/8/20 9:17 PM, Alexander A. Klimov wrote:
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9fc2b010e938..bc91bdb0b665 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -74,7 +74,7 @@ config SUPERH
>  	  The SuperH is a RISC processor targeted for use in embedded systems
>  	  and consumer electronics; it was also used in the Sega Dreamcast
>  	  gaming console.  The SuperH port has a home page at
> -	  <http://www.linux-sh.org/>.
> +	  <https://www.linux-sh.org/>.

That's a historical page last edited in 2006 (according to
http://www.linux-sh.org/shwiki/RecentChanges/ anyway) with a self-signed
certificate that pops up a full page warning on chrome about the certificate
being invalid, in a wiki that can theoretically be edited by arbitrary third
parties anyway.

Not a huge man-in-the-middle target.

Rob
