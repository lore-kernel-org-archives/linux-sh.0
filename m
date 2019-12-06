From: <nobuhiro1.iwamatsu@toshiba.co.jp>
Date: Fri, 06 Dec 2019 21:11:00 +0000
Subject: RE: [PATCH] usb: host: ehci-sh: Remove unused platform data support
Message-Id: <TY2PR01MB32430C9489120D90A250A6D5925F0@TY2PR01MB3243.jpnprd01.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191206132849.29406-1-geert+renesas@glider.be>
In-Reply-To: <20191206132849.29406-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: geert+renesas@glider.be, stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert+renesas@glider.be]
> Sent: Friday, December 6, 2019 10:29 PM
> To: Alan Stern <stern@rowland.harvard.edu>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: iwamatsu nobuhiro(岩松 信洋 ○ＳＷＣ□ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; linux-usb@vger.kernel.org;
> linux-sh@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] usb: host: ehci-sh: Remove unused platform data support
> 
> ehci_sh_platdata was never used, remove it. It can be resurrected from
> git history when needed.
> 
> This basically reverts commit 3e0c70d050c7ed6d ("usb: ehci-sh: Add PHY
> init function with platform data").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro
