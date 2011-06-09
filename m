From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 09 Jun 2011 05:06:28 +0000
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-Id: <1307595988.2874.266.camel@pasglop>
List-Id: <linux-sh.vger.kernel.org>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2011-06-02 at 00:29 +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
> 
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---

For powerpc:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Ben.


