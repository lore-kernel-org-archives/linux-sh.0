From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Mon, 19 Nov 2012 12:30:59 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <50AA2683.1070502@mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353288254-6211-1-git-send-email-horms@verge.net.au>
 <1353288254-6211-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1353288254-6211-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 19-11-2012 5:24, Simon Horman wrote:

> From: Bastian Hecht <hechtb@gmail.com>

> Since commit 3c7ea4eccfd2e

    Please also specify that commit summary in parens.

> the sh_flctl driver requires the error IRQ line to
> signal failed transactions between the flash controller and the NAND chip.
> This information is mandatory - else the driver refuses to start up. We
> provide it here for the board mackerel.

> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

WBR, Sergei

