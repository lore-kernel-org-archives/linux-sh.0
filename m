From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 Jul 2011 07:53:53 +0000
Subject: Re: [PATCH] shwdt: fix usage of mod_timer
Message-Id: <20110721075353.GC27831@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E26D22B.1040702@sysgo.com>
In-Reply-To: <4E26D22B.1040702@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Engraf <david.engraf@sysgo.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Jul 20, 2011 at 03:03:39PM +0200, David Engraf wrote:
> This patch fixes the usage of mod_timer and makes the driver usable. 
> mod_timer must be called with an absolute timeout in jiffies, the old 
> implementation used a relative timeout thus the hardware watchdog was 
> never triggered.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> 
Applied, thanks.
