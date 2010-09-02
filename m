From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 02 Sep 2010 13:47:32 +0000
Subject: Re: [RFC] [PATCH v2] arm & sh: factorised duplicated clkdev.c
Message-Id: <20100902134732.GL26319@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283253402-3139-1-git-send-email-plagnioj@jcrosoft.com>
	<1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100902132641.GI14214@pengutronix.de>
In-Reply-To: <20100902132641.GI14214@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 02, 2010 at 03:26:41PM +0200, Uwe Kleine-K=F6nig wrote:
> I'm not very satisfied by Russell's answer.  But even if I accept that
> it should not move to .init.text, why .ref.text?  If I'm not mistaken
> clkdev_alloc references the following non-local symbols:
>=20
> 	__clkdev_alloc
> 	strlcpy
> 	vscnprintf

__clkdev_alloc() is an inline function, so effectively it's part of this
function.  On sh, this calls the boot time allocator which is marked as
__init if the normal memory allocators aren't online yet.

> Russell, would at least __module_or_init be OK?

It's a conceptual thing - we want to allow people to create aliases at
run time.  Making it an __init thing will only encourage people to do
silly things to work around the "it can only be used at init time"
problem rather than taking the obvious step of removing the __init tag.

Make it easy for people to do the right thing.
