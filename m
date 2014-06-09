From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 09 Jun 2014 09:32:57 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove duplicate i2c3 nodes
Message-Id: <53957F49.40905@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1402279784-5587-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1402279784-5587-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/06/14 03:09, Simon Horman wrote:
> Due to an error when merging df40f256b18300e1 ("ARM: shmobile:
> lager: add i2c1, i2c2 pins") a duplicate i2c3 node.
> 
> This patch moves the duplicate and moves to old node to
> be closer to the other new i2c nodes.
> 
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
