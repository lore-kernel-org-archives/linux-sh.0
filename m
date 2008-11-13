From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Nov 2008 06:33:51 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: fix wrong data access in SuperH on-chip USB
Message-Id: <20081113063351.GB24769@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49193889.1080700@renesas.com>
In-Reply-To: <49193889.1080700@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 11, 2008 at 04:47:21PM +0900, Yoshihiro Shimoda wrote:
> When I used SuperH on-chip USB, there was the problem that accessed
> r8a66597_root_hub which was not allocated.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

I've applied this also for 2.6.28, I'll send it out with the rest of the
updates later today, thanks.
