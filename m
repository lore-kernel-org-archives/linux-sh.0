From: Simon Horman <horms@verge.net.au>
Date: Thu, 25 Oct 2012 00:29:51 +0000
Subject: Re: [PATCH 0/3] Use generic helper scu_power_mode()
Message-Id: <20121025002950.GK28496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1351068858-7255-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1351068858-7255-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 24, 2012 at 10:54:15AM +0200, Bastian Hecht wrote:
> The shmobile series implements its own code for setting the SCU power
> register of the ARM MPCore. It uses 32-bit wide access and thus needs
> locking as multiple CPUs might access it simultaneously for change. There is
> already a small helper function that avoids the overhead by using 8-bit
> wide access: As every CPU only accesses its own field we can drop the
> lock and use it.

Hi Bastian,

thanks, these look good to me.
Would it be possible for you to repost them with
linux-arm-kernel@lists.infradead.org added to the CC list?

I realise this is a bit of a pain but I have been asked that
patches appear there for review before I ask the arm-soc people
to pull them.
