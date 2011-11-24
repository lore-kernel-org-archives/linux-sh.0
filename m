From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Thu, 24 Nov 2011 06:47:14 +0000
Subject: Re: [PATCH 6/7] ARM: restart: only perform setup for restart when
Message-Id: <20111124064714.GI795@wantstofly.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
In-Reply-To: <20111117174247.GF9581@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 17, 2011 at 05:42:47PM +0000, Russell King - ARM Linux wrote:

> Ack?
> 
> (If you're in the To: list I'm expecting a reply because this patch is
> touching something you're responsible for.  Thanks.)
> 
> On Sun, Nov 06, 2011 at 05:33:35PM +0000, Russell King - ARM Linux wrote:
> > We only need to set the system up for a soft-restart if we're going to
> > be doing a soft-restart.  Provide a new function (soft_restart()) which
> > does the setup and final call for this, and make platforms use it.
> > Eliminate the call to setup_restart() from the default handler.
> > 
> > This means that platforms arch_reset() function is no longer called with
> > the page tables prepared for a soft-restart, and caches will still be
> > enabled.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Lennert Buytenhek <buytenh@wantstofly.org>
