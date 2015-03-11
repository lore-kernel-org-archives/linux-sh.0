From: Tejun Heo <tj@kernel.org>
Date: Wed, 11 Mar 2015 11:45:31 +0000
Subject: Re: [PATCH] kernfs: remove outdated and confusing comment
Message-Id: <20150311114531.GB25944@htj.duckdns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Mar 11, 2015 at 11:26:02AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Grabbing the parent is not happening anymore since 2010 (e72ceb8ccac5f7
> "sysfs: Remove sysfs_get/put_active_two"). Remove this confusing
> comment.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Tejun Heo <tj@kernel.org>

> Found while trying to find out why my sysfs-bin file always returns POLLPRI
> after opening, reading, polling. Any pointers while I am here? :)

Hmm... poll isn't hooked up for bin files and the behavior isn't well
defined either.  The open file's event counter is never synchronized
to the backing node's.  Before the first kernfs_notify(), it won't
trigger and after always.  We'll prolly need to define that better.
What's the use case that you're interested in?

Thanks.

-- 
tejun
