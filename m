From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 02:41:19 +0000
Subject: Re: [PATCH] Fix debugfs_create_dir's error checking method for arch/sh/kernel/
Message-Id: <20081020024119.GC19416@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48F87615.60302@cn.fujitsu.com> <48F8760F.4070909@cn.fujitsu.com>
In-Reply-To: <48F87615.60302@cn.fujitsu.com> <48F8760F.4070909@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 17, 2008 at 07:25:03PM +0800, Zhaolei wrote:
> debugfs_create_dir() returns NULL if an error occurs, returns -ENODEV
> when debugfs is not enabled in the kernel.
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>

On Fri, Oct 17, 2008 at 07:25:09PM +0800, Zhaolei wrote:
> debugfs_create_file() returns NULL if an error occurs, returns -ENODEV
> when debugfs is not enabled in the kernel.
> 
> Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>

Applied, thanks.
