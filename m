From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:10:19 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove AP4EVB board support
Message-Id: <20130612141018.GZ32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130612091819.6024.76059.sendpatchset@w520>
In-Reply-To: <20130612091819.6024.76059.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 12, 2013 at 06:18:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove board support for the sh7372 based AP4EVB board
> 
> The sh7372 SoC support code is still kept around since it
> is in use by the Mackerel board which is basically a more
> recent board where the design is based on AP4EVB.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the (new) cleanup-boot branch
along with all its dependencies.
