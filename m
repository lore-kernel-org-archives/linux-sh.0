From: Tejun Heo <tj@kernel.org>
Date: Thu, 23 Apr 2015 14:56:51 +0000
Subject: Re: [PATCH] kernfs: remove outdated and confusing comment
Message-Id: <20150423145651.GI10738@htj.duckdns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
 <20150311114531.GB25944@htj.duckdns.org>
 <20150423125125.GB19918@katana>
In-Reply-To: <20150423125125.GB19918@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Apr 23, 2015 at 02:51:26PM +0200, Wolfram Sang wrote:
> On Wed, Mar 11, 2015 at 07:45:31AM -0400, Tejun Heo wrote:
> > On Wed, Mar 11, 2015 at 11:26:02AM +0100, Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > 
> > > Grabbing the parent is not happening anymore since 2010 (e72ceb8ccac5f7
> > > "sysfs: Remove sysfs_get/put_active_two"). Remove this confusing
> > > comment.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Acked-by: Tejun Heo <tj@kernel.org>
> 
> So, how does it go in? gkh? akpm?

Usually Greg, ah, who isn't cc'd.  Can you please repost the patch w/
Greg cc'd and my ack added?

Thanks.

-- 
tejun
