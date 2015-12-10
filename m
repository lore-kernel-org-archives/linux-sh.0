From: Brian Norris <computersforpeace@gmail.com>
Date: Thu, 10 Dec 2015 02:18:29 +0000
Subject: Re: [PATCH] mtd: nand: Confine MTD_NAND_SH_FLCTL to SUPERH
Message-Id: <20151210021829.GG144338@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449596459-31653-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449596459-31653-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Woodhouse <dwmw2@infradead.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

On Tue, Dec 08, 2015 at 06:40:59PM +0100, Geert Uytterhoeven wrote:
> As of commit a521422ea4ae6128 ("ARM: shmobile: mackerel: Remove Legacy C
> board code"), the Renesas SuperH FLCTL driver is no longer used on ARM
> SH-Mobile SoCs. Restrict the dependencies, unless compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to l2-mtd.git
