From: Brian Norris <computersforpeace@gmail.com>
Date: Wed, 30 Sep 2015 20:53:24 +0000
Subject: Re: [PATCH] sh: mach-rsk: remove unnecessary MTD partition probe specification
Message-Id: <20150930205324.GJ143959@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431991470-22388-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1431991470-22388-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

On Mon, May 18, 2015 at 04:24:30PM -0700, Brian Norris wrote:
> The cmdlinepart parser is already supported in the default probe.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

SuperH is "orphaned", but this patch is trivial. Applied to l2-mtd.git.
