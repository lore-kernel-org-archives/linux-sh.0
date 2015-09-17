From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Sep 2015 07:57:21 +0000
Subject: Re: [PATCH 00/03] irqchip: renesas-irqc: r8a7795 and generic chip update
Message-Id: <20150917075721.GD5414@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple>
In-Reply-To: <20150917071230.29299.32326.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, tglx@linutronix.de

Hi Magnus,

On Thu, Sep 17, 2015 at 04:12:30PM +0900, Magnus Damm wrote:
> irqchip: renesas-irqc: r8a7795 and generic chip update
> 
> [PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
> [PATCH 02/03] irqchip: renesas-irqc: Move over to generic chip
> [PATCH 03/03] irqchip: renesas-irqc: Enable nested lock
> 
> This series updates the IRQC driver with generic chip support including
> nested locking. Also the DT documentation is extended with r8a7795
> support.

Its not entirely clear what the relationship is between these patches
nor what the motivation is for the last two patches.
