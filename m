From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 Mar 2012 06:58:25 +0000
Subject: Re: [PATCH v2] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <20120321065824.GA26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 21, 2012 at 03:47:00PM +0900, Nobuhiro Iwamatsu wrote:
> In devices using ehci-sh, initialization of the PHY may be necessary.
> This adds platform data to ehci-sh and provide function to initialize PHY.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> CC: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>

It's impossible to say whether this makes sense or not without first
seeing what you are trying to do in the callback.
