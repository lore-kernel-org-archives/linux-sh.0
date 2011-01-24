From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Jan 2011 05:09:36 +0000
Subject: Re: [PATCH] sh: Fix build of sh7750 base boards
Message-Id: <20110124050936.GA11673@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1295833217-5799-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1295833217-5799-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 24, 2011 at 10:40:17AM +0900, Nobuhiro Iwamatsu wrote:
> Renamed platform_register_device to platform_device_register.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

I suppose there had to be something out of that huge merge conflict that
was inadverently broken. Applied, thanks.
