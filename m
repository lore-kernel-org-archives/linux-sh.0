From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Aug 2013 07:46:21 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Mount root file systems in r/w mode for all DT platforms
Message-Id: <20130805074620.GI15796@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 29, 2013 at 10:31:41PM +0200, Laurent Pinchart wrote:
> The shmobile DT files available in the kernel are reference
> implementations intended to be used as sample code, as well as for
> development. As such, it makes sense to mount the root file system in
> read/write mode by default.

Thanks, I have queued this up for v3.12 in the dt2 branch.
