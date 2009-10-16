From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 16 Oct 2009 04:59:42 +0000
Subject: Re: [PATCH] sh4:  using PAGE_SIZE during flushing cache related to a page
Message-Id: <20091016045942.GA2952@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4AD44CF4.7050802@siemens.com>
In-Reply-To: <4AD44CF4.7050802@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 13, 2009 at 01:48:36PM +0400, Valentin R Sitsikov wrote:
> Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
> ---
> arch/sh/mm/cache-sh4.c |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)
> 
This looks ok, but your mail client has unfortunately completely mangled
the patch. Your user-agent string suggests you are using a thunderbird
clone, so please give Documentation/email-clients.txt a read and fixing
up your client so that future patches don't need to be applied by hand.
