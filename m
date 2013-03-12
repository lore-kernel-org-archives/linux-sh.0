From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 12 Mar 2013 07:57:47 +0000
Subject: Re: [PATCH] sh: remove references to CPU_SUBTYPE_SH7764
Message-Id: <20130312075747.GB3553@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1363002940.3137.65.camel@x61.thuisdomein>
In-Reply-To: <1363002940.3137.65.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 11, 2013 at 12:55:40PM +0100, Paul Bolle wrote:
> Since release v2.6.29 the tree has a few references to the Kconfig
> symbol CPU_SUBTYPE_SH7764 and the Kconfig macro
> CONFIG_CPU_SUBTYPE_SH7764. But the actual symbol CPU_SUBTYPE_SH7764 was
> never added to the tree. Perhaps no one noticed because these references
> were never used alone. Anyhow, these references serve no purpose and
> can be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Looks fine, I suspect Iwamatsu-san let this trickle in from some vendor
branch given that these are all his drivers. I'll queue it up, thanks.
