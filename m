From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 17 Apr 2012 07:43:21 +0000
Subject: Re: [PATCH v3] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <20120417074321.GB25751@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334213329-11242-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1334213329-11242-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 12, 2012 at 03:48:49PM +0900, Nobuhiro Iwamatsu wrote:
> In devices using ehci-sh, initialization of the PHY may be necessary.
> This adds platform data to ehci-sh and provide function to initialize PHY.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> CC: Shimoda, Yoshihiro <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
