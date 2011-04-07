From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 07 Apr 2011 22:35:26 +0000
Subject: Re: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for sharing with other platforms
Message-Id: <201104080035.26989.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<20110407165654.GD8052@linux-sh.org> <8739lu9eg6.fsf@ti.com>
In-Reply-To: <8739lu9eg6.fsf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, April 07, 2011, Kevin Hilman wrote:
> Paul Mundt <lethal@linux-sh.org> writes:
> 
> > On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
> >> There is really nothing SH-mobile specific about this runtime PM
> >> implementation.  Any platform wanting to implement runtime PM based on
> >> simple clock gating can use this implementation.
> >> 
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >
> > This observation is wholly architecture agnostic, so it's not clear that
> > keeping it in arch/arm/common is any better. It seems that this would be
> > better suited for drivers/base/power/ with a generic Kconfig symbol.
> 
> Sounds fine to me.

Well, what platforms is the clock framework available on?

Rafael
