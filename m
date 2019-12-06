From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 06 Dec 2019 15:06:46 +0000
Subject: Re: [PATCH] usb: host: ehci-sh: Remove unused platform data support
Message-Id: <Pine.LNX.4.44L0.1912061006170.1618-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20191206132849.29406-1-geert+renesas@glider.be>
References: <20191206132849.29406-1-geert+renesas@glider.be>
In-Reply-To: <20191206132849.29406-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, 6 Dec 2019, Geert Uytterhoeven wrote:

> ehci_sh_platdata was never used, remove it. It can be resurrected from
> git history when needed.
> 
> This basically reverts commit 3e0c70d050c7ed6d ("usb: ehci-sh: Add PHY
> init function with platform data").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
