From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 05:24:52 +0000
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-Id: <20110602052452.GA6087@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>

>  arch/sh/configs/titan_defconfig            |    2 +-

Acked-by: Paul Mundt <lethal@linux-sh.org>
