From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 30 Apr 2015 02:12:11 +0000
Subject: [PATCH 0/1 v2] spi: Re-do the returning value of rspi_dma_check_then_transfer
Message-Id: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Mark
Hi Geert

This is version 2 of spi-Re-do-the-returning-value-of-rspi_dma_check_then_transfer patch.
I have tested it at linux Upstream Linux-4.0.0-10713-g6e24fd1 on Lager and Koelsch.
To reduce indentation and complexity of code, drop "ret" then function 
rspi_dma_check_then_transfer should be returning rspi_dma_transfer directly
after checking error.
Please consider the following patch for the Rcar-Gen2.

Hiep Cao Minh (1):
  spi: Re-do the returning value of rspi_dma_check_then_transfer

 drivers/spi/spi-rspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
1.9.1

