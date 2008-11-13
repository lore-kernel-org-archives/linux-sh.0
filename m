From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Nov 2008 06:32:40 +0000
Subject: Re: [PATCH] serial: sh-sci: fix cannot work SH7723 SCIFA
Message-Id: <20081113063240.GA24769@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4918F9A9.9020704@renesas.com>
In-Reply-To: <4918F9A9.9020704@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 11, 2008 at 12:19:05PM +0900, Yoshihiro Shimoda wrote:
> SH7723 has SCIFA. This module is similer SCI register map, but it has FIFO.
> So this patch adds new type(PORT_SCIFA) and change some type checking.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

On Tue, Nov 11, 2008 at 12:19:11PM +0900, Yoshihiro Shimoda wrote:
> This patch changes sci type of SH7723 from PORT_SCI to PORT_SCIFA.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

These are applied, thanks.
