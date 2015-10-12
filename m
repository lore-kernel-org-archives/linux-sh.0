From: Simon Horman <horms@verge.net.au>
Date: Mon, 12 Oct 2015 00:19:06 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <20151012001905.GF20025@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Oct 10, 2015 at 08:14:45PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Actviate HDMI output of the RCar DU (and LVDS while we are here).
> Enable the HDMI encoder chip found on Lager/Koelsch boards.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up for v4.4.

Is a similar change appropriate for multi_v7_defconfig?
