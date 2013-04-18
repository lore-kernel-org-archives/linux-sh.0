From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 18 Apr 2013 14:19:52 +0000
Subject: Re: [PATCH 1/3] ARM: also support TWD clock, instantiated from platform data
Message-Id: <20130418141952.GU14496@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 03, 2013 at 06:13:54PM +0200, Guennadi Liakhovetski wrote:
> While gradually switching clock initialisation to DT some architectures
> can have TWD device in DT, but supplying clock initialised from platform
> data. This patch adds support for such configurations to ARM.

Why can't you fix the clock problem at the same time - or sort out the
clock problem first and then add a DT description for TWD?
