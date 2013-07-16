From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 16 Jul 2013 07:54:29 +0000
Subject: Re: [PATCH] sh: remove references to CPU_SUBTYPE_SH7764
Message-Id: <1373961269.2591.50.camel@x61.thuisdomein>
List-Id: <linux-sh.vger.kernel.org>
References: <1363002940.3137.65.camel@x61.thuisdomein>
	 <20130312075747.GB3553@linux-sh.org>
In-Reply-To: <20130312075747.GB3553@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Paul,

On Tue, 2013-03-12 at 16:57 +0900, Paul Mundt wrote:
> On Mon, Mar 11, 2013 at 12:55:40PM +0100, Paul Bolle wrote:
> > Since release v2.6.29 the tree has a few references to the Kconfig
> > symbol CPU_SUBTYPE_SH7764 and the Kconfig macro
> > CONFIG_CPU_SUBTYPE_SH7764. But the actual symbol CPU_SUBTYPE_SH7764 was
> > never added to the tree. Perhaps no one noticed because these references
> > were never used alone. Anyhow, these references serve no purpose and
> > can be removed.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> Looks fine, I suspect Iwamatsu-san let this trickle in from some vendor
> branch given that these are all his drivers. I'll queue it up, thanks.

This didn't (yet) make it into mainline. Is there an issue with this
patch? Or is it queued somewhere?


Paul Bolle

