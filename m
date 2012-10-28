From: Simon Horman <horms@verge.net.au>
Date: Sun, 28 Oct 2012 03:11:17 +0000
Subject: Re: [PATCH 0/3] Use generic helper scu_power_mode()
Message-Id: <20121028031117.GS3743@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1351162702-8391-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1351162702-8391-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 25, 2012 at 12:58:19PM +0200, Bastian Hecht wrote:
> Reposted to include the arch/arm mailing list.
> 
> The shmobile series implements its own code for setting the SCU power
> register of the ARM MPCore. It uses 32-bit wide access and thus needs
> locking as multiple CPUs might access it simultaneously for change. There is
> already a small helper function that avoids the overhead by using 8-bit
> wide access: As every CPU only accesses its own field we can drop the
> lock and use it.

Thanks,

these look good to me. I will push them to the boards branch once
its current pull request has been processed by the arm-soc people.

